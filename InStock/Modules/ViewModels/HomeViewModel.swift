//
//  HomeViewModel.swift
//  InStock
//
//  Created by Rezk on 01/03/2023.
//

import Foundation
import UIKit


class HomeViewModel{
    var couponArr : [Coupon] = [Coupon(photo: UIImage(named: "coupon1")!, title: "coupon20"),Coupon(photo: UIImage(named: "coupon2")!, title: "coupon50"),Coupon(photo: UIImage(named: "coupon3")!, title: "coupon70")]
    
    
    var bindResultToHomeView : (() -> ()) = {}
    var result : [Brands] = []{
        didSet{
            //bind the result
            bindResultToHomeView()
        }
    }
    var products : [ProductDetails] = [] {
        didSet{
            //bind the result
            bindResultToHomeView()
        }
    }
    var orders : [GetOrders] = [] {
        didSet{
            //bind the result
            bindResultToHomeView()
        }
    }
    
    func getBrands(){
        
        NetworkManger.fetchData(apiLink: apiLinks.Brands.rawValue){[weak self] (data: SmartCollections?) in
            self?.result = data?.smart_collections ?? []
        }
    }
    func getOrders(){
        
        NetworkManger.fetchData(apiLink: apiLinks.orders.rawValue){[weak self] (data: GetAllOrders?) in
            self?.orders = data?.orders ?? []
        }
    }
    
    func getBrandProducts(link : String){
        
    
        NetworkManger.fetchData(apiLink: link){[weak self] (data: BrandProducts?) in
            self?.products = data?.products ?? []
            
        }
    }
    
    
    
}
