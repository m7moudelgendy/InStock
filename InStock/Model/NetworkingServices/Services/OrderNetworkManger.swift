//
//  OrderNetworkManger.swift
//  InStock
//
//  Created by Rezk on 12/03/2023.
//

import Foundation

class OrederNetworkManger {
    
    static func addNewOrder(userOrder: AllOrders, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
       
        let urlPost = URL(string: "https://b61bfc9ff926e2344efcd1ffd0d0b751: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@mad-ios-1.myshopify.com/admin/api/2023-01/orders.json")
        
        var urlReq = URLRequest(url: urlPost!)
        
        urlReq.httpMethod = "POST"
       
        urlReq.httpShouldHandleCookies = false
        do {
            //asDictinonary method to cast class data model to dictionary
            let requestBody = try JSONSerialization.data(withJSONObject: userOrder.asDictionary() , options: .prettyPrinted)
            
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
            }
        }.resume()
    }
}
