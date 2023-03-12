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

// Post Order
class Orders : Codable {
    
    var line_items : [LineItem]?
    
}

class LineItem : Codable {
   
    var title : String?
    var price : Double?
    
}

// Get Order
class GetAllOrders : Decodable {
    
    var orders : [GetOrders]?
}


class GetOrders : Decodable {
    
    var created_at : String?
    var current_subtotal_price : String?
    
}
