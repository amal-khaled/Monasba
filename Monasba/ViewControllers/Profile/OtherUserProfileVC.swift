//
//  OtherUserProfileVC.swift
//  Monasba
//
//  Created by iOSayed on 01/05/2023.
//

import UIKit

class OtherUserProfileVC: UIViewController {

    //MARK: IBOutlets
    
    
    @IBOutlet weak var CoverImageView: UIImageView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userVerifiedImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var fullNameUserLabel: UILabel!
    
    @IBOutlet weak var UserLocationLabel: UILabel!
    
    @IBOutlet weak var userBioLabel: UILabel!
    
    @IBOutlet weak var notificationImageView: UIImageView!
    
    @IBOutlet weak var advsCountLabel: UILabel!
    
    @IBOutlet weak var followersCountLabel: UILabel!
    
    @IBOutlet weak var followingsCountLabel: UILabel!
    
    @IBOutlet weak var pages: UIView!
    
    @IBOutlet weak var chatButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = "@ISOAYED"
        fullNameUserLabel.text = "Elsayed Ahmed"
        UserLocationLabel.text = "Cairo,Egypt"
        userBioLabel.text = "hello every body I'm here, hello every body I'm here "
        userImageView.image = UIImage(named: "logo_photo")
        CoverImageView.image = UIImage(named: "login_bg")
        advsCountLabel.text = "1220"
        followersCountLabel.text = "15"
        followingsCountLabel.text = "10"
        userVerifiedImageView.isHidden = false

    }
    

    @IBAction func BackBtnAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func shareBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func reportAboutUserBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func blockUserBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func followBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func activeNotificationBtnAction(_ sender: UIButton) {
        
    }
    @IBAction func advsBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func FollowersBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func followingsBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func chatBtnAction(_ sender: UIButton) {
        
    }
    
    
}

