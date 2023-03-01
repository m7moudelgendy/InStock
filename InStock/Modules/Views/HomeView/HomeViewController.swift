//
//  ViewController.swift
//  InStock
//
//  Created by ElGendy on 28/02/2023.
//

import UIKit
import Alamofire

protocol HomeViewProtocol : AnyObject {
    
    func renderBrandCollection()
}

class HomeViewController: UIViewController , HomeViewProtocol {
    
    @IBOutlet weak var couponCollectionView: UICollectionView!
    
    @IBOutlet weak var BrandsCollectionView: UICollectionView!
    
    var viewModel : HomeViewModel!
    var couponArr = [Coupon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        couponArr.append(Coupon(photo: UIImage(named: "coupon1")!, title: "coupon20"))
        couponArr.append(Coupon(photo: UIImage(named: "coupon2")!, title: "coupon50"))
        couponArr.append(Coupon(photo: UIImage(named: "coupon3")!, title: "coupon70"))
        
        viewModel = HomeViewModel()
        
        viewModel.bindResultToHomeView = {[weak self] in
            DispatchQueue.main.async{
                self?.renderBrandCollection()
            }
        }
        
        viewModel.getBrands()
        
    }
    
    func renderBrandCollection() {
        self.BrandsCollectionView.reloadData()
    }
    
    
}
struct Coupon{
    let photo : UIImage
    let title : String
}

