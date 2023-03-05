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
        
    }

    @IBAction func searchBtn(_ sender: Any) {
        let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    }
    
   



extension CategoryViewController : UICollectionViewDataSource , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        let url = URL(string: viewModel.category[indexPath.row].image.src!)
        cell.categoryImage.kf.setImage(with: url)
        cell.productName.text = viewModel.category[indexPath.row].title
        cell.productType.text = viewModel.category[indexPath.row].product_type
        cell.productType.textColor = UIColor.blue
        cell.categoryPrice.text = viewModel.category[indexPath.row].variants[0].price! + "EGP"
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
