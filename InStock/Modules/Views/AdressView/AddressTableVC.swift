//
//  AddressTableVC.swift
//  InStock
//
//  Created by ElGendy on 10/03/2023.
//

import UIKit

protocol TableViewProtocol : AnyObject {
    func renderTable()
}

class AddressTableVC: UITableViewController,TableViewProtocol {

    var viewModel : AdressViewModel!
    var cart : CartModel!
    var totalOrderPrice : Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AdressViewModel()
        cart = CartModel()
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getAllAddressForCustomer()
        viewModel.bindResultToAdressView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderTable()
            }
        }
        
        
    }
    func renderTable() {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.result.count == 0 {
        tableView.setEmptyAddressView(title: "You don't have any Shipping Address", message: "You Must Add Address.")
        }
        else {
        tableView.restoreAddress()
        }
        return viewModel.result.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let str = "\(viewModel.result[indexPath.row].country ?? "") ,  \(viewModel.result[indexPath.row].city ?? "")"
          
            cell.textLabel?.text = str
            cell.detailTextLabel?.text = viewModel.result[indexPath.row].address1
            cell.textLabel?.font = UIFont(name: "Helvetica Neue", size: 18)
            cell.detailTextLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        AddressNetworkManger.deleteAddress(userAddress: viewModel.result[indexPath.row], addID: viewModel.result[indexPath.row].id!) { _, _, _ in
        }

        if(viewModel.result.count==1){
            let alert = UIAlertController(title: "Default Address", message: "Can't Delete Default Address", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }else {
            viewModel.result.remove(at: indexPath.row)
            renderTable()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if CartRepo().local.isExist() {
            cart = CartRepo().local.get()!
        }
        let order = LineItem()
        order.title = cart.products.first?.title
        order.price = totalOrderPrice
        let newOrder = Orders()
        newOrder.line_items = [order]
        let allOrder = AllOrders()
        allOrder.order = newOrder
        OrederNetworkManger.addNewOrder(userOrder: allOrder) { _, _, _ in   }
        
        CartRepo().local.delete(key: .Cart)
      
        let alert = UIAlertController(title: "Congratulations", message: "Your Order has Submitted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel , handler: { _ in
            let home = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(home, animated: true)
        }))
        present(alert, animated: true)
        
    }
}
extension UITableView {
    func setEmptyAddressView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restoreAddress() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}


