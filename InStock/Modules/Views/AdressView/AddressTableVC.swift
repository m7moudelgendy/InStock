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
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AdressViewModel()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        viewModel.bindResultToAdressView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderTable()
            }
        }
        
        viewModel.getAllAddressForCustomer()
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
        if (viewModel.result.count == 0){
            let alert = UIAlertController(title: "Add Address", message: "Please Address for shipping", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel,handler: {  _ in
            
                let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddAddressVC") as! AddAddressVC
                self.navigationController?.pushViewController(addVC, animated: true)
            }))
            present(alert, animated: true)
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
        viewModel.result.remove(at: indexPath.row)
        renderTable()
        
    }


}
