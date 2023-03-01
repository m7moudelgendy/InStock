//
//  DataModel.swift
//  InStock
//
//  Created by Rezk on 01/03/2023.
//

import Foundation
import UIKit

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
struct Coupon{
    let photo : UIImage
    let title : String
}
