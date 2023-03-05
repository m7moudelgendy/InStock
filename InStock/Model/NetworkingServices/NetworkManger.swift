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
    static func registerUser(registerCustomer : newCustomer, completion:@escaping (Data?, URLResponse? , Error?)->())
}

class NetworkManger : NetworkMangerProtocol {
    
    
    static func registerUser(registerCustomer: newCustomer, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        var urlReq = URLRequest(url: URL(string: apiLinks.register.rawValue)!)
        
        urlReq.httpMethod = "POST"
       
        urlReq.httpShouldHandleCookies = false
        do {
            //asDictinonary method to cast class data model to dictionary
            let requestBody = try JSONSerialization.data(withJSONObject: registerCustomer.asDictionary() , options: .prettyPrinted)
            
            urlReq.httpBody = requestBody
            
            urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlReq.addValue("application/json", forHTTPHeaderField: "Accept")
        }catch let error {
            print(error.localizedDescription)
        }
        URLSession.shared.dataTask(with: urlReq) { Data, HTTPURLResponse, error in
            if(Data != nil && Data?.count != 0){
                let response = String(data: Data!, encoding: .utf8)
                print(response!)
                print("data")
            }
        }.resume()
    }
    
    
    
    
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



