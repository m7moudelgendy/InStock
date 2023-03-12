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
        // #warning Incomplete implementation, return the number of rows
        
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
        //order.price = Double(cart.products.first?.price ?? "")
        order.price = 222.22
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

