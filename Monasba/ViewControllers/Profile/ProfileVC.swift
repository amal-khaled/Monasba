//
//  ProfileVC.swift
//  Monasba
//
//  Created by iOSayed on 20/05/2023.
//

import UIKit
import MOLH
import MobileCoreServices

class ProfileVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak private var coverImageView: UIImageView!
    @IBOutlet weak private var userImageView: UIImageView!
    @IBOutlet weak private var VerifyUserImageView: UIImageView!
    @IBOutlet weak private var userFullNameLabel: UILabel!
    @IBOutlet weak private var emptyAdsView: UIView!
    @IBOutlet weak private var bioLabel: UILabel!
    @IBOutlet weak private var adsCountLabel: UILabel!
    @IBOutlet weak private var rateCountLabel: UILabel!
    @IBOutlet weak private var followersCountLabel: UILabel!
    @IBOutlet weak private var followingsCountLabel: UILabel!
    @IBOutlet weak private var firstNameLabel: UILabel!
    @IBOutlet weak private var mobileLabel: UILabel!
    @IBOutlet weak private var countryLabel: UILabel!
    @IBOutlet weak private var regionLabel: UILabel!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var lastNameLabel: UILabel!
    @IBOutlet weak private var passwordLabel: UILabel!
    @IBOutlet weak private var cityLabel: UILabel!
    
    @IBOutlet weak private var myAdsCollectionView: UICollectionView!
    
    //MARK: Properties
    
    private var products = [Product]()
    private var page = 1
    private var isTheLast = false
    private var EditProfileParams = [String:Any]()
    private var imageType = 0 //profileImage
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configureUI()
    }
    
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProfile()
        getProductsByUser()
        self.navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    
    
    //MARK: Private Methods
    
    private func configureUI(){
        
        myAdsCollectionView.delegate = self
        myAdsCollectionView.dataSource = self
        emptyAdsView.isHidden = true
        myAdsCollectionView.register(UINib(nibName: "ProfileProductsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileProductsCollectionViewCell")
        
        
    }
    
    private func getProfile(){
        ProfileController.shared.getProfile(completion: {[weak self] userProfile, msg in
            guard let self = self else {return}
            if let userProfile = userProfile {
                print("======= profile Data ======== ")
                print(userProfile)
                self.bindProfileData(from: userProfile)
               // self.getProductsByUser()
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
        
        if products.count == 0 && profileModel.numberOfProds == 0 {
            emptyAdsView.isHidden = false
//            myAdsCollectionView.isHidden = true
        }else {
            emptyAdsView.isHidden = true
//            myAdsCollectionView.isHidden = false
        }
        
        EditProfileParams =
        [
            "id":profileModel.id ?? 0,
            "mobile":profileModel.phone ?? "",
            "country_id":profileModel.countryId ?? 6
        ]
        
    }

    //MARK: IBActions
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func didTapEditProfileutton(_ sender: UIButton) {
        let vc = UIStoryboard(name: PROFILE_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        vc.modalPresentationStyle = .fullScreen
//        presentDetail(vc)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func didTapShareButton(_ sender: UIButton) {
        shareContent(text: "\(Constants.DOMAIN) \(AppDelegate.currentUser.id ?? 0)")
    }
    @IBAction func didTapChangeCoverButton(_ sender: UIButton) {
        imageType = 1 //Cover image
        displayImageActionSheet()
    }
    
    @IBAction func didTapChangeUserImageButton(_ sender: UIButton) {
        imageType = 0 // profile image
        displayImageActionSheet()
    }
    
    @IBAction func didTapMyadsButton(_ sender: UIButton) {
        
            if let vc = UIStoryboard(name: MENU_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: MYADS_VCID) as? MyAdsVC {
                vc.modalPresentationStyle = .fullScreen
                vc.userId = AppDelegate.currentUser.id ?? 0
                navigationController?.pushViewController(vc, animated: true)
                
            }
    }
    
    @IBAction func didTapRateButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapFollowersButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: PROFILE_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: "tabFollowVC") as! tabsFollowVC
        Constants.followOtherUserId = AppDelegate.currentUser.id ?? 0
        Constants.followIndex = 0
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapFollowingsButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: PROFILE_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: "tabFollowVC") as! tabsFollowVC
        Constants.followIndex = 1
        Constants.followOtherUserId = AppDelegate.currentUser.id ?? 0
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension ProfileVC {
    
   private func getProductsByUser(){
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
                print("Count of products: \(products.count)")
                      print("Message: \(msg)")
                self.myAdsCollectionView.reloadData()
            }else{
                StaticFunctions.createErrorAlert(msg: msg)
                self.page = self.page == 1 ? 1 : self.page - 1
            }
            
            //use 128 as user id to check
        }, userId: userId , page: page, countryId:countryId )
    }
    
    private func displayImageActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let selectAction = UIAlertAction(title: "Change Image", style: .default) { (_) in
                    self.openGallery()
                }
        // Customize the color of the actions
        selectAction.setValue(#colorLiteral(red: 0, green: 0.7860813737, blue: 0.7477947474, alpha: 1), forKey: "titleTextColor")
                alertController.addAction(selectAction)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                let imageView = UIImageView(image: UIImage(named: "imageadd"))
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
    
    
    private func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    private func changeProfileImage(image:UIImage){
        APIConnection.apiConnection.uploadImageConnection(completion: { success, message in
            if success {
                StaticFunctions.createSuccessAlert(msg: message)
            }else {
                StaticFunctions.createErrorAlert(msg: message)
            }
            
        }, link: Constants.EDIT_USER_URL, param: EditProfileParams, image: image, imageType: .profileImage)
    }
    
    private func changeCoverImage(image:UIImage){
        APIConnection.apiConnection.uploadImageConnection(completion: { success, message in
            if success {
                StaticFunctions.createSuccessAlert(msg: message)
            }else {
                StaticFunctions.createErrorAlert(msg: message)
            }
            
        }, link: Constants.EDIT_USER_URL, param: EditProfileParams, image: image, imageType: .coverImage)
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

//MARK: Picked image From Gallery

extension ProfileVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let capturedImage = info[.originalImage] as? UIImage {
            print("Captured image: \(capturedImage)")
           // self.images.append(capturedImage as UIImage)
            
            
            if imageType == 0 {
                //profile image
                userImageView.image = capturedImage
                changeProfileImage(image: capturedImage)
            }else{
                // cover image
                coverImageView.image = capturedImage
                changeCoverImage(image: capturedImage)
            }
           
        }
    }
        
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
}
