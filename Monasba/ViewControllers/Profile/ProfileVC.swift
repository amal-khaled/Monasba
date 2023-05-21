//
//  ProfileVC.swift
//  Monasba
//
//  Created by iOSayed on 20/05/2023.
//

import UIKit
import MOLH

class ProfileVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak private var coverImageView: UIImageView!
    @IBOutlet weak private var userImageView: UIImageView!
    @IBOutlet weak private var VerifyUserImageView: UIImageView!
    @IBOutlet weak private var userFullNameLabel: UILabel!
    @IBOutlet weak private var emptyAdsLabel: UILabel!
    @IBOutlet weak private var bioLabel: UILabel!
    @IBOutlet weak private var adsCountLabel: UILabel!
    @IBOutlet weak private var rateCountLabel: UILabel!
    @IBOutlet weak private var followersCountLabel: UILabel!
    @IBOutlet weak private var followingsCountLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak private var myAdsCollectionView: UICollectionView!
    
    //MARK: Properties
    
    private var products = [Product]()
    private var page = 1
    private var isTheLast = false
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProfile()
    }
    
    
    //MARK: Private Methods
    
    private func configureUI(){
        
        myAdsCollectionView.delegate = self
        myAdsCollectionView.dataSource = self
        emptyAdsLabel.isHidden = true
        myAdsCollectionView.register(UINib(nibName: "ProfileProductsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileProductsCollectionViewCell")
        
        
    }
    
    private func getProfile(){
        ProfileController.shared.getProfile(completion: {[weak self] userProfile, msg in
            guard let self = self else {return}
            if let userProfile = userProfile {
                print("======= profile Data ======== ")
                print(userProfile)
                self.bindProfileData(from: userProfile)
                self.getProductsByUser()
            }
        }, user: AppDelegate.currentUser)
    }
    
    private func bindProfileData(from profileModel:User){
        if let cover =  profileModel.cover {
            if cover.contains(".png") || cover.contains(".jpg"){
                coverImageView.setImageWithLoading(url:profileModel.cover ?? "" )
            }
        }
        if let userPic =  profileModel.pic {
            if userPic.contains(".png") || userPic.contains(".jpg"){
                userImageView.setImageWithLoading(url:profileModel.pic ?? "" )
            }
        }
        
        userFullNameLabel.text = "\(profileModel.name ?? "") \(profileModel.lastName ?? "")"
        if profileModel.verified != 0 {
            VerifyUserImageView.isHidden = false
        }else{
            VerifyUserImageView.isHidden = true
        }
        
        adsCountLabel.text = "\(profileModel.numberOfProds ?? 0)"
        followersCountLabel.text = "\(profileModel.followers ?? 0)"
        followingsCountLabel.text = "\(profileModel.following ?? 0)"
        rateCountLabel.text = "\(profileModel.userRate ?? 0)"
        firstNameLabel.text = profileModel.name
        lastNameLabel.text = profileModel.lastName
        userNameLabel.text = profileModel.username
        passwordLabel.text = "******"
        
        mobileLabel.text = profileModel.phone
        bioLabel.text = profileModel.bio
        if MOLHLanguage.currentAppleLanguage() == "en" {
            countryLabel.text = profileModel.countriesNameEn
            cityLabel.text = profileModel.citiesNameEn
            regionLabel.text = profileModel.regionsNameEn
        }else {
            countryLabel.text = profileModel.countriesNameAr
            cityLabel.text = profileModel.citiesNameAr
            regionLabel.text = profileModel.regionsNameAr
        }
        
        if profileModel.numberOfProds == 0 {
            emptyAdsLabel.isHidden = false
            myAdsCollectionView.isHidden = true
        }else {
            emptyAdsLabel.isHidden = true
            myAdsCollectionView.isHidden = false
        }
        
        
    }

    //MARK: IBActions
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func didTapEditProfileutton(_ sender: UIButton) {
    }
    @IBAction func didTapShareButton(_ sender: UIButton) {
    }
    @IBAction func didTapChangeCoverButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapChangeUserImageButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapMyadsButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapRateButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapFollowersButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapFollowingsButton(_ sender: UIButton) {
    }
    
    
}
extension ProfileVC {
    
    func getProductsByUser(){
        guard let userId = AppDelegate.currentUser.id , let countryId = AppDelegate.currentUser.countryId else{return}
        
        ProfileController.shared.getProductsByUser(completion: {
            products, check, msg in
            print(products.count)
            if check == 0{
                if self.page == 1 {
                    self.products.removeAll()
                    self.products = products
                    
                }else{
                    self.products.append(contentsOf: products)
                }
                if products.isEmpty{
                    self.page = self.page == 1 ? 1 : self.page - 1
                    self.isTheLast = true
                }
                self.myAdsCollectionView.reloadData()
            }else{
                StaticFunctions.createErrorAlert(msg: msg)
                self.page = self.page == 1 ? 1 : self.page - 1
            }
            
            //use 128 as user id to check
        }, userId: userId , page: page, countryId:countryId )
    }
    
}

extension ProfileVC:UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileProductsCollectionViewCell", for: indexPath) as? ProfileProductsCollectionViewCell else {return UICollectionViewCell()}
        productCell.setData(product: products[indexPath.item])
        return productCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: myAdsCollectionView.frame.width - 30, height: 120)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (products.count-1) && !isTheLast{
            page+=1
            getProductsByUser()
            
        }
    }
  
    
    
}
