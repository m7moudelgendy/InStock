//
//  createCustomer.swift
//  inStock_hadeer
//
//  Created by Hader on 4/3/23.
//

import Foundation

// post new customer to API through customer
// get all customers from API through customers


class newCustomer : Codable {
    var customer : customerData?
}

class customerData : Codable {
    var id : Int?
    var email : String?
    var first_name : String?
    var last_name : String?
    var orders_count : Int?
    var phone : String?
    var addresses : [customerAddress]?
}


class customerAddress : Codable {
    var id : Int?
    var customer_id : Int?
    var first_name : String?
    var last_name : String?
    var address1 : String?
    var city : String?
    var country : String?
    var phone : String?
}
