//
//  SearchViewController.swift
//  InStock
//
//  Created by Afnan on 05/03/2023.
//

import UIKit
import Kingfisher

protocol ProductsViewProtocol : AnyObject {
    
    func renderProductsCollection()
    
}

class SearchViewController: UIViewController ,ProductsViewProtocol
{
    @IBOutlet weak var productsCollectionView: UICollectionView!
        
    var searchviewModel : SearchViewModel!
    var searching = false
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        //search  bar
      //searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        configureSearchController ()
        searchviewModel = SearchViewModel()
        let productUrl = "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/products.json"
        searchviewModel.getProducts(link: productUrl)
        searchviewModel.bindResultToSearchView = {[weak self] in
            DispatchQueue.main.async{
                
                self?.renderProductsCollection()
            }
            
        }
        
     
//        searchviewModel.bindSearchResultToSearchView = {[weak self] in
//
//            DispatchQueue.main.async{
//                self?.searchviewModel.searchProduct  = self?.searchviewModel.products ?? []
//                self?.renderProductsCollection()
//
//            }
//        }
    }
    func configureSearchController ()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType =  UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Product By Name"
    }
   
}



extension SearchViewController : UICollectionViewDataSource , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout,UISearchBarDelegate , UISearchResultsUpdating
{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
 
            return searchviewModel.searchProduct.count
        }
        else
        {
            return searchviewModel.products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        if searching{
            let url = URL(string: searchviewModel.searchProduct[indexPath.row].image.src!)
            cell.productImage.kf.setImage(with: url)
            cell.productName.text = searchviewModel.searchProduct[indexPath.row].title
            cell.productType.text = searchviewModel.searchProduct[indexPath.row].product_type
            cell.productPrice.text = searchviewModel.products[indexPath.row].variants[0].price! + "EGP"
           
        }
        else
        {
            let url = URL(string: searchviewModel.products[indexPath.row].image.src!)
            cell.productImage.kf.setImage(with: url)
            cell.productName.text = searchviewModel.products[indexPath.row].title
            cell.productType.text = searchviewModel.products[indexPath.row].product_type
            cell.productPrice.text = searchviewModel.products[indexPath.row].variants[0].price! + "EGP"
        }
        cell.productType.textColor = UIColor.darkGray
        cell.layer.borderColor = UIColor.white.cgColor
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
    
    func renderProductsCollection() {
        self.productsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 170, height: 181)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty
        {
            searching = true
            searchviewModel.searchProduct.removeAll()
            for product in searchviewModel.products
            {
                if   product.title!.lowercased().contains(searchText.lowercased())
                {
                    searchviewModel.searchProduct.append(product)
                }
            }
            renderProductsCollection()
        }
            else
            {
                searching = false
                searchviewModel.searchProduct.removeAll()
                searchviewModel.searchProduct = searchviewModel.products
                renderProductsCollection()

            }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchviewModel.searchProduct.removeAll()
        renderProductsCollection()
    }
}






