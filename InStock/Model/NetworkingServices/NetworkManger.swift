//
//  NetworkManger.swift
//  InStock
//
//  Created by Rezk on 01/03/2023.
//

import Foundation
import Alamofire

protocol NetworkMangerProtocol {
    static func fetchData( apiLink : String ,complitionHandler: @escaping (SmartCollections?) -> Void)
}

class NetworkManger : NetworkMangerProtocol {
    
    static func fetchData(apiLink : String , complitionHandler: @escaping (SmartCollections?) -> Void){

        AF.request(apiLink).response{
            response in
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(SmartCollections.self, from: data)
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
    
    case Brands = "https://80300e359dad594ca2466b7c53e94435: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@mad-ism202.myshopify.com/admin/api/2023-01/smart_collections.json?since_id=438191358257"
    
}
