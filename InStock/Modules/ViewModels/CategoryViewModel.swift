//
//  CategoryViewModel.swift
//  InStock
//
//  Created by Rezk on 01/03/2023.
//

import Foundation
import UIKit


class CategoryViewModel{

    var bindResultToHomeView : (() -> ()) = {}
    var category : [ProductDetails] = []{
        didSet{
            //bind the result
            bindResultToHomeView()
        }
    }
    
    func getBrandProducts(link : String){
        
    
        NetworkManger.fetchData(apiLink: link){[weak self] (data: BrandProducts?) in
            self?.category = data?.products ?? []
            
        }
    }
}
