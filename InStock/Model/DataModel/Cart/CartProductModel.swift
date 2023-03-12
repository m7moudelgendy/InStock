//
//  File.swift
//  InStock
//
//  Created by ElGendy on 06/03/2023.
//

import Foundation

class CartProductModel: NSObject, NSCoding, Codable {
    
    var title: String
    var imageUrl: String
    var price : String
    var quantity: Int
    
    internal init(title: String, imageUrl: String, price: String , quantity: Int) {
        self.title = title
        self.imageUrl = imageUrl
        self.price = price
        self.quantity = quantity
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: CodingKeys.title.rawValue)
        coder.encode(imageUrl, forKey: CodingKeys.imageUrl.rawValue)
        coder.encode(price, forKey: CodingKeys.price.rawValue)
        coder.encode(quantity, forKey: CodingKeys.quantity.rawValue)
    }
    
    required init?(coder: NSCoder) {
        self.title = coder.decodeObject(forKey: CodingKeys.title.rawValue) as? String ?? ""
        self.imageUrl = coder.decodeObject(forKey: CodingKeys.imageUrl.rawValue) as? String ?? ""
        self.price = coder.decodeObject(forKey: CodingKeys.price.rawValue) as? String ?? ""
        self.quantity = coder.decodeObject(forKey: CodingKeys.quantity.rawValue) as? Int ?? 1
    }

}

extension CartProductModel {
    enum CodingKeys: String, CodingKey {
        case title
        case imageUrl
        case price
        case quantity
    }
}
