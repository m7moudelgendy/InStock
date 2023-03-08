//
//  registerViewModel.swift
//  inStock_hadeer
//
//  Created by Hader on 4/3/23.
//

import Foundation

class RegisterViewModel {
    
    var bindResultToRegisterView : (() -> ()) = {}
    
    var userFirstName : String! {
        didSet{
            bindResultToRegisterView()
        }
    }
    
    var userLastName : String! {
        didSet{
            bindResultToRegisterView()
        }
    }

    var userEmail : String! {
        didSet{
            bindResultToRegisterView()
        }
    }
    
    var userID : Int! {
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
            
            self?.userEmail = data?.customers.email ?? ""
            self?.userFirstName = data?.customers.first_name ?? ""
            self?.userLastName = data?.customers.last_name ?? ""
            self?.userID = data?.customers.id ?? 0
            
        }
        
    }
    
}
