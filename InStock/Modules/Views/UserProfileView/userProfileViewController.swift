//
//  userProfileViewController.swift
//  InStock
//
//  Created by Hader on 7/3/23.
//

import UIKit

class userProfileViewController: UIViewController {

    @IBOutlet weak var userEmailLBL: UILabel!
    @IBOutlet weak var helloMsgLBL: UILabel!
    @IBOutlet weak var userFullNameLBL: UILabel!
    
    let fetchArr = CoreDataManager.FetchFromCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        helloMsgLBL.text = "Hi" + " " + (fetchArr[0].value(forKey: "firstName") as! String)
        userEmailLBL.text = fetchArr[0].value(forKey: "email") as? String
        userFullNameLBL.text = (fetchArr[0].value(forKey: "firstName") as! String) + " " + (fetchArr[0].value(forKey: "lastName") as! String)
    }
    

    @IBAction func logOutBtn(_ sender: Any) {
        for _ in 0...fetchArr.count {
            CoreDataManager.DeleteFromCoreData()
        }
        
        let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "welcomeViewController") as! welcomeViewController
   
           self.navigationController?.pushViewController(welcomeVC, animated: true)
        
    }
    

}
