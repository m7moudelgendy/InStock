//
//  Encodable + extension.swift
//  inStock_hadeer
//
//  Created by Hader on 4/3/23.
//

import Foundation

//to cast data class to dictionary so that API can understand
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
