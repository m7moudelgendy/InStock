//
//  BrandDetailsVC.swift
//  InStock
//
//  Created by Rezk on 02/03/2023.
//

import UIKit
import Kingfisher
protocol BrandViewProtocol : AnyObject {
    
    func renderBrandCollection()
}

class BrandDetailsVC: UIViewController , BrandViewProtocol {
    
    let search = UISearchController()
    var brandID = 0
    var index = 0
    
    
    @IBOutlet weak var brandDetailsCollectionView: UICollectionView!
    var viewModel : HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       title = "Search"
        navigationItem.searchController = search
        
        viewModel = HomeViewModel()
        
        viewModel.bindResultToHomeView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderBrandCollection()
            }
        }
        
         let productUrl = "https://a546963db1d86b6cdc7f01928132e7f7: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@mad-4-ism2023.myshopify.com/admin/api/2023-01/products.json?collection_id=\(brandID)"
        
        viewModel.getBrandProducts(link: productUrl)
        
    }
    
    

}
extension BrandDetailsVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandDetailsCell", for: indexPath) as! BrandDetailsCell
        
        let url = URL(string: viewModel.products[indexPath.row].image.src!)
        cell.productImage.kf.setImage(with: url)
        cell.productPrice.text = viewModel.products[indexPath.row].variants[0].price! + "EGP"
        
        return cell
    }
    
    func renderBrandCollection() {
        self.brandDetailsCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productInfo = self.storyboard?.instantiateViewController(withIdentifier: "productInfoViewController") as! productInfoViewController
        productInfo.collectionID = brandID
        productInfo.productID = viewModel.products[indexPath.row].id!
        self.navigationController?.pushViewController(productInfo, animated: true)
    }
}
