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
    

    
    func addNewCustomer (addCustomer : newCustomer, completion:@escaping (Data?, URLResponse? , Error?)->()){
        NetworkManger.registerUser(registerCustomer: addCustomer) { data , response, error in

        }
    }
    
    
    func getLogedUser (userLink : String) {
        NetworkManger.fetchData(apiLink: userLink) { [weak self] (data : LoggedCustomer?) in
            if data != nil {
                self?.user = data!.customers!
                
            } else {
                print ("inavlid Email")
            }
            
        }
        
    }
    
}
