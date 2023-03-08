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
    var payCheck = false
    let sections = ["Online Payment","More Payment Option"]
    var arr = [["Apple Pay"] , ["Cash On Delivery"]]
    
    private var paymentRequest : PKPaymentRequest = {
        
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.iti.PaymentMethodDemo"
        request.supportedNetworks = [.quicPay , .masterCard , .visa]
        request.supportedCountries = ["US","EG"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "EG"
        request.currencyCode = "EGP"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "iphone", amount: 15000)]
        return request
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func btnPayClicked(_ sender: Any) {
        if (payCheck == true) {
            applePay()
        }else{
            cashPay()
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
//        let imgVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
//        self.navigationController?.pushViewController(imgVC, animated: true)
        
    }
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        
        controller.dismiss(animated: true, completion: nil)
        
        
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
//        let imageVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
//        self.navigationController?.pushViewController(imageVC, animated: true)
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
        return 51
   }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.lightGray
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        //header.backgroundColor = UIColor.gray
        header.textLabel?.font = UIFont(name: "Futura", size: 20)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = payMethodsTable.dequeueReusableCell(withIdentifier: "payCell", for: indexPath)
        
        cell.textLabel?.text = arr[indexPath.section][indexPath.row]
        cell.textLabel?.font = UIFont(name: "Futura", size: 32)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath == [0,0]){
            print("Hamza")
            payCheck = true
            if payMethodsTable.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
                payMethodsTable.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                payCheck = false
            }else
            {
                payMethodsTable.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                payCheck = true
            }

        }else{
            print("mahmoud")
            payCheck = false
            if payMethodsTable.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
                payMethodsTable.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                payCheck = true
            }else
            {
                payMethodsTable.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                payCheck = false
            }
        }
    }
    
    
    
}
