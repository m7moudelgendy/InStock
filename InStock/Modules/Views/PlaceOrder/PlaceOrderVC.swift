//
//  PlaceOrderVC.swift
//  InStock
//
//  Created by ElGendy on 09/03/2023.
//

import UIKit

class PlaceOrderVC: UIViewController {

    @IBOutlet weak var subTotalName: UILabel!
    @IBOutlet weak var subTotalLB: UILabel!
    
    @IBOutlet weak var ShippingFeesValue: UILabel!
    @IBOutlet weak var ShiipingFeesLB: UILabel!
    @IBOutlet weak var couponTF: UITextField!
    
    @IBOutlet weak var couponValueLB: UILabel!
    @IBOutlet weak var discountLB: UILabel!
    @IBOutlet weak var grandTotalLB: UILabel!
    //3lbaa
    var subPayments : Double?
    var grandTotal : Double?
    var grandTotalNotValid : Double = 0.0
    var discount : Double?
    var discountNotValid : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editLabelFrames()
        subTotalLB.text = "\(subPayments ?? 100) EGP"
        if(grandTotal == nil){
            grandTotalNotValid = subPayments!
            discountNotValid = 0
            couponValueLB.text = "\(discountNotValid ?? 100) EGP"
            grandTotalLB.text = "  Sub Total:  \(grandTotalNotValid + 30 ) EGP"
        }
 
    }
    @IBAction func btnPlaceOrderClicked(_ sender: Any) {
        let payVC = self.storyboard?.instantiateViewController(withIdentifier: "PayMethodsVC") as! PayMethodsVC
        if grandTotal == nil{
            payVC.totalPayments = NSDecimalNumber(string: "\(grandTotalNotValid + 30)")
        }else{
            payVC.totalPayments = NSDecimalNumber(string: "\(grandTotal! + 30)")
        }
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.pushViewController(payVC, animated: true)
        
    }
    @IBAction func btnValidateClicked(_ sender: Any) {
        grandTotal = subPayments!
        var discount = 0.0
        switch couponTF.text {
        case "coupon20" :
            grandTotal! = grandTotal! - (grandTotal! * (20/100))
            discount = (subPayments!) * (20/100)
            couponValueLB.text = "\(discount) EGP"
            grandTotalLB.text = "  Sub Total:  \(grandTotal! + 30 ) EGP"
            break
        case "coupon50" :
            grandTotal! = grandTotal! - (grandTotal! * (50/100))
            discount = (subPayments! ) * (50/100)
            couponValueLB.text = "\(discount) EGP"
            grandTotalLB.text = "  Sub Total:  \(grandTotal! + 30 ) EGP"
            break
        case "coupon70" :
            grandTotal! = grandTotal! - (grandTotal! * (70/100))
            discount = (subPayments!) * (70/100)
            couponValueLB.text = "\(discount) EGP"
            grandTotalLB.text = "  Sub Total:  \(grandTotal! + 30 ) EGP"
            break
        default :
            grandTotal! = subPayments!
            discount = 0
            couponValueLB.text = "\(discount) EGP"
            grandTotalLB.text = "  Sub Total:  \(grandTotal! + 30 ) EGP"
            break
        }
        
    }
}
//edit Gui
extension PlaceOrderVC {
    func editLabelFrames(){
        subTotalLB.layer.borderColor = UIColor.purple.cgColor
        subTotalLB.layer.borderWidth = 3.0
        subTotalName.layer.borderColor = UIColor.purple.cgColor
        subTotalName.layer.borderWidth = 3.0
        ShippingFeesValue.layer.borderColor = UIColor.purple.cgColor
        ShippingFeesValue.layer.borderWidth = 3.0
        ShiipingFeesLB.layer.borderColor = UIColor.purple.cgColor
        ShiipingFeesLB.layer.borderWidth = 3.0
        
        couponValueLB.layer.borderColor = UIColor.purple.cgColor
        couponValueLB.layer.borderWidth = 3.0
        discountLB.layer.borderColor = UIColor.purple.cgColor
        discountLB.layer.borderWidth = 3.0
        grandTotalLB.layer.borderColor = UIColor.purple.cgColor
        grandTotalLB.layer.borderWidth = 3.0
        
    }
}
