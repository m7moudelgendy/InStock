//
//  CartRepo.swift
//  InStock
//
//  Created by ElGendy on 06/03/2023.
//

import Foundation

class CartRepo {
    
    var local = CartKeyChain()
    
    func store(cart: CartModel) {
        local.save(cart: cart)
    }
}
