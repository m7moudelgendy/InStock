//
//  OrderTableVC.swift
//  InStock
//
//  Created by Rezk on 12/03/2023.
//

import UIKit
protocol OrderViewProtocol : AnyObject {
    
    func renderOrderTable()
}


class OrderTableVC: UITableViewController , OrderViewProtocol{
    
    func renderOrderTable() {
        tableView.reloadData()
    }
    

    var viewModel : HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()

    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.bindResultToHomeView = {
            
            DispatchQueue.main.async{ [self] in
                renderOrderTable()
            }
        }
        viewModel.getOrders()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.orders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = "Created at : " + "\(viewModel.orders[indexPath.row].created_at ?? "")"
        cell.detailTextLabel?.text = "Price : " + "\(viewModel.orders[indexPath.row].current_subtotal_price ?? "")"
        cell.textLabel?.font = UIFont(name: "Helvetica Neue", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica Neue", size: 16)
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
