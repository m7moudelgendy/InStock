//
//  OrderDataModel.swift
//  InStock
//
//  Created by Rezk on 12/03/2023.
//

import Foundation

class AllOrders : Codable {
    
    var order : Orders?
}

class Orders : Codable {
    
    var line_items : [LineItem]?
}

class LineItem : Codable {
   
    var title : String?
    var price : Double?
    
}
