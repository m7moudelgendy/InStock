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
    var quantity = 1
    var totalPrice = 0.0
    @IBOutlet weak var cartTable: UITableView!
    
    @IBOutlet weak var subTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if CartRepo().local.isExist() {
            cart = CartRepo().local.get()!
        }
        DispatchQueue.main.async { [self] in
            for item in cart.products {
                totalPrice += (item.price as NSString).doubleValue
            }
            subTotal.layer.borderColor = UIColor.darkGray.cgColor
            subTotal.layer.borderWidth = 3.0
            subTotal.text = "  Sub Total:  \(totalPrice) EGP"
            cartTable.reloadData()
        }
        
        cartTable.reloadData()
       
    }
    @IBAction func plusBtn(_ sender: Any) {
        quantity+=1
        self.cartTable.reloadData()
    }
    
    @IBAction func minusBtn(_ sender: Any) {
        if(quantity==1)
        {
            quantity = 1
            self.cartTable.reloadData()
            
        }else
        {
            quantity-=1
            self.cartTable.reloadData()
        }
  
    }
    
    @IBAction func btnProceedClicked(_ sender: Any) {
        
        let placeVC = self.storyboard?.instantiateViewController(withIdentifier: "PlaceOrderVC") as! PlaceOrderVC
        placeVC.subPayments = totalPrice
        //present(placeVC, animated: true, completion: nil)
        //payMethod.totalPayments = NSDecimalNumber(string: "\(totalPrice)")
        self.navigationController?.pushViewController(placeVC, animated: true)
        
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
        cell.productQuantity.text = "\(quantity)"
        
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
