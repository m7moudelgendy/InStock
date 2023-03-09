//
//  BrandDataModel.swift
//  InStock
//
//  Created by Rezk on 03/03/2023.
//

import Foundation

// for each brand details

class BrandProducts : Decodable {
    
    var products : [ProductDetails]
}

class ProductDetails : Decodable{
    
    var id : Int?
    var title : String?
    var product_type : String?
    var tags : String?
    var image : ProductImage
    var variants : [ProductVariants]
}

class ProductVariants : Decodable {
    var price : String?
}

class ProductImage :Decodable {
    var src : String?
}
