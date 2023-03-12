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
    
    var viewModel : HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
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
