//
//  productInfoDataModel.swift
//  InStock
//
//  Created by Hader on 4/3/23.
//

import Foundation

class ProductModel : Decodable

{
    var product : ProductInfo
}

class ProductInfo : Decodable{
    var id : Int?
    var title : String?
    var body_html : String?
    var vendor : String?
    var product_type : String?
    var images : [ProductImg]
    var variants : [Price]
}

class ProductImg : Decodable{
    var id : Int?
    var product_id : Int?
    var src : String?
}
class Price : Decodable {
    var price : String?
}

