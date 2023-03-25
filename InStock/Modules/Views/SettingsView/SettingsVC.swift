//
//  CartViewController.swift
//  InStock
//
//  Created by ElGendy on 11/03/2023.
//

import UIKit
import CoreData

class SettingsVC: UIViewController {
    
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    
    @IBOutlet weak var settingTableView: UITableView!
    var setting = ["Address","Currency","Contact us","About"]
    var arr = [" Location","  EGP","",""]
    var viewModel : HomeViewModel!
    var fetchArr = [NSManagedObject]()
    var wishListArr = [NSManagedObject]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

        fetchArr = CoreDataManager.FetchFromCoreData()
         viewModel = HomeViewModel()
         let userName = (fetchArr.first?.value(forKey: "firstName"))! as! String
        let LastName = (fetchArr.first?.value(forKey: "lastName"))! as! String
        let email = (fetchArr.first?.value(forKey: "email"))! as! String

        userNameLabel.text = "Hi, " + " " +  userName
        fullNameLabel.text = userName + " " + LastName
        emailLabel.text = email
        settingTableView.isScrollEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchArr = CoreDataManager.FetchFromCoreData()
         wishListArr = ProductCoreDataManager.FetchProFromCoreData()

        viewModel.bindResultToHomeView = {
            
            DispatchQueue.main.async{ [self] in
                orderPriceLabel.text = "Price : " + "\(viewModel.orders.first?.current_subtotal_price ?? "")" + " EGP"
                orderDateLabel.text = "Created at : " + "\(viewModel.orders.first?.created_at ?? "")"
            }
        }
        viewModel.getOrders()
        
    }
    
    
    @IBAction func logOut(_ sender: Any) {
 
        for _ in 0...fetchArr.count {
                CoreDataManager.DeleteFromCoreData()
            }
        for _ in 0..<wishListArr.count {
             ProductCoreDataManager.DeleteAllWishlistFromCoreData()
            }
            CartRepo().local.delete(key: .Cart)
            let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "welcomeViewController") as! welcomeViewController

               self.navigationController?.pushViewController(welcomeVC, animated: true)
            
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
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 14
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




