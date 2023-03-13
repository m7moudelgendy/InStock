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

    }
    
    
    
}
