 
import UIKit
import ValidationTextField

class SignInViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
   
    
    @IBOutlet weak var emailTF: ValidationTextField!
   
    @IBOutlet weak var passwordTF: ValidationTextField!
    var registerViewModelOBJ = RegisterViewModel()
    var firstName : String?
    var lastName : String?
    var email : String?
    var uId : Int?
    func validation (){
        emailTF.validCondition = {$0.count > 5 && $0.contains("@")}
        passwordTF.validCondition = {$0.count > 8}
        
         passwordTF.successImage = UIImage(named: "thumb_up")
        passwordTF.errorImage = UIImage(named: "thumb_down")
        emailTF.successImage = UIImage(named: "success")
        emailTF.errorImage = UIImage(named: "error")
    }
    var validDic = [ "email":false, "pw":false]

  
    @objc func textFieldDidChange(_ textfield: UITextField) {
        let tf = textfield as! ValidationTextField

        switch tf {
      
        case emailTF:
            validDic["email"] = tf.isValid
        case passwordTF:
            validDic["pw"] = tf.isValid
     
        default:
            break
        }

     }
 
 
    override func viewDidLoad() {
        super.viewDidLoad()
        validation()
        loginView.layer.cornerRadius = 80
        loginView.layer.maskedCorners = [.layerMinXMinYCorner]
      
    }
    
  
    
    @IBAction func newUserBtn(_ sender: Any) {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
   
           self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    
    @IBAction func SigninBtn(_ sender: Any) {
        print("brrrrr")
        let loginEmail = emailTF!.text!
        let loginApi = "https://b61bfc9ff926e2344efcd1ffd0d0b751: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@mad-ios-1.myshopify.com/admin/api/2023-01/customers/search.json?query=email:" + loginEmail
        
        registerViewModelOBJ.getLogedUser(userLink: loginApi)
        
        
        registerViewModelOBJ.bindResultToRegisterView = {[weak self] in
            DispatchQueue.main.async{
//                self?.firstName = self!.registerViewModelOBJ.userFirstName!
//                self?.lastName = self!.registerViewModelOBJ.userLastName!
//                self?.email = self!.registerViewModelOBJ.userEmail!
//                self?.uId = self!.registerViewModelOBJ.userID!
//                print (self!.firstName!)
//                print (self!.lastName!)
//                print (self!.email!)
//                print (self!.uId!)
                
                CoreDataManager.SaveToCoreData(firstName: self!.registerViewModelOBJ.userFirstName!, lastName: self!.registerViewModelOBJ.userLastName! , email: self!.registerViewModelOBJ.userEmail!, id: self!.registerViewModelOBJ.userID!)
                
                let userVC = self?.storyboard?.instantiateViewController(withIdentifier: "userProfileViewController") as! userProfileViewController
                self?.navigationController?.pushViewController(userVC, animated: true)
            }
        }
//        let logedUser = CoreDataManager.FetchFromCoreData()
//        if logedUser.count != 0 {
//            let userVC = self.storyboard?.instantiateViewController(withIdentifier: "userProfileViewController") as! userProfileViewController
//            self.navigationController?.pushViewController(userVC, animated: true)
//        }
    }
    
}
