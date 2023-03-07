//
//  CartKeyChain.swift
//  InStock
//
//  Created by ElGendy on 06/03/2023.
//

import Foundation

class CartKeyChain: KeyChain {
    
    func save(cart: CartModel) {
        _ = store(key: .Cart, object: cart)
    }
    
    func get() -> CartModel? {
        return load(key: .Cart)
    }
    
    func isExist() -> Bool {
        return get() != nil
    }

}
