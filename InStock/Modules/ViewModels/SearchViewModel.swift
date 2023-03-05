//
//  SearchViewModel.swift
//  InStock
//
//  Created by Afnan on 05/03/2023.
//

import Foundation
import UIKit
class SearchViewModel{
    
    
    var bindResultToSearchView : (() -> ()) = {}
    var bindSearchResultToSearchView : (() -> ()) = {}

    var products : [ProductDetails] = []{
        didSet{
            //bind the result
            bindResultToSearchView()
        }
    }
    var searchProduct: [ProductDetails] = []{
        didSet{
        //    bind the search result
            bindSearchResultToSearchView()
       }
    }
    
    
    func getProducts(link : String){
        
    
        NetworkManger.fetchData(apiLink: link){[weak self] (data: BrandProducts?) in
            self?.products = data?.products ?? []
         self?.searchProduct =  data?.products ?? []
        }
    }
}
    
    
