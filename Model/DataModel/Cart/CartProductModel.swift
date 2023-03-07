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
    
    internal init(title: String, imageUrl: String, price: String) {
        self.title = title
        self.imageUrl = imageUrl
        self.price = price
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: CodingKeys.title.rawValue)
        coder.encode(imageUrl, forKey: CodingKeys.imageUrl.rawValue)
        coder.encode(price, forKey: CodingKeys.price.rawValue)
    }
    
    required init?(coder: NSCoder) {
        self.title = coder.decodeObject(forKey: CodingKeys.title.rawValue) as? String ?? ""
        self.imageUrl = coder.decodeObject(forKey: CodingKeys.imageUrl.rawValue) as? String ?? ""
        self.price = coder.decodeObject(forKey: CodingKeys.price.rawValue) as? String ?? ""
    }

}

extension CartProductModel {
    enum CodingKeys: String, CodingKey {
        case title
        case imageUrl
        case price
    }
}
