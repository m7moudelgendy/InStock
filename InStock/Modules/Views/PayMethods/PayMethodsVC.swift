//
//  PayMethodsVC.swift
//  InStock
//
//  Created by ElGendy on 08/03/2023.
//

import UIKit
import PassKit

class PayMethodsVC: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
    
    @IBOutlet weak var payMethodsTable: UITableView!
    var unchecked = true
    var payCheck = 0
    var totalPayments : NSDecimalNumber?
    let sections = ["Online Payment","More Payment Option"]
    var arr = [["Apple Pay"] , ["Cash On Delivery"]]
    
    private lazy var paymentRequest : PKPaymentRequest = {
        
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.iti.PaymentMethodDemo"
        request.supportedNetworks = [.quicPay , .masterCard , .visa]
        request.supportedCountries = ["US","EG"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "EG"
        request.currencyCode = "EGP"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "iphone", amount: totalPayments!)]
        return request
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnPayClicked(_ sender: Any) {
        
        switch payCheck {
        case 1 :
            applePay()
        case 2:
            cashPay()
        default:
            let alert = UIAlertController(title: "Choice Payment", message: "Please Select a Payment Method", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            break
        }
    }
    func applePay(){
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        if controller != nil {
            controller!.delegate = self
            present(controller!, animated: true, completion: nil)
        }
        
    }
    func cashPay(){
        let tableVC = self.storyboard?.instantiateViewController(withIdentifier: "AddressTableVC") as! AddressTableVC
        tableVC.totalOrderPrice = totalPayments as? Double
        self.navigationController?.pushViewController(tableVC, animated: true)
        
    }
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        
        controller.dismiss(animated: true, completion: nil)
        
                
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        let tableVC = self.storyboard?.instantiateViewController(withIdentifier: "AddressTableVC") as! AddressTableVC
        self.navigationController?.pushViewController(tableVC, animated: true)
    }
}

extension PayMethodsVC : UITableViewDataSource ,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 58.0
   }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0.9725490196, green: 0.9098039216, blue: 0.9137254902, alpha: 0.3691322064)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = #colorLiteral(red: 0.1628514225, green: 0.1628514225, blue: 0.1628514225, alpha: 1)
        header.textLabel?.textAlignment = .center
        header.textLabel?.font = UIFont(name: "Georgia Bold", size: 18)!
        tableView.sectionHeaderTopPadding = 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = payMethodsTable.dequeueReusableCell(withIdentifier: "payCell", for: indexPath)
        
        cell.textLabel?.text = arr[indexPath.section][indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.568627451, green: 0.1921568627, blue: 0.4588235294, alpha: 1)
        cell.textLabel?.font = UIFont(name: "Georgia Bold", size: 20)
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath == [0,0]){
            payCheck = 1
            if payMethodsTable.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
                payMethodsTable.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                payCheck = 0
            }else
            {
                payMethodsTable.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                payMethodsTable.cellForRow(at: [1,0])?.accessoryType = UITableViewCell.AccessoryType.none
            }
        }else{
            
            payCheck = 2
            if payMethodsTable.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
                payMethodsTable.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                payCheck = 0
            }else
            {
                payMethodsTable.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                payMethodsTable.cellForRow(at: [0,0])?.accessoryType = UITableViewCell.AccessoryType.none
            }
        }
    }
    
    
    
}
