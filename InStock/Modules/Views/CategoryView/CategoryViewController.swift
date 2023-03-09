//
//  CategoryViewController.swift
//  InStock
//
//  Created by Rezk on 01/03/2023.
//

import UIKit
import Kingfisher

protocol CategoryViewProtocol : AnyObject {
    
    func renderCategoryCollection()
}


class CategoryViewController: UIViewController ,CategoryViewProtocol  {
    
    var viewModel : CategoryViewModel!
    
    
    @IBOutlet weak var categoryType: UISegmentedControl!
    var products = [ProductDetails]()
    var filterCategory : [ProductDetails]?
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CategoryViewModel()
        
        viewModel.bindResultToHomeView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderCategoryCollection()
            }
        }
        
        let productUrl = "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/products.json"
        
        viewModel.getBrandProducts(link: productUrl)
        categoryType.selectedSegmentIndex = 0
        categoryHasChanged(self)
        
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @IBAction func btnCartClicked(_ sender: Any) {
        
        let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        
        self.navigationController?.pushViewController(cartVC, animated: true)
        
    }
    
    
    
    @IBAction func categoryHasChanged(_ sender: Any) {
        
        switch categoryType.selectedSegmentIndex {
        case 0:
            // Show all products
            filterCategory = viewModel.category
        case 1:
            // Show products tagged with "men"
            filterCategory = viewModel.category.filter { $0.tags?.contains("men") == true }
        case 2:
            // Show products tagged with "women"
            filterCategory = viewModel.category.filter { $0.tags?.contains("women") == true }
        case 3:
            // Show products tagged with "kid"
            filterCategory = viewModel.category.filter { $0.tags?.contains("kid") == true }
        default:
            break
        }
        
        // Reload the collection view with the filtered products
        self.categoryCollectionView.reloadData()
    }
    
}





extension CategoryViewController : UICollectionViewDataSource , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let filterCategory = filterCategory {
            return filterCategory.count
        } else {
            return viewModel.category.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        let products = (filterCategory?.isEmpty == false) ? filterCategory! : self.products
        guard indexPath.row < products.count else {
            return cell
        }
        let thisProduct = products[indexPath.row]
        
        let url = URL(string: thisProduct.image.src!)
        cell.categoryImage.kf.setImage(with: url)
        cell.productName.text = thisProduct.title
        cell.productType.text = thisProduct.product_type
        cell.productType.textColor = UIColor.blue
        cell.categoryPrice.text = thisProduct.variants[0].price! + "EGP"
        
        cell.layer.borderColor = UIColor.systemGray.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 25
        cell.layer.masksToBounds = true
        cell.layer.shadowOffset = CGSizeMake(6, 6)
        cell.layer.shadowColor = UIColor.white.cgColor
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowRadius = 4
        cell.contentView.layer.masksToBounds = true
        return cell
    }
    
    func renderCategoryCollection() {
        self.categoryCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 181, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 31
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    
    
}
