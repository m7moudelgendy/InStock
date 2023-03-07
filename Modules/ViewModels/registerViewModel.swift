//
//  registerViewModel.swift
//  inStock_hadeer
//
//  Created by Hader on 4/3/23.
//

import Foundation

class RegisterViewModel {
    

    func addNewCustomer (addCustomer : newCustomer, completion:@escaping (Data?, URLResponse? , Error?)->()){
        NetworkManger.registerUser(registerCustomer: addCustomer) { data , response, error in

        }
    }
    
    
}
