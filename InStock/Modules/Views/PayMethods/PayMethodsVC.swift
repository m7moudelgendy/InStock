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
