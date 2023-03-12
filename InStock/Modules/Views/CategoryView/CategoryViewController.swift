//
//  CategoryViewController.swift
//  InStock
//
//  Created by Rezk on 01/03/2023.
//

import UIKit
import Kingfisher
import Floaty
protocol CategoryViewProtocol : AnyObject {
    
    func renderCategoryCollection()
}


class CategoryViewController: UIViewController ,CategoryViewProtocol  {
    
    var viewModel : CategoryViewModel!
    
    @IBOutlet weak var floaty: Floaty!
    
    @IBOutlet weak var categoryType: UISegmentedControl!
    var products = [ProductDetails]()
    var filterCategory : [ProductDetails]?
    var isFiltering: Bool = false
    let favProductArr = ProductCoreDataManager.FetchProFromCoreData()
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatyBtn()
        viewModel = CategoryViewModel()
        
        
        let productUrl = "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/products.json"
        
        viewModel.getBrandProducts(link: productUrl)
        
        
        viewModel.bindResultToHomeView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderCategoryCollection()
            }
        }
        categoryType.selectedSegmentIndex = 0
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.categoryCollectionView.reloadData()
    }
    
    @IBAction func favBTN(_ sender: Any) {
        let favVC = self.storyboard?.instantiateViewController(withIdentifier: "favProductViewController") as! favProductViewController

           self.navigationController?.pushViewController(favVC, animated: true)
        
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
            categoryCollectionView.reloadData()
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
        var products = isFiltering ? filterCategory! : viewModel.category
        products = (filterCategory?.isEmpty == false) ? filterCategory! : viewModel.category
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
        for index in 0 ..< (favProductArr.count) {
            let favProName = favProductArr[index].value(forKey: "proName") as? String
            if thisProduct.title == favProName {
                cell.favProduct.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                cell.favProduct.reloadInputViews()
                break
            }
            
            else {
                cell.favProduct.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            
        }
        
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
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let productInfo = self.storyboard?.instantiateViewController(withIdentifier: "productInfoViewController") as! productInfoViewController
//        var products = isFiltering ? filterCategory! : viewModel.category
//        products = (filterCategory?.isEmpty == false) ? filterCategory! : viewModel.category
//        guard indexPath.row < products.count else {
//            return
//        }
//        let thisProduct = products[indexPath.row]
//        productInfo.infoFlag = 1
//        productInfo.productID = (thisProduct.variants.first?.product_id)!
//        print(thisProduct.id!)
//        self.navigationController?.pushViewController(productInfo, animated: true)
//    }
    
    func renderCategoryCollection() {
        self.categoryCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 45) / 2
        return CGSize(width: cellWidth, height: cellWidth + 90)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 31
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    

    func floatyBtn() {
        floaty.addItem( icon: UIImage(named: "bag")!, handler: { [self] item in
            filterCategory = getFilteredProducts(productType: "accessories")
            self.categoryCollectionView.reloadData()
            floaty.close()
        })
        floaty.addItem( icon: UIImage(named: "tshirt")!, handler: { [self] item in
            filterCategory = getFilteredProducts(productType: "t-shirts")
            self.categoryCollectionView.reloadData()
            floaty.close()
        })
        floaty.addItem( icon: UIImage(named: "shoes")!, handler: { [self] item in
            filterCategory = getFilteredProducts(productType: "shoes")
            self.categoryCollectionView.reloadData()
            floaty.close()
        })
    }

    func getFilteredProducts(productType: String) -> [ProductDetails] {
        switch categoryType.selectedSegmentIndex {
        case 0:
            return viewModel.category.filter { $0.product_type?.lowercased().contains(productType.lowercased()) ?? false }
        case 1:
            return viewModel.category.filter { $0.tags?.contains("men") == true && $0.product_type?.lowercased().contains(productType.lowercased()) ?? false }
        case 2:
            return viewModel.category.filter { $0.tags?.contains("women") == true && $0.product_type?.lowercased().contains(productType.lowercased()) ?? false }
        case 3:
            return viewModel.category.filter { $0.tags?.contains("kid") == true && $0.product_type?.lowercased().contains(productType.lowercased()) ?? false }
        default:
            return []
        }
    }

    
}
