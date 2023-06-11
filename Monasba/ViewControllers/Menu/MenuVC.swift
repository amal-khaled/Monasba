//
//  SettingVC.swift
//  Monasba
//
//  Created by iOSayed on 20/05/2023.
//

import UIKit

class MenuVC: UIViewController {

    //MARK: IBOutlet
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var logoutView: UIView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        ConfigureUI()
    }
    
    //MARK: Private Methods
    
    private func ConfigureUI(){
        
        dateLabel.text = FormattedDate()
        
        loginButton.shake()
        if StaticFunctions.isLogin() {
            //logged in
            userNameLabel.text = "\(AppDelegate.currentUser.name ?? "") \(AppDelegate.currentUser.lastName ?? "")"
            logoutView.isHidden = false
            loginButton.isHidden = true
        }else {
           // logged out
            userNameLabel.text = "Guest".localize
            logoutView.isHidden = true
            loginButton.isHidden = false
        }
    }
    
   
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
      //  basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
        basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
    }
    
    @IBAction func didTapProfileButton(_ sender: UIButton) {
        print("didTapProfileButton")
        if StaticFunctions.isLogin() {
            let vc = UIStoryboard(name: PROFILE_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: PROFILE_VCID) as! ProfileVC
            vc.modalPresentationStyle = .fullScreen
           // present(vc, animated: true)
            presentDetail(vc)
        }else {
            StaticFunctions.createErrorAlert(msg: "Please Login First To Can Go To Profile!".localize)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
            }
           
        }
       

    }
    
    @IBAction func didTapAddAdButton(_ sender: Any) {
//        let vc = UIStoryboard(name: ADVS_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: ADDADVS_VCID) as! AddAdvsVC
//        vc.modalPresentationStyle = .fullScreen
//        presentDetail(vc)
        
        if StaticFunctions.isLogin() {
            let vc = UIStoryboard(name: ADVS_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: ADDADVS_VCID) as! AddAdvsVC
            vc.modalPresentationStyle = .fullScreen
            presentDetail(vc)
        }else {
            StaticFunctions.createErrorAlert(msg: "Please Login First To Can Add Post!".localize)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
            }
        }
        
    }
    
    
    @IBAction func didTapFavoutitesButton(_ sender: UIButton) {
        
        if StaticFunctions.isLogin() {
            
        }else {
            StaticFunctions.createErrorAlert(msg: "Please Login First To Can Go To Favoutites!".localize)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
            }
            
        }
    }
    
    @IBAction func didTapMyAdsButton(_ sender: UIButton)  {
        if StaticFunctions.isLogin() {
            if let vc = UIStoryboard(name: MENU_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: MYADS_VCID) as? MyAdsVC {
                vc.modalPresentationStyle = .fullScreen
                presentDetail(vc)
                
            }
        }else {
            StaticFunctions.createErrorAlert(msg: "Please Login First To Can Go To Ads !".localize)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
            }
        }
    }
    
    
    @IBAction func didTapMyAsksButton(_ sender: UIButton) {
        
        if StaticFunctions.isLogin() {
            
        }else {
            StaticFunctions.createErrorAlert(msg: "Please Login First To Can Go To Asks!".localize)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
            }
        }

        
    }
    @IBAction func didTapChangeCountryButton(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: MENU_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: "ChangeCountryVC") as! ChangeCountryVC
        vc.modalPresentationStyle = .fullScreen
        presentDetail(vc)
    }
    
    @IBAction func didTapSettingsButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        vc.modalPresentationStyle = .fullScreen
        presentDetail(vc)
    }
    
    @IBAction func didTapVerifyAccountButton(_ sender: UIButton) {
        
        if StaticFunctions.isLogin() {
            let vc = UIStoryboard(name: MENU_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: "VerifyAccountVC") as! VerifyAccountVC
            vc.modalPresentationStyle = .fullScreen
            presentDetail(vc)
            
            
        }else {
            StaticFunctions.createErrorAlert(msg: "Please Login First To Can Go To Verify Account!".localize)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
            }
        }

    }
    
    @IBAction func didTapLogoutButton(_ sender: UIButton) {
        logout()
    }
    
    
    
}
extension MenuVC {
    
    func logout(){
       
        AppDelegate.currentUser.id = nil
        AppDelegate.currentUser.toke = nil
        AppDelegate.currentUser.pic = "-"
        AppDelegate.currentUser.name = "Guest".localize
        AppDelegate.defaults.string(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.synchronize()
        
        self.basicPresentation(storyName: MAIN_STORYBOARD, segueId: "homeT")
      
    }
}
