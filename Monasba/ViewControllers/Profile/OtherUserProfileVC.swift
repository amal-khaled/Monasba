//
//  OtherUserProfileVC.swift
//  Monasba
//
//  Created by iOSayed on 01/05/2023.
//

import UIKit
import MOLH

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
    
    
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        userNameLabel.text = "@ISOAYED"
//        fullNameUserLabel.text = "Elsayed Ahmed"
//        UserLocationLabel.text = "Cairo,Egypt"
//        userBioLabel.text = "hello every body I'm here, hello every body I'm here "
//        userImageView.image = UIImage(named: "logo_photo")
//        CoverImageView.image = UIImage(named: "login_bg")
//        advsCountLabel.text = "1220"
//        followersCountLabel.text = "15"
//        followingsCountLabel.text = "10"
//        userVerifiedImageView.isHidden = false
        getProfile()

    }
    

    @IBAction func BackBtnAction(_ sender: UIButton) {
        dismissDetail()
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
extension OtherUserProfileVC {
    private func getProfile(){
        ProfileController.shared.getProfile(completion: {[weak self] userProfile, msg in
            guard let self = self else {return}
            if let userProfile = userProfile {
                print("======= profile Data ======== ")
                print(userProfile)
                self.bindProfileData(from: userProfile)
               // self.getProductsByUser()
            }
        }, user: user)
    }
    
    private func bindProfileData(from profileModel:User){
        if let cover =  profileModel.cover {
            if cover.contains(".png") || cover.contains(".jpg"){
                CoverImageView.setImageWithLoading(url:profileModel.cover ?? "" )
            }
        }
        if let userPic =  profileModel.pic {
            if userPic.contains(".png") || userPic.contains(".jpg"){
                userImageView.setImageWithLoading(url:profileModel.pic ?? "" )
            }
        }
        
        fullNameUserLabel.text = "\(profileModel.name ?? "") \(profileModel.lastName ?? "")"
        if profileModel.verified != 0 {
            userVerifiedImageView.isHidden = false
        }else{
            userVerifiedImageView.isHidden = true
        }
        
        advsCountLabel.text = "\(profileModel.numberOfProds ?? 0)"
        followersCountLabel.text = "\(profileModel.followers ?? 0)"
        followingsCountLabel.text = "\(profileModel.following ?? 0)"
//        rateCountLabel.text = "\(profileModel.userRate ?? 0)"
//        firstNameLabel.text = profileModel.name
//        lastNameLabel.text = profileModel.lastName
        userNameLabel.text = profileModel.username
//        passwordLabel.text = "******"
        
        userBioLabel.text = profileModel.bio
        if MOLHLanguage.currentAppleLanguage() == "en" {
            UserLocationLabel.text = "\(profileModel.countriesNameEn ?? "") - \(profileModel.citiesNameEn ?? "")"
//            cityLabel.text = profileModel.citiesNameEn
//            regionLabel.text = profileModel.regionsNameEn
        }else {
            UserLocationLabel.text = "\(profileModel.countriesNameAr ?? "") - \(profileModel.citiesNameAr ?? "")"
//            cityLabel.text = profileModel.citiesNameAr
//            regionLabel.text = profileModel.regionsNameAr
        }
        
        
    }
}

