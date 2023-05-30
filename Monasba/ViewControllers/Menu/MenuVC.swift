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
        basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
    }
    
    @IBAction func didTapProfileButton(_ sender: UIButton) {
        print("didTapProfileButton")
        let vc = UIStoryboard(name: PROFILE_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: PROFILE_VCID) as! ProfileVC
        vc.modalPresentationStyle = .fullScreen
       // present(vc, animated: true)
        presentDetail(vc)

    }
    
    @IBAction func didTapAddAdButton(_ sender: Any) {
        let vc = UIStoryboard(name: ADVS_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: ADDADVS_VCID) as! AddAdvsVC
        vc.modalPresentationStyle = .fullScreen
        presentDetail(vc)
        
    }
    
    
    @IBAction func didTapFavoutitesButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapMyAdsButton(_ sender: UIButton)  {
        if let vc = UIStoryboard(name: MENU_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: MYADS_VCID) as? MyAdsVC {
            vc.modalPresentationStyle = .fullScreen
            presentDetail(vc)
            
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
