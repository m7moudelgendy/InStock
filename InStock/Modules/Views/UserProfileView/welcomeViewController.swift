//
//  welcomeViewController.swift
//  InStock
//
//  Created by Hader on 8/3/23.
//

import UIKit

class welcomeViewController: UIViewController {

    let fetchUser = CoreDataManager.FetchFromCoreData()
    override func viewDidLoad() {
        super.viewDidLoad()
        if fetchUser.count != 0 {
            let userVC = self.storyboard?.instantiateViewController(withIdentifier: "userProfileViewController") as! userProfileViewController
            self.navigationController?.pushViewController(userVC, animated: true)
        }
        
    }
    
    @IBAction func sinUpBTN(_ sender: Any) {
        
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
   
           self.navigationController?.pushViewController(registerVC, animated: true)
        
    }
    
    @IBAction func signInBTN(_ sender: Any) {
        let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
   
           self.navigationController?.pushViewController(signInVC, animated: true)
    }
    

}
