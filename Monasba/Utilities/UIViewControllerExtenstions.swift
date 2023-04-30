//
//  UIViewControllerExtenstions.swift
//  WeasyVendor
//
//  Created by Amal Elgalant on 2/6/20.
//  Copyright © 2020 Amal Elgalant. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import PhoneNumberKit
extension UIViewController :NVActivityIndicatorViewable{
    
    //check email validation
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func setupView(name: String, editProfile: Bool = false, noBack: Bool = false){
        backUsingSWip()
        
        
        
        
        //
        //
        
        let notification = UIBarButtonItem(image: #imageLiteral(resourceName: "Icon ionic-ios-notifications"), style: .plain, target: self, action: #selector(openNotification))
//        if StaticFunctions.isLogin(){
//            self.getNotifications(){counter in
//                if counter > 0{
//                    notification.addBadge(number: counter)
//                }else{
//                    notification.removeBadge()
//                }
//
//            }
//
//
//        }
        navigationItem.rightBarButtonItems = [notification]
        
        
        let titleBtn = UIBarButtonItem(title: name, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItems = [titleBtn]
        if !noBack{
            let backBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "icon-arrow"), style: .plain, target: self, action: #selector(back))
            navigationItem.leftBarButtonItems?.insert(backBtn, at: 0)
            
        }
        
        
        
        if editProfile{
            let editBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "Edit"), style: .plain, target: self, action: #selector(EditProfile))
            navigationItem.rightBarButtonItems?.append(editBtn) 
        }
        
        
    }
//    func getNotifications(completion: @escaping(Int)->()){
//        if Reachability.isConnectedToNetwork(){
//            UtilitiesController.shared.getNotifications(completion: {
//                notifications , check, msg in
//                if check == 0 {
//                    completion(notifications.counter)
//                }
//                else{
//                    completion(-1)
//
//                }
//            }, open: false)
//        }else{
//            completion(-1)
//
//        }
//    }
    @objc func openNotification(){
//        basicNavigation(storyName: MAIN_STORYBOARD, segueId: NOTIFICATION_VCID)
    }
    @objc func EditProfile(){
//        basicNavigation(storyName: ACCOUNT_STORYBOARD, segueId: EDIT_PROFILE)
    }
    
    func basicNavigation(storyName: String, segueId: String, withAnimation: Bool = true){
        
        let vc = UIStoryboard(name: storyName, bundle: nil).instantiateViewController(withIdentifier: segueId)
        self.navigationController?.pushViewController(vc, animated: withAnimation)
    }
    func basicPresentation(storyName: String, segueId: String, withAnimation: Bool = true){
        
        let vc = UIStoryboard(name: storyName, bundle: nil).instantiateViewController(withIdentifier: segueId)
        self.present(vc, animated: withAnimation, completion: nil)
    }
    func Login() {
        let vc = UIStoryboard(name: Auth_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: LOGIN_VCID)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @objc func back(){
        // move to menu
        //                self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    func backUsingSWip(){
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func clossKeyBoard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func noInternetDialog(){
        
        let refreshAlert = UIAlertController(title: "", message:  NSLocalizedString(NO_INTERNET_CONNECTION,comment:""), preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title:NSLocalizedString( "OK",comment:""), style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        present(refreshAlert, animated: true)
        
        
        
        
        
    }
    func noLoginInternetDialog(){
        
        let refreshAlert = UIAlertController(title: "", message:  NSLocalizedString(NO_INTERNET_CONNECTION,comment:""), preferredStyle: UIAlertController.Style.alert)
        
        
        refreshAlert.addAction(UIAlertAction(title:NSLocalizedString( "close Weasy",comment:""), style: .default, handler: { (action: UIAlertAction!) in
            exit(0);
        }))
        
        present(refreshAlert, animated: true)
        
    }
    
    
    func checkValidPhonNumber(Phone:String  )->Bool{
        do {
            let phoneNumberKit = PhoneNumberKit()
            let phoneNumber = try phoneNumberKit.parse(Phone)
            
            return true
            
        }
        catch {
            return false
            
        }
    }
    
    
    
}
// Helper function inserted by Swift 4.2 migrator.
func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
/*
 let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
 imageView.contentMode = .ScaleAspectFit
 
 let image = UIImage(named: "googlePlus")
 imageView.image = image
 
 navigationItem.titleView = imageView
 */
