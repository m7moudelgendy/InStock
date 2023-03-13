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
    
    @IBOutlet weak var settingTableView: UITableView!
    var setting = ["Address","Currency","Contact us","About us"]
    var arr = [" Location","  EGP","",""]
    var viewModel : HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        let user = CoreDataManager.FetchFromCoreData()
        let userName = (user.first?.value(forKey: "firstName"))! as! String
    
        userNameLabel.text = "Hi" + "" +userName
        settingTableView.isScrollEnabled = false
        
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
        return setting.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")as! SettingViewCell
        
        cell.settingLabel.text = setting[indexPath.section]
        cell.infoLabel.text = arr[indexPath.section]
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let tableVC = self.storyboard?.instantiateViewController(withIdentifier: "AddressTableVC") as! AddressTableVC
            self.navigationController?.pushViewController(tableVC, animated: true)
        
        case 2:
            let contactVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
            self.navigationController?.pushViewController(contactVC, animated: true)
        case 3:
            let aboutVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
            self.navigationController?.pushViewController(aboutVC, animated: true)
        default :
            break
            
        }
        
    }
    
    
}




