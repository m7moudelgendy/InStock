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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
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
    
    @IBAction func SearchBtn(_ sender: Any) {
        let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @IBAction func btnCartClicked(_ sender: Any) {
        let cartVC = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
}

