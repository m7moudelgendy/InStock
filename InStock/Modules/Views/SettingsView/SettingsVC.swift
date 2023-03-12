//
//  CartViewController.swift
//  InStock
//
//  Created by ElGendy on 11/03/2023.
//

import UIKit

class SettingsVC: UIViewController {
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    
    var setting : [String]?
    var viewModel : HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        
        setting = ["Address","Currency","Contact us","About us"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.bindResultToHomeView = {
            
            DispatchQueue.main.async{ [self] in
                orderPriceLabel.text = "Price : " + "\(viewModel.orders.first?.current_subtotal_price ?? "")"
                orderDateLabel.text = "Created at : " + "\(viewModel.orders.first?.created_at ?? "")"
            }
        }
        viewModel.getOrders()
        
    }
}
extension SettingsVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return setting!.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.setting![indexPath.section]

        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("You tapped cell number \(indexPath.section).")
    }
    
    
}




