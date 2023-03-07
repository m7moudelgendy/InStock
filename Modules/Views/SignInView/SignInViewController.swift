 
import UIKit
import ValidationTextField

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTF: ValidationTextField!
   
    @IBOutlet weak var passwordTF: ValidationTextField!
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

      
    }
    
  
    
    @IBAction func newUserBtn(_ sender: Any) {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
   
           self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    
    @IBAction func SigninBtn(_ sender: Any) {
    }
    
}
