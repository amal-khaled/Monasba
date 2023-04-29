//
//  LoginViewController.swift
//  Monasba
//
//  Created by Amal Elgalant on 16/04/2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordErrorLbl: UILabel!
    @IBOutlet weak var phoneErorrLbl: UILabel!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var coountryCode: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    var countryCode = "965"
   var isPasswordHidden = true
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    @objc func textDidChange(_ notification: Notification){
        enableButton()
        
    }
    @IBAction func chooseCountry(_ sender: Any) {
    }
    
    @IBAction func showPasswordAction(_ sender: UIButton) {
        isPasswordHidden = !isPasswordHidden
        isPasswordHidden
        ? sender.setImage( UIImage(systemName: "eye"), for: .normal) : sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        
        passwordTF.isSecureTextEntry = isPasswordHidden
    }
    @IBAction func forgetPasswordAction(_ sender: Any) {
    }
    @IBAction func loginAction(_ sender: Any) {
    }
    @IBAction func createAction(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        let (valid , message) = ValidTextField(textField: textField)
        
        if textField == phoneTF{
            StaticFunctions.seteErrorLblStatus(errorLbl: phoneErorrLbl, status: valid, msg: message ?? "")
        }
     
        else if textField == passwordTF{
            StaticFunctions.seteErrorLblStatus(errorLbl: passwordErrorLbl, status: valid, msg: message ?? "")
        }
        
        
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
      if textField == phoneTF{
            passwordTF.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == phoneTF ){
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        return true
    }
    
}
extension LoginViewController{
   
    func ValidTextField(textField : UITextField)->(Bool, String?) {
         if textField == phoneTF {
            if (phoneTF.text!.count != 0 ){
                if StaticFunctions.checkValidPhonNumber(Phone: countryCode + phoneTF.text!) {
                    return (true ,nil )
                    
                }
                else {
                    return (false ,NSLocalizedString("enter valid phone number".lowercased(),comment:"") )                               }
            }
             else {
                 return (false ,NSLocalizedString("enter valid phone number".lowercased(),comment:"") )                               }
            
        }
        
        else if textField == passwordTF{
            if passwordTF.text!.count < 6{
                return (false ,NSLocalizedString("password should be greater than 6 digits", comment: ""))
                
            }
            else {
                return (true ,nil )
                
            }
        }
        
        return (true ,nil )
    }
    func enableButton(){
        var formIsValid = true
        for textField in textFields {
            // Validate Text Field
            let (valid,_) = ValidTextField(textField: textField)
            
            
            guard valid else {
                formIsValid = false
                break
            }
        }
        
        StaticFunctions.enableBtn(btn: loginBtn, status: formIsValid)
    }
    
    
     func login() {
       
//         StaticFunctions.enableBtnWithoutAlpha(btn: loginBtn, status: false)
//         if Reachability.isConnectedToNetwork(){
//             self.loginBtn.startAnimation()
//
//             AuthController.shared.Login(completion: {
//                 check, msg in
//                 self.loginBtn.stopAnimation(animationStyle: .normal, revertAfterDelay: 0, completion: nil)
//                 StaticFunctions.enableBtnWithoutAlpha(btn: self.loginBtn, status: true)
//
//                 if check == 0{
////                     UtilitiesController.shared.SendPlayerId(playerID: AppDelegate.playerID)
//                     StaticFunctions.createSuccessAlert(msg: msg)
//
//                     self.basicNavigation(storyName: MAIN_STORYBOARD, segueId: "main_tap")
//                 }else{
//                     StaticFunctions.createErrorAlert(msg: msg)
//
//                 }
//
//             }, email: emailTF.text!, password: passwordTF.text!, phone: phoneTF.text!, isPhone: isMobile, isEmail: isemail)
//
//         }
//         else{
//             StaticFunctions.enableBtnWithoutAlpha(btn: loginBtn, status: true)
//
//             StaticFunctions.createErrorAlert(msg: NO_INTERNET_CONNECTION)
//         }
    }
    
    
    
}
