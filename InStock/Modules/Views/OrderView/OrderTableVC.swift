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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.orders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = "Created at : " + "\(viewModel.orders[indexPath.row].created_at ?? "")"
        cell.detailTextLabel?.text = "Price : " + "\(viewModel.orders[indexPath.row].current_subtotal_price ?? "")"
        cell.textLabel?.font = UIFont(name: "Helvetica Neue", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica Neue", size: 16)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
