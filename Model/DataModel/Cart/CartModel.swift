//
//  CartModel.swift
//  InStock
//
//  Created by ElGendy on 06/03/2023.
//

import Foundation

class CartModel: NSObject, NSCoding, Codable {
    
    var products : [CartProductModel]
    
    override init() {
        self.products = []
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(products, forKey: CodingKeys.products.rawValue)
    }
    
    required init?(coder: NSCoder) {
        self.products = coder.decodeObject(forKey: CodingKeys.products.rawValue) as? [CartProductModel] ?? []
    }

}

extension CartModel {
    enum CodingKeys: String, CodingKey {
        case products
    }
}
