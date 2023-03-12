//
//  ProductInfoViewModel.swift
//  InStock
//
//  Created by Hader on 4/3/23.
//

import Foundation
import UIKit

class ProductInfoViewModel {
    
    
    var bindResultToProductView : (() -> ()) = {}
    
    
    var productImg : [ProductImg] = [] {
        didSet{
            bindResultToProductView()
        }
    }
    
    var productPrice : String!  {
        didSet{
            bindResultToProductView()
        }
    }
    
    var productTitle : String! {
        didSet{
            bindResultToProductView()
        }
    }
    
    var productBrand : String! {
        didSet{
            bindResultToProductView()
        }
    }
    
    var productType : String! {
        didSet{
            bindResultToProductView()
        }
    }
    
    var productDescription : String! {
        didSet{
            bindResultToProductView()
        }
    }
    
    func getProductInfo(UrlLink : String){
        NetworkManger.fetchData(apiLink: UrlLink) { [weak self] (data: ProductModel?) in
            print(UrlLink)
            self?.productImg = data?.product.images ?? []
            self?.productPrice = data?.product.variants.first?.price ?? ""
            self?.productTitle = data?.product.title ?? ""
            self?.productBrand = data?.product.vendor ?? ""
            self?.productDescription = data?.product.body_html ?? ""
            self?.productType = data?.product.product_type ?? ""
        }
    }
    
    
    
     
}
