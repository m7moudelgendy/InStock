 
import UIKit
import ValidationTextField

class SignInViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
   
    @IBOutlet weak var loginConfirm: UIButton!
    
    @IBOutlet weak var emailTF: ValidationTextField!
   
    @IBOutlet weak var passwordTF: ValidationTextField!
    var registerViewModelOBJ = RegisterViewModel()
    var firstName : String?
    var lastName : String?
    var email : String?
    var uId : Int?
    func validation (){
        emailTF.validCondition = {$0.count > 5 && $0.contains("@") && $0.contains(".com")}
        passwordTF.validCondition = {$0.count > 8}
        
        
        emailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
         passwordTF.successImage = UIImage(named: "thumb_up")
        passwordTF.errorImage = UIImage(named: "thumb_down")
        emailTF.successImage = UIImage(named: "success")
        emailTF.errorImage = UIImage(named: "error")
    }
    var validDic = [ "email":false, "pw":false]
    
    var isValid: Bool? {
        didSet {
            loginConfirm.isEnabled = isValid ?? false
            loginConfirm.backgroundColor = isValid ?? false ? #colorLiteral(red: 0.568627451, green: 0.1921568627, blue: 0.4588235294, alpha: 1) : .lightGray
        }}

  
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
        
        isValid = validDic.reduce(true){ $0 && $1.value}
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
        let loginEmail = emailTF!.text!
        let loginApi = "https://b61bfc9ff926e2344efcd1ffd0d0b751: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@mad-ios-1.myshopify.com/admin/api/2023-01/customers/search.json?query=email:" + loginEmail
        
        registerViewModelOBJ.getLogedUser(userLink: loginApi)
        
        
        registerViewModelOBJ.bindResultToRegisterView = {[weak self] in
            DispatchQueue.main.async{
                    CoreDataManager.SaveToCoreData(firstName: (self!.registerViewModelOBJ.user.first?.first_name)!,
                                                   lastName: (self!.registerViewModelOBJ.user.first?.last_name)! ,
                                                   email: (self!.registerViewModelOBJ.user.first?.email)!,
                                                   id: (self!.registerViewModelOBJ.user.first?.id)!)
                    
                    let userVC = self?.storyboard?.instantiateViewController(withIdentifier: "userProfileViewController") as! userProfileViewController
                    self?.navigationController?.pushViewController(userVC, animated: true)
                
            }
        }

    }
    
}
