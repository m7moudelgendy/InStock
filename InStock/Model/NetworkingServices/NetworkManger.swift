//
//  NetworkManger.swift
//  InStock
//
//  Created by Rezk on 01/03/2023.
//

import Foundation
import Alamofire

protocol NetworkMangerProtocol {
    static func fetchData<T : Decodable>( apiLink : String ,complitionHandler: @escaping (T?) -> Void)
}

class NetworkManger : NetworkMangerProtocol {
    
    static func fetchData<T : Decodable>(apiLink : String , complitionHandler: @escaping (T?) -> Void){

        AF.request(apiLink).response{
            response in
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(T.self, from: data)
                    complitionHandler(result)
                }
                catch{
                    complitionHandler(nil)
                }
            } 
        }

    }
     
}


enum apiLinks : String {
    
    case Brands = "https://a546963db1d86b6cdc7f01928132e7f7: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@mad-4-ism2023.myshopify.com/admin/api/2023-01/smart_collections.json"
    
    
    
}
