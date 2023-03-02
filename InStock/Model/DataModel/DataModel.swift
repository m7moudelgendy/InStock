//
//  DataModel.swift
//  InStock
//
//  Created by Rezk on 01/03/2023.
//

import Foundation

class SmartCollections : Decodable {
    
    var smart_collections : [Brands]
}

class Brands : Decodable {
    var title : String?
    var id : Int?
    var image : BrandImage?
}

class BrandImage : Decodable {
    
    var src : String?
}
