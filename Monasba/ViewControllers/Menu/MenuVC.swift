//
//  SettingVC.swift
//  Monasba
//
//  Created by iOSayed on 20/05/2023.
//

import UIKit
import MOLH

class MenuVC: UIViewController {

    //MARK: IBOutlet
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var logoutView: UIView!
  
    @IBOutlet weak var englishButton: UIButton!
    
    @IBOutlet weak var arabicButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        ConfigureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
        ConfigureUI()
        if MOLHLanguage.currentAppleLanguage() == "en"{
            englishButtonPressed()
        }else{
            arabicButtonPressed()
        }
    }
    
    //MARK: Private Methods
    
    private func ConfigureUI(){
        
//        navigationController?.navigationBar.isHidden = true
//        tabBarController?.tabBar.isHidden = false
        dateLabel.text = FormattedDate()
        
        loginButton.shake()
        if StaticFunctions.isLogin() {
            //logged in
            userNameLabel.text = "\(AppDelegate.currentUser.name ?? "") \(AppDelegate.currentUser.lastName ?? "")"
            userImageView.setImageWithLoading(url: AppDelegate.currentUser.pic ?? "")
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
//            presentDetail(vc)
            navigationController?.pushViewController(vc, animated: true)
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
            navigationController?.pushViewController(vc, animated: true)
        }else {
            StaticFunctions.createErrorAlert(msg: "Please Login First To Can Add Post!".localize)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
            }
        }
        
    }
    
    
    @IBAction func didTapFavoutitesButton(_ sender: UIButton) {
        
        if StaticFunctions.isLogin() {
            let vc = UIStoryboard(name: MENU_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: "FavouritesVC") as! FavouritesVC
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
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
                vc.userId = AppDelegate.currentUser.id ?? 0
//                presentDetail(vc)
                vc.navigationController?.navigationBar.isHidden = false
                navigationController?.pushViewController(vc, animated: true)
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
            
            let vc = UIStoryboard(name: MENU_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: "MyAsksVC") as! MyAsksVC
            vc.modalPresentationStyle = .fullScreen
    //        presentDetail(vc)
            navigationController?.pushViewController(vc, animated: true)
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
//        presentDetail(vc)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapSettingsButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        vc.modalPresentationStyle = .fullScreen
//        presentDetail(vc)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapVerifyAccountButton(_ sender: UIButton) {
        
        if StaticFunctions.isLogin() {
            let vc = UIStoryboard(name: MENU_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: "VerifyAccountVC") as! VerifyAccountVC
            vc.modalPresentationStyle = .fullScreen
//            presentDetail(vc)
            navigationController?.pushViewController(vc, animated: true)
            
            
        }else {
            StaticFunctions.createErrorAlert(msg: "Please Login First To Can Go To Verify Account!".localize)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
            }
        }

    }
    
    //Change Language
    
    
    @IBAction func didTapEnglishButton(_ sender: UIButton) {
        if MOLHLanguage.currentAppleLanguage() != "en" {
            MOLH.setLanguageTo("en")
            englishButtonPressed()
            if #available(iOS 13.0, *) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    let delegate = UIApplication.shared.delegate as? AppDelegate
                    delegate!.swichRoot()
                }
            } else {
                // Fallback on earlier versions
                MOLH.reset()
            }
        }
    }
    
    @IBAction func didTapArabicButton(_ sender: UIButton) {
        if MOLHLanguage.currentAppleLanguage() != "ar" {
            MOLH.setLanguageTo("ar")
            arabicButtonPressed()
            if #available(iOS 13.0, *) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    let delegate = UIApplication.shared.delegate as? AppDelegate
                    delegate!.swichRoot()
                }
                
            } else {
                // Fallback on earlier versions
                MOLH.reset()
            }
        }
    }
    
    @IBAction func didTapLogoutButton(_ sender: UIButton) {
        displayImageActionSheet()
      //  logout()
    }
    
    
    fileprivate func arabicButtonPressed(){
        arabicButton.backgroundColor = UIColor(named: "#0EBFB1")
        englishButton.backgroundColor = UIColor.white
        arabicButton.setTitleColor(UIColor.white, for: .normal)
        englishButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    fileprivate func englishButtonPressed(){
        englishButton.backgroundColor = UIColor(named: "#0EBFB1")
        englishButton.setTitleColor(UIColor.white, for: .normal)
        arabicButton.setTitleColor(UIColor.black, for: .normal)
        arabicButton.backgroundColor = UIColor.white
    }
    
    
}
extension MenuVC {
    
    private func displayImageActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let selectAction = UIAlertAction(title: "Log out".localize, style: .default) { (_) in
                    self.logout()
                }
        // Customize the color of the actions
        selectAction.setValue(UIColor.red, forKey: "titleTextColor")
                alertController.addAction(selectAction)
        let cancelAction = UIAlertAction(title: "Cancel".localize, style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                let imageView = UIImageView(image: UIImage(named: "log-out"))
                imageView.contentMode = .scaleAspectFit
                imageView.clipsToBounds = true
                let imageWidth: CGFloat = 20
                let imageHeight: CGFloat = 20
                let padding: CGFloat = 16.0
                let customView = UIView(frame: CGRect(x: padding, y: padding, width: imageWidth, height: imageHeight))
                imageView.frame = customView.bounds
                customView.addSubview(imageView)
                alertController.view.addSubview(customView)
                alertController.view.bounds.size.height += (imageHeight + padding * 2)
                present(alertController, animated: true, completion: nil)
       }
    
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
