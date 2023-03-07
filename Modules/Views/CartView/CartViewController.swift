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
    @IBOutlet weak var cartTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if CartRepo().local.isExist() {
            cart = CartRepo().local.get()!
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
        cell.productPrice.text = "\(cart.products[indexPath.row].price) EGP"
        cell.productQuantity.text = "\(quantity)"
        return cell
    }
    
//    private func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
//    {
//        cart.products.remove(at: indexPath.row)
//        CartRepo().local.store(key: .Cart, object: cart)
//        cartTable.reloadData()
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cart.products.remove(at: indexPath.row)
        CartRepo().local.store(key: .Cart, object: cart)
        cartTable.reloadData()
    }
}
