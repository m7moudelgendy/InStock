//
//  productInfoViewController.swift
//  InStock
//
//  Created by Hader on 2/3/23.
//

import UIKit

protocol ProductInfoViewProtocol : AnyObject {
    
    func renderProductInfoCollection()
}


class productInfoViewController: UIViewController ,ProductInfoViewProtocol{
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var productType: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescrip: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionID = 0
    var productID = 0
    var viewModelOBJ : ProductInfoViewModel = ProductInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 20
        productDescrip.layer.cornerRadius = 10
        let productInfoURL = "https://a546963db1d86b6cdc7f01928132e7f7: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@mad-4-ism2023.myshopify.com/admin/api/2023-01/products/\(productID).json?collection_id=\(collectionID)"
 
        viewModelOBJ.getProductInfo(UrlLink: productInfoURL)
        viewModelOBJ.bindResultToProductView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderProductInfoCollection()
                self?.pageControl.numberOfPages = self?.viewModelOBJ.productImg.count ?? 1
                self?.productTitle.text = self?.viewModelOBJ.productTitle
                self?.productType.text = self?.viewModelOBJ.productType
                self?.productDescrip.text  = self?.viewModelOBJ.productDescription
                self?.productPrice.text = (self?.viewModelOBJ.productPrice[0].price)! + "EGP"
                
            }
        }
    }
     
    func renderProductInfoCollection() {
        self.collectionView.reloadData()
    }

    @IBAction func addToCartBT(_ sender: Any) {
    }
    
    @IBAction func favouriteBT(_ sender: Any) {
    }
}




extension productInfoViewController : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelOBJ.productImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! productImgCollectionViewCell
        
        let imgUrl = URL(string: viewModelOBJ.productImg[indexPath.row].src!)
        item.productImg.kf.setImage(with: imgUrl)
        
        return item
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell:UICollectionViewCell, forItemAt indexPath: IndexPath){
        pageControl.currentPage = indexPath.row
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let herziontalCenter = width/2
        pageControl.currentPage = Int(offset + herziontalCenter) / Int(width)
    }
}
