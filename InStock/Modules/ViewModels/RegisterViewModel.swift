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
            if data?.customers.count != 0 {
                self?.userEmail = data?.customers[0].email ?? ""
                self?.userFirstName = data?.customers[0].first_name ?? ""
                self?.userLastName = data?.customers[0].last_name ?? ""
                self?.userID = data?.customers[0].id ?? 0
            } else {
                print ("inavlid Email")
            }
            
        }
        
    }
    
}
