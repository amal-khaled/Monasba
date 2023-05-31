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
        
        userNameLabel.text = "\(AppDelegate.currentUser.name ?? "") \(AppDelegate.currentUser.lastName ?? "")"
        dateLabel.text = FormattedDate()
        
        loginButton.shake()
        if AppDelegate.currentUser.toke == nil {
            logoutView.isHidden = false
            logoutView.isHidden = false
        }else {
            logoutView.isHidden = true
            loginButton.isHidden = true
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
            StaticFunctions.createErrorAlert(msg: "Please Login First To Can Go To Profile!")
            basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
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
            StaticFunctions.createErrorAlert(msg: "Please Login First To Can Add Post!")
            basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
        }
        
    }
    
    
    @IBAction func didTapFavoutitesButton(_ sender: UIButton) {
        
        if StaticFunctions.isLogin() {
            
        }else {
            StaticFunctions.createErrorAlert(msg: "Please Login First To Can Go To Favoutites!")
            basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
        }
    }
    
    @IBAction func didTapMyAdsButton(_ sender: UIButton)  {
       
        
        if StaticFunctions.isLogin() {
            if let vc = UIStoryboard(name: MENU_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: MYADS_VCID) as? MyAdsVC {
                vc.modalPresentationStyle = .fullScreen
                presentDetail(vc)
                
            }
        }else {
            StaticFunctions.createErrorAlert(msg: "Please Login First To Can Go To Ads !")
            basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
        }
    }
    
    
    @IBAction func didTapMyAsksButton(_ sender: UIButton) {
        
    }
    @IBAction func didTapChangeCountryButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapSettingsButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapVerifyAccountButton(_ sender: UIButton) {
        
    }
    
    @IBAction func didTapLogoutButton(_ sender: UIButton) {
    }
    
    
    
}
