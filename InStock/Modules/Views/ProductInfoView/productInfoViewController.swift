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
    
    
    @IBOutlet weak var favBTN: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var productType: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescrip: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionID = 0
    var productID = 0
    var isFav : Bool = false
    //cart object
    var addedToCart: Bool = false
    var cart = CartModel()
    var proImageUrl : String?
    var proName : String?
    var proPrice : String?
    var proQuantity = 1
    var infoFlag : Int?
    var viewModelOBJ : ProductInfoViewModel = ProductInfoViewModel()
    let favProductArr = ProductCoreDataManager.FetchProFromCoreData()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Proudct Info"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 20
        productDescrip.layer.cornerRadius = 10
        productDescrip.isEditable = false
        
        if CartRepo().local.isExist() {
            cart = CartRepo().local.get()!
        }
        switch infoFlag {
        case 1:
            let productInfoURL = "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/products/\(productID).json"
            viewModelOBJ.getProductInfo(UrlLink: productInfoURL)
        case 2:
            let productInfoURL = "https://b61bfc9ff926e2344efcd1ffd0d0b751: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@mad-ios-1.myshopify.com/admin/api/2023-01/products/\(productID).json?collection_id=\(collectionID)"
            viewModelOBJ.getProductInfo(UrlLink: productInfoURL)
        default:
            break
        }
        
        viewModelOBJ.bindResultToProductView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderProductInfoCollection()
                self?.pageControl.numberOfPages = self?.viewModelOBJ.productImg.count ?? 1
                self?.productTitle.text = self?.viewModelOBJ.productTitle
                self?.productType.text = self?.viewModelOBJ.productType
                self?.productDescrip.text  = self?.viewModelOBJ.productDescription
                self?.productPrice.text = (self?.viewModelOBJ.productPrice)! + " EGP"
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for index in 0 ..< (favProductArr.count) {
            let favProName = favProductArr[index].value(forKey: "proName") as? String
            if proName == favProName {
                favBTN.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                favBTN.reloadInputViews()
                break
            }
            
            else {
                favBTN.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
        self.collectionView.reloadData()
    }
     
    func renderProductInfoCollection() {
        self.collectionView.reloadData()
    }

    @IBAction func addToCartBT(_ sender: Any) {
        
        let product = CartProductModel(title: proName!, imageUrl: proImageUrl!, price: proPrice!, quantity: proQuantity)
        
        for prod in cart.products {
            showToast(message: "Already Exist")
            if prod.title == product.title {
                addedToCart = true
                
            }
        }
        
        if !addedToCart {
            cart.products.append(product)
            showToast(message: "Product added to cart")
            CartRepo().local.store(key: .Cart, object: cart)
            addedToCart = false
            dismiss(animated: true)
        }
        
    }
    
    @IBAction func favouriteBT(_ sender: UIButton) {
        
        for index in 0..<favProductArr.count
        {
            if proName == favProductArr[index].value(forKey: "proName") as! String
            {
                isFav = true
            }
           
        }
        switch isFav {
        case true:
            showToast(message: "Already Exist")

            break
        case false:
            showToast(message: "Product added to Wishlist")
            ProductCoreDataManager.SaveProToCoreData(proName:productTitle.text! , proPrice: productPrice.text!, proLink: proImageUrl!)
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            break
        default:
            break
        }
    }
 
    func showToast (message: String){
            let toastLb = UILabel(frame: CGRect(x: self.view.frame.width/2-120, y: self.view.frame.height/2+250, width: 250, height: 40))
            toastLb.textAlignment = .center
            toastLb.backgroundColor = #colorLiteral(red: 0.9441788197, green: 0.9288414717, blue: 0.9224751592, alpha: 1)
            toastLb.textColor = #colorLiteral(red: 0.7490196078, green: 0, blue: 0.5176470588, alpha: 1)
            toastLb.alpha = 1.0
            toastLb.layer.cornerRadius = 10
            toastLb.clipsToBounds = true
            toastLb.text = message
            self.view.addSubview(toastLb)
            UIView.animate(withDuration: 3.0 , delay: 0.5, options: .curveEaseInOut, animations: {
                toastLb.alpha = 0.0
            }){(isCompleted)in
                toastLb.removeFromSuperview()
            }
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
