//
//  CartViewController.swift
//  InStock
//
//  Created by ElGendy on 06/03/2023.
//

import UIKit
import Kingfisher

class CartViewController: UIViewController {

    var cart = CartModel()
    let userArr = CoreDataManager.FetchFromCoreData()
    var quantity = 1
    var totalPrice = 0.0
    @IBOutlet weak var cartTable: UITableView!
    
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var subTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView.clipsToBounds = true
        cartView.layer.cornerRadius = 20
        cartView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        if CartRepo().local.isExist() {
            cart = CartRepo().local.get()!
        }
        DispatchQueue.main.async { [self] in
            for item in cart.products {
                totalPrice += (item.price as NSString).doubleValue
            }
            subTotal.text = " \(totalPrice) EGP"
            cartTable.reloadData()
        }
        
        cartTable.reloadData()
       
    }
    @IBAction func plusBtn(_ sender: Any) {
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: self.cartTable)
        if let indexPath = self.cartTable.indexPathForRow(at: buttonPosition) {
            let product = cart.products[indexPath.row]
            product.quantity += 1
            totalPrice += (product.price as NSString).doubleValue
            subTotal.text = " \(totalPrice) EGP"
            self.cartTable.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    @IBAction func minusBtn(_ sender: Any) {
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: self.cartTable)
        if let indexPath = self.cartTable.indexPathForRow(at: buttonPosition) {
            
            let product = cart.products[indexPath.row]
            if product.quantity > 1 {
                product.quantity -= 1
                totalPrice -= (product.price as NSString).doubleValue
                subTotal.text = " \(totalPrice) EGP"
                self.cartTable.reloadRows(at: [indexPath], with: .none)
            }
        }
        
    }
    
    @IBAction func btnProceedClicked(_ sender: Any) {
        
    
        if( userArr.count == 0){
            let alert = UIAlertController(title: "Requierd Sign In", message: "You have to Sign In", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel , handler: { _ in
                let sign = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                
                self.navigationController?.pushViewController(sign, animated: true)
            }))
            present(alert, animated: true)
        }else{
            
            let placeVC = self.storyboard?.instantiateViewController(withIdentifier: "PlaceOrderVC") as! PlaceOrderVC
            placeVC.subPayments = totalPrice
            
            self.navigationController?.pushViewController(placeVC, animated: true)
        }
    }
}
extension CartViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cart.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell")as! CartViewCell
        let url = URL(string: cart.products[indexPath.row].imageUrl)
        cell.productImage.kf.setImage(with: url)
        cell.productName.text = cart.products[indexPath.row].title
        cell.productPrice.text = cart.products[indexPath.row].price
        cell.productQuantity.text = "\(cart.products[indexPath.row].quantity)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        totalPrice -= (cart.products[indexPath.row].price as NSString).doubleValue
        cart.products.remove(at: indexPath.row)
        CartRepo().local.store(key: .Cart, object: cart)
        
        subTotal.text = "  Sub Total:  \(totalPrice) EGP"
        cartTable.reloadData()
    }
}
