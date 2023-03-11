//
//  AddAddressVC.swift
//  InStock
//
//  Created by ElGendy on 10/03/2023.
//

import UIKit

class AddAddressVC: UIViewController {

    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var address1TF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func signUpConfirmBtn(_ sender: UIButton) {
        guard let adress1 = address1TF.text else {return}
        guard let city = cityTF.text else {return}
        guard let country = countryTF.text else {return}

        let newAddress = Address()
        let allAdresses = AllCoustomerAdress()
        newAddress.address1 = adress1
        newAddress.city = city
        newAddress.country = country
         //add user to server
        allAdresses.customer_address = newAddress

        AddressNetworkManger.addNewAddress(userAddress: allAdresses) { _,_,_ in
        }
       
        self.navigationController?.popViewController(animated: true)
    }
}
