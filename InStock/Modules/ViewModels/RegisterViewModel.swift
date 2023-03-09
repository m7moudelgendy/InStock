//
//  registerViewModel.swift
//  inStock_hadeer
//
//  Created by Hader on 4/3/23.
//

import Foundation

class RegisterViewModel {
    
    var bindResultToRegisterView : (() -> ()) = {}
    
    var user : [loggedCustomerData] = []{
        didSet{
            bindResultToRegisterView()
        }
    }
    
//    var userFirstName : String! {
//        didSet{
//            bindResultToRegisterView()
//        }
//    }
//
//    var userLastName : String! {
//        didSet{
//            bindResultToRegisterView()
//        }
//    }
//
//    var userEmail : String! {
//        didSet{
//            bindResultToRegisterView()
//        }
//    }
//
//    var userID : Int! {
//        didSet{
//            bindResultToRegisterView()
//        }
//    }
    
    func addNewCustomer (addCustomer : newCustomer, completion:@escaping (Data?, URLResponse? , Error?)->()){
        NetworkManger.registerUser(registerCustomer: addCustomer) { data , response, error in

        }
    }
    
    
    func getLogedUser (userLink : String) {
        NetworkManger.fetchData(apiLink: userLink) { [weak self] (data : LoggedCustomer?) in
            if data != nil {
                self?.user = data!.customers
                
            } else {
                print ("inavlid Email")
            }
            
        }
        
    }
    
}
