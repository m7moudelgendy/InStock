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
    
    @IBOutlet weak var subTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Shopping Cart"
        if CartRepo().local.isExist() {
            cart = CartRepo().local.get()!
        }
        DispatchQueue.main.async { [self] in
            for item in cart.products {
                totalPrice += (item.price as NSString).doubleValue
            }
            subTotal.text = " SubTotal =  \(totalPrice) EGP"
            subTotal.layer.borderColor = UIColor.white.cgColor
            subTotal.layer.borderWidth = 1
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
            subTotal.text = " SubTotal =  \(totalPrice) EGP"
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
                subTotal.text = " SubTotal =  \(totalPrice) EGP"
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
        
        if cart.products.count == 0 {
        tableView.setEmptyCartView(title: "You don't have any product in cart.", message: "Your Cart Is Empty." , image: "cart")
        }
        else {
        tableView.restore()
        }
        return cart.products.count
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
        subTotal.text = " SubTotal =  \(totalPrice) EGP"
        cart.products.remove(at: indexPath.row)
        CartRepo().local.store(key: .Cart, object: cart)
        
        cartTable.reloadData()
    }
    
    
}

extension UITableView {
    func setEmptyCartView(title: String, message: String , image :String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "Georgia-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "Georgia-Regular", size: 17)
        let image = UIImage(named: image)
         let noDataImage = UIImageView(image: image)
         noDataImage.frame = CGRect(x: 30, y: 145, width: 350, height: 350)
        emptyView.addSubview(noDataImage)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.topAnchor.constraint(equalTo: noDataImage.bottomAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
