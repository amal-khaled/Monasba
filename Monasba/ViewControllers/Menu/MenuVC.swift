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
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var logoutView: UIView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        ConfigureUI()
    }
    
    //MARK: Private Methods
    
    private func ConfigureUI(){
        loginButton.shake()
        if AppDelegate.currentUser.toke == nil {
            logoutView.isHidden = false
        }else {
            logoutView.isHidden = true
        }
    }
    
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
      //  basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
        basicNavigation(storyName: Auth_STORYBOARD, segueId: "login_nav")
    }
    
    @IBAction func didTapProfileButton(_ sender: UIButton) {
        print("didTapProfileButton")
        let vc = UIStoryboard(name: PROFILE_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: PROFILE_VCID) as! ProfileVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)

    }
    
    @IBAction func didTapAddAdButton(_ sender: Any) {
    }
    
    @IBAction func didTapFavoutitesButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapMyAdsButton(_ sender: UIButton)  {
        if let vc = UIStoryboard(name: MENU_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: "MyAdsVC") as? MyAdsVC {
            vc.modalPresentationStyle = .fullScreen
            vc.title = "MyAds"
            navigationController?.pushViewController(vc, animated: true)
            
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
