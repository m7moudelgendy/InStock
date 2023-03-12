

import UIKit
import ValidationTextField
import CoreData

class RegisterViewController: UIViewController {
    @IBOutlet weak var nameTextField: ValidationTextField!
    @IBOutlet weak var passwordTextField: ValidationTextField!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var lastNameTextField: ValidationTextField!
    @IBOutlet weak var passwordConfirmTextField: ValidationTextField!
    @IBOutlet weak var emailTextField: ValidationTextField!
    @IBOutlet weak var comfirmButton: UIButton!
    var registerViewModelOBJ = RegisterViewModel()
    
    var containDataFlag : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
      validation()
        signUpView.layer.cornerRadius = 80
        signUpView.layer.maskedCorners = [.layerMinXMinYCorner]
     
       
    }
 //   Register Btn
    @IBAction func signUpConfirmBtn(_ sender: UIButton) {
        guard let name = nameTextField.text else {return}
        guard let lastName = lastNameTextField.text else {return}
        guard let email = emailTextField.text else {return}
        guard passwordTextField.text != nil else {return}

        let customerOBJ = customerData()
        let addedCustomer = newCustomer()
        customerOBJ.first_name = name
        customerOBJ.last_name = lastName
        customerOBJ.email = email
         //add user to server
        addedCustomer.customer = customerOBJ
        
        registerViewModelOBJ.addNewCustomer(addCustomer: addedCustomer) { data, response, error in
        }
        print("user added to server successfully ")
        
        let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
       
        self.navigationController?.pushViewController(signInVC, animated: true)
     
    }
    func validation (){
        nameTextField.validCondition = {$0.count > 3}
        lastNameTextField.validCondition = {$0.count > 3}
        emailTextField.validCondition = {$0.count > 5 && $0.contains("@") && $0.contains(".com") }
        passwordTextField.validCondition = {$0.count > 8}
        passwordConfirmTextField.validCondition = {
            guard let password = self.passwordTextField.text else {
                return false
            }
            return $0 == password
        }

        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordConfirmTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        nameTextField.successImage = UIImage(named: "success")
        nameTextField.errorImage = UIImage(named: "error")

        lastNameTextField.successImage = UIImage(named: "success")
        lastNameTextField.errorImage = UIImage(named: "error")
        
        passwordTextField.successImage = UIImage(named: "thumb_up")
        passwordTextField.errorImage = UIImage(named: "thumb_down")

        passwordConfirmTextField.successImage = UIImage(named: "thumb_up")
        passwordConfirmTextField.errorImage = UIImage(named: "thumb_down")

        emailTextField.successImage = UIImage(named: "success")
        emailTextField.errorImage = UIImage(named: "error")
    }
    var validDic = ["name": false, "lastName": false, "email":false, "pw":false, "pwc": false]

    var isValid: Bool? {
        didSet {
            comfirmButton.isEnabled = isValid ?? false
            comfirmButton.backgroundColor = isValid ?? false ? #colorLiteral(red: 0.568627451, green: 0.1921568627, blue: 0.4588235294, alpha: 1) : .lightGray
        }}
    @objc func textFieldDidChange(_ textfield: UITextField) {
        let tf = textfield as! ValidationTextField

        switch tf {
        case nameTextField:
            validDic["name"] = tf.isValid
        case lastNameTextField:
            validDic["lastName"] = tf.isValid
        case emailTextField:
            validDic["email"] = tf.isValid
        case passwordTextField:
            validDic["pw"] = tf.isValid
        case passwordConfirmTextField:
            validDic["pwc"] = tf.isValid
        default:
            break
        }

        isValid = validDic.reduce(true){ $0 && $1.value}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


 
    @IBAction func SignInBtn(_ sender: Any) {
       
        let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
   
           self.navigationController?.pushViewController(signInVC, animated: true)
    }
}
