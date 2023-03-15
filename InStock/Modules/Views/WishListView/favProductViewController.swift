//
//  favProductViewController.swift
//  InStock
//
//  Created by Hader on 10/3/23.
//

import UIKit
import Kingfisher

class favProductViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var productArr = ProductCoreDataManager.FetchProFromCoreData()
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async{
            self.tableView.reloadData()
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    

}

extension favProductViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //       var  arr = ProductCoreDataManager.FetchProFromCoreData()
        if productArr.count == 0 {
            print(productArr.count)
            tableView.setEmptyFavView(title: "There 's No Products In Wishlist.", message: "Please Add Products." , image: "wishlist")
            }
            else {
            tableView.restoreFav()
            }
        return productArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! favTableViewCell
        let img = (productArr[indexPath.row].value(forKey: "proLink")) as? String ?? ""
        let imgLink = URL(string:img)
        cell.proImage.kf.setImage(with: imgLink)
        cell.proName.text = productArr[indexPath.row].value(forKey: "proName") as? String
        cell.proPrice.text = productArr[indexPath.row].value(forKey: "proPrice") as? String
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title:"", message: "Delete this product from wish list ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [self] UIAlertAction in
            ProductCoreDataManager.DeleteProFromCoreData(index: indexPath.row)
            productArr.remove(at: indexPath.row)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { [self] UIAlertAction in
            dismiss(animated: true)
            self.tableView.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        self.tableView.reloadData()
        
    }}
   
extension UITableView {
    func setEmptyFavView(title: String, message: String , image :String) {
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
         noDataImage.frame = CGRect(x: 30, y: 70, width: 310, height: 380)
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
    func restoreFav() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
