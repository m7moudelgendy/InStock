//
//  AddressViewModel.swift
//  InStock
//
//  Created by ElGendy on 10/03/2023.
//

import Foundation
class AdressViewModel{

    var bindResultToAdressView : (() -> ()) = {}
    var result : [Address] = []{
        didSet{
            //bind the result
            bindResultToAdressView()
        }
    }
    
    func getAllAddressForCustomer(){
        AddressNetworkManger.getAllAddresses { adderessArray, error in
                
            self.result = adderessArray!
            }
        }
    
}
