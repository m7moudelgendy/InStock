//
//  AddressDataModel.swift
//  InStock
//
//  Created by ElGendy on 10/03/2023.
//

import Foundation

class Address: Codable {
    var address1 : String?
    var city : String?
    var country : String?
    var id : Int?
    var customer_id : Int?
}
//Class For Get Data
class CustomerAddress: Codable {
    var addresses: [Address]?
}
//class For Post Data
class AllCoustomerAdress : Codable {
    var customer_address : Address?
}

class PutAddress: Codable {
    var customer: CustomerAddress?
}

class Customers: Codable {
    var customers: [Customer]
}
class Customer: Codable {
    var first_name, last_name, email, phone, tags: String?
    var id: Int?
    var note: String?
    var verified_email: Bool?
    var addresses: [Address]?
}

