//
//  AddressNetworkManger.swift
//  InStock
//
//  Created by ElGendy on 10/03/2023.
//

import Foundation
import Alamofire

class AddressNetworkManger {
    
    static func getAllAddresses(completion: @escaping ([Address]?, Error?)-> Void){
            //guard let customerID = Helper.shared.getUserID() else {return}
        let customerID = 6812915204373
            //guard let url = URLs.shared.customersURl() else {return}
        let url = URL(string: "https://b61bfc9ff926e2344efcd1ffd0d0b751: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@mad-ios-1.myshopify.com/admin/api/2023-01/customers.json")
        AF.request(url!, method: .get,parameters: nil,encoding: JSONEncoding.default,headers: nil).response { res in
                switch res.result{
                case.failure(let error):
                    print(error.localizedDescription)
                    completion(nil,error)
                case .success(_):
                    guard let data = res.data else { return }
                    do{
                        let json = try JSONDecoder().decode(Customers.self, from: data)
                        for selectedCustomer in json.customers{
                            if selectedCustomer.id == customerID {
                                completion(selectedCustomer.addresses, nil)
                            }
                        }
                        print("success to get address for a customers")
                    }catch let error{
                        print("error when get address for a customers")
                        completion(nil, error)
                    }
                }
            }
        }
    
    static func addNewAddress(userAddress: AllCoustomerAdress, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let urlPost = URL(string: "https://b61bfc9ff926e2344efcd1ffd0d0b751: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@mad-ios-1.myshopify.com/admin/api/2023-01/customers/6812915204373/addresses.json")
        var urlReq = URLRequest(url: urlPost!)
        
        urlReq.httpMethod = "POST"
       
        urlReq.httpShouldHandleCookies = false
        do {
            //asDictinonary method to cast class data model to dictionary
            let requestBody = try JSONSerialization.data(withJSONObject: userAddress.asDictionary() , options: .prettyPrinted)
            
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
     
}
