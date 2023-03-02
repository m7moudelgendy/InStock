//
//  HomeViewModel.swift
//  InStock
//
//  Created by Rezk on 01/03/2023.
//

import Foundation


class HomeViewModel{
    var bindResultToHomeView : (() -> ()) = {}
    var result : [Brands] = []{
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
    
}
