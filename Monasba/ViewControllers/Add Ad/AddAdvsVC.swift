//
//  AddAdvsVC.swift
//  Monasba
//
//  Created by iOSayed on 01/05/2023.
//

import UIKit
import DropDown
import MOLH
import IQKeyboardManagerSwift
import Alamofire
import TransitionButton


class AddAdvsVC: UIViewController , PickupMediaPopupVCDelegate {
   
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var addMorePhotoButton: UIButton!
    @IBOutlet weak var firstImageViewContainer: UIView!
    @IBOutlet weak var moreImageViewContainer: UIView!
    @IBOutlet weak var advsTitleTF: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var sellViewContainer: UIView!
    
    @IBOutlet weak var rentViewContainer: UIView!
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var sellButtonImageView: UIImageView!
    @IBOutlet weak var sellButtonLabel: UILabel!
    @IBOutlet weak var rentButton: UIButton!
    @IBOutlet weak var rentButtonLabel: UILabel!
    @IBOutlet weak var rentButtonImageView: UIImageView!
    
    //connection Buttons
    
    @IBOutlet weak var phoneCallViewContainer: UIView!
    @IBOutlet weak var chatViewContainer: UIView!
    @IBOutlet weak var whatsViewContainer: UIView!
    
    @IBOutlet weak var hasCallLabel: UILabel!
    @IBOutlet weak var hasPhoneImageView: UIImageView!
    
    @IBOutlet weak var hasWhatsLabel: UILabel!
    @IBOutlet weak var hasWhatsImageView: UIImageView!
    
    @IBOutlet weak var hasChatLabel: UILabel!
    @IBOutlet weak var hasChatImageView: UIImageView!
    
    //Advs Details (cats & Location labels )
    @IBOutlet weak var mainCatsLabel: UILabel!
    @IBOutlet weak var subCatsLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var mainCatButton: UIButton!
    @IBOutlet weak var subCatButton: UIButton!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var regionButton: UIButton!
    
    //Add new Phone Number view
    
    @IBOutlet weak var useRegisteredPhoneButton: UIButton!
    
    @IBOutlet weak var useNewPhoneNumButton: UIButton!
    @IBOutlet weak var addNewPhoneLabel: UILabel!
    @IBOutlet weak var addNewPhoneViewContainer: UIView!
    @IBOutlet weak var newPhoneCountryFlag: UIImageView!
    @IBOutlet weak var newPhoneCountryCode: UILabel!
    @IBOutlet weak var newPhoneTF: UITextField!
    
    @IBOutlet weak var AddAdvsButton: TransitionButton!
    
    
    
    //MARK: Poropreties
    
    var hasPhone = "on"
    var hasWhats = "off"
    var hasChat = "off"
    var hasNewPhone = false
    var countryId = AppDelegate.currentUser.countryId ?? 0
    
    // Main Category DropDwon
    var mainCatID:Int = -1
    var mainCatName:String = ""
    var mainCatsList = [String]()
    var mainCatsIDsList = [Int]()
    
    let mainCatDropDwon = DropDown()
    
    // Sub Category DropDwon
    var subCatID:Int = -1
    var subCatName:String = ""
    var subCatsList = [String]()
    var subCatsIDsList = [Int]()
    
    let subCatDropDwon = DropDown()
    
    // City Category DropDwon
    var cityId:Int = AppDelegate.currentUser.cityId ?? 0
    var cityName:String = ""
    var cityList = [String]()
    var cityIDsList = [Int]()
    
    let cityDropDwon = DropDown()
    
    // regions DropDwon
    var regionId:Int = AppDelegate.currentUser.regionId ?? 0
    var regionName:String = ""
    var regionsList = [String]()
    var regionsIDsList = [Int]()
    
    let regionsDropDwon = DropDown()
//    AppDelegate.currentUser.phone
    var phone:String {
        if hasNewPhone {
            return "\(newPhoneCountryCode.text ?? "")\(newPhoneTF.text!)"
        }else {
            return AppDelegate.currentUser.phone ?? ""
        }
    }
    var tajeer = 0
    var params = [String:Any]()
    
    var selectedImages = [UIImage]()
    var images = [String:UIImage]()
    var mediaKeys = [String]()
    var selectedMedia = [String:Data]()
    var selectedMediaKeys = [String]()
    var mainImageKey:String = ""
    var selectedIndexPath: IndexPath = [0,0]
    //MARK: App LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        customizeDropDown()
        getCitis()
        getMainCats()
        //setupCitiesDropDown()
        getDataFromSession()
        configureUI()
        
        advsTitleTF.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationItem.backBarButtonItem?.tintColor = .white
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        
    }
    
    
    private func configureUI(){
        if selectedImages.isEmpty {
            firstImageViewContainer.isHidden = false
            moreImageViewContainer.isHidden = true
            addMorePhotoButton.isHidden = true
            collectionView.isHidden = true
            
        }else {
            moreImageViewContainer.isHidden = false
            addMorePhotoButton.isHidden = false
            collectionView.isHidden = false
            firstImageViewContainer.isHidden = true
        }
    }
    
    private func getDataFromSession(){
        guard  let title = retrieveSessionData().title , let selectedMedia = retrieveSessionData().selectedMedia ,let selectedMediaKeys = retrieveSessionData().selectedMediaKeys , let mainImageKey = retrieveSessionData().mainImageKey  else {return}
        self.selectedMedia = selectedMedia
        self.selectedMediaKeys = selectedMediaKeys
        advsTitleTF.text = title
        newPhoneTF.text = AppDelegate.currentUser.phone ?? ""
        cityId = retrieveSessionData().CityId ?? 0
        regionId = retrieveSessionData().RegionId ?? 0
        mainCatID = retrieveSessionData().catId ?? 0
        subCatID = retrieveSessionData().subCatId ?? 0
        priceTF.text = retrieveSessionData().price
        descTextView.text = retrieveSessionData().description
//        self.mainImageKey = mainImageKey
//        if let imageDatas = retrieveSessionData().images {
////            selectedImages = imageDatas.compactMap { UIImage(data: $0.value) }
////            guard let mediaKeys = retrieveSessionData().mediaKeys else {return}
////            images = Dictionary(uniqueKeysWithValues: zip(images.keys, UIImage(data:imageDatas.values)))
//            DispatchQueue.main.async {
//                self.addMorePhotoButton.isHidden = false
//                self.moreImageViewContainer.isHidden = false
//                self.collectionView.isHidden = false
//                self.firstImageViewContainer.isHidden = true
//                self.collectionView.reloadData()
//            }
//
//            }
        
        
        if let imageDatas = retrieveSessionData().images {
            images = [:] // Clear the existing images dictionary
            selectedImages = imageDatas.compactMap { UIImage(data: $0.value) }
            
            for (key, imageData) in imageDatas {
                if let image = UIImage(data: imageData) {
                    images[key] = image
                }
                
                DispatchQueue.main.async {
                    self.addMorePhotoButton.isHidden = false
                    self.moreImageViewContainer.isHidden = false
                    self.collectionView.isHidden = false
                    self.firstImageViewContainer.isHidden = true
                    self.collectionView.reloadData()
                }
             
            }
            
        }
       
    }
    
    func PickupMediaPopupVC(_ controller: PickupMediaPopupVC, didSelectImages images: [String:UIImage],mediaKeys:[String],selectedMedia:[String:Data] ) {
       // self.dismiss(animated: false)
       // self.Images.append(contentsOf: images)
        print(selectedMedia)
         selectedMediaKeys = selectedMedia.keys.sorted()
        self.images = images
        self.selectedImages = Array(images.values)
        mainImageKey = Array(images.keys)[0]
        self.mediaKeys = mediaKeys
        self.selectedMedia = selectedMedia
//        selectFirstCell()
        print("Images Count ", images.count)
        print("mediaKeys =======>",mediaKeys)
        print("Videos Count " , mediaKeys.count)
        print("selectedMedia ------->",selectedMedia)
        if images.count > 0 {
            firstImageViewContainer.isHidden = true
            moreImageViewContainer.isHidden = false
            addMorePhotoButton.isHidden = false
            collectionView.isHidden = false
            
        }else {
//            moreImageViewContainer.isHidden = true
            addMorePhotoButton.isHidden = true
           // collectionView.isHidden = true
           // firstImageViewContainer.isHidden = false
        }
        self.collectionView.reloadData()
       
    }

    func setupCity(){
        for i in  Constants.CITIES {
            if  MOLHLanguage.currentAppleLanguage() == "en" {
                
                cityList.append(i.nameEn ?? "")
                cityIDsList.append(i.id ?? 0)
            }
            else{
                cityList.append(i.nameAr ?? "")
                cityIDsList.append(i.id ?? 0)
            }
        }
    }
    
    
    //MARK: IBActions
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        saveSessionData(images: images, mediaKeys: Array(images.keys), description: descTextView.text, title: advsTitleTF.text ?? "", price: priceTF.text ?? "", catId: mainCatID, subCatId: subCatID, CityId: cityId, RegionId: regionId,selectedMedia: selectedMedia,selectedMediaKeys: selectedMediaKeys,mainImageKey: self.mainImageKey)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
        self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    @IBAction func addPhotoBtnAction(_ sender: UIButton) {
        if selectedImages.count < 6 {
            let vc = UIStoryboard(name: ADVS_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier:  PICKUP_MEDIA_POPUP_VCID) as! PickupMediaPopupVC
            vc.delegate = self
            vc.images = images
            vc.mediaKeys = mediaKeys
            vc.selectedMedia = selectedMedia
            present(vc, animated: false)
        }else{
            StaticFunctions.createErrorAlert(msg: "You have reached the limit of videos and photos".localize)
        }
        
    }
    
    @IBAction func mainCatsBtnAction(_ sender: UIButton) {
        mainCatDropDwon.show()
    }
    
    @IBAction func subCatsBtnAction(_ sender: UIButton) {
        subCatDropDwon.show()
    }
    
    @IBAction func cityBtnAction(_ sender: UIButton) {
        cityDropDwon.show()
    }
    
    @IBAction func regionBtnAction(_ sender: UIButton) {
        regionsDropDwon.show()
    }
    
    
    @IBAction func rentBtnAction(_ sender: UIButton) {
        setupRentViewUI()
    }
    @IBAction func sellBtnAction(_ sender: UIButton) {
        setupSellViewUI()
    }
    
    @IBAction func phoneBtnAction(_ sender: UIButton) {
        if (hasPhone == "off"){
            hasPhone = "on"
            setupHasPhoneViewUI()
        }else{
            hasPhone = "off"
            phoneCallViewContainer.borderWidth = 1.2
            phoneCallViewContainer.borderColor = .gray
            phoneCallViewContainer.backgroundColor = .white
            hasCallLabel.textColor = .black
            setImage(to: hasPhoneImageView, from: "")
        }
    }
    
    @IBAction func chatBtnAction(_ sender: UIButton) {
        
        if (hasChat == "off"){
            hasChat = "on"
            chatViewContainer.borderWidth = 1.2
            chatViewContainer.borderColor = .white
            chatViewContainer.backgroundColor = UIColor(named: "#0EBFB1")
            setImage(to: hasChatImageView, from: "checkbox")
            hasChatLabel.textColor = .white
        }else{
            hasChat = "off"
            chatViewContainer.borderWidth = 1.2
            chatViewContainer.borderColor = .gray
            chatViewContainer.backgroundColor = .white
            setImage(to: hasChatImageView, from: "")
            hasChatLabel.textColor = .black
        }
    }
    
    @IBAction func whatsBtnAction(_ sender: Any) {
        
        if (hasWhats == "off"){
            hasWhats = "on"
            whatsViewContainer.borderWidth = 1.2
            whatsViewContainer.borderColor = .white
            whatsViewContainer.backgroundColor = UIColor(named: "#0EBFB1")
            setImage(to: hasWhatsImageView, from: "checkbox")
            hasWhatsLabel.textColor = .white
        }else{
            hasWhats = "off"
            whatsViewContainer.borderWidth = 1.2
            whatsViewContainer.borderColor = .gray
            whatsViewContainer.backgroundColor = .white
            setImage(to: hasWhatsImageView, from: "")
            hasWhatsLabel.textColor = .black
        }
    }
    
    @IBAction func useRegisteredBtnAction(_ sender: UIButton) {
        hasNewPhone = false
        addNewPhoneViewContainer.isHidden = true
        addNewPhoneLabel.isHidden = true
        useRegisteredPhoneButton.backgroundColor = UIColor(named: "#0EBFB1")
        useRegisteredPhoneButton.setTitleColor(.white, for: .normal)
        useNewPhoneNumButton.backgroundColor = .white
        useNewPhoneNumButton.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func useNewPhoneNumBtnAction(_ sender: UIButton) {
        hasNewPhone = true
        addNewPhoneViewContainer.isHidden = false
        addNewPhoneLabel.isHidden = false
        useNewPhoneNumButton.backgroundColor = UIColor(named: "#0EBFB1")
        useNewPhoneNumButton.setTitleColor(.white, for: .normal)
        useRegisteredPhoneButton.backgroundColor = .white
        useRegisteredPhoneButton.setTitleColor(.black, for: .normal)
        
    }
    
    @IBAction func addAdBtnAction(_ sender: UIButton) {
        
        AppDelegate.defaults.removeObject(forKey:"postSessionData")
        params = [
            "uid":AppDelegate.currentUser.id ?? 0,
                          "name":advsTitleTF.text!, "price":priceTF.text!,
                          "amount":"0", "lat": "0", "lng":"0",
                          "prod_size":"25","color":"red",
                          "color_name":"red",
                          "cat_id":"\(mainCatID)",
                          "sub_cat_id": "\(subCatID)",
                          "sell_cost":priceTF.text!,"errors":"",
                          "brand_id":"Nike",
                          "material_id":"",
                          "country_id":AppDelegate.currentUser.countryId ?? 0,
                          "city_id":"\(cityId)",
                          "region_id":"\(regionId)",
                          "loc":"\(cityName) \(regionName)",
                          "phone":"\(phone)","wts":phone,"descr":descTextView.text!,
                          "has_chat":hasChat,"has_wts":hasWhats,"has_phone":hasPhone,
                          "tajeer_or_sell":"\(tajeer)"
        ]
        if  selectedImages.count <= 0{
            StaticFunctions.createErrorAlert(msg: "Post at least one photo for the ad.".localize)
        }else if mainImageKey == "" {
            StaticFunctions.createErrorAlert(msg: "Please select the main Image for your ad".localize)
        }else if isTextEmpty(advsTitleTF) {
            StaticFunctions.createErrorAlert(msg: "Enter the title of the ad".localize)
        } else if isTextEmpty(priceTF) {
            StaticFunctions.createErrorAlert(msg: "Enter the sale or rental price of the product".localize)
        } else if isTextEmpty(newPhoneTF) && hasNewPhone {
            StaticFunctions.createErrorAlert(msg: "Put your contact phone number".localize)
        }
        else {
            createAds()
//            AddAdvsController.shared.addAdvs(params: params,selectedMedia: self.selectedMedia) { success, message in
//                if success{
//                    print(message)
//                    let vc = UIStoryboard(name: ADVS_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: SUCCESS_ADDING_VCID) as! SuccessAddingVC
//                    vc.modalPresentationStyle = .fullScreen
//                    vc.present(vc, animated: true)
//                }else{
//                    print("error" , message)
//                    StaticFunctions.createErrorAlert(msg: message)
//
//                }
//            }
        }
        

        
    }
    
    func createAds() {
        var type = ""
        var index = ""
        var image = Data()
    
        //main_image
        
        print(selectedMedia)
        self.AddAdvsButton.startAnimation()
        Loading().startProgress(self)
        AF.upload(multipartFormData: { [self] multipartFormData in
            for (key,value) in selectedMedia {
                if key.contains("IMAGE"){
                    
                    if key == mainImageKey {
                        type = key.components(separatedBy: " ")[0]
                        index = key.components(separatedBy: " ")[1]
                        image = value
                       // params["mtype[]"] = type
                        multipartFormData.append(image, withName: "main_image",fileName: "file\(index).jpg", mimeType: "image/jpg")
                    }else{
                        type = key.components(separatedBy: " ")[0]
                        index = key.components(separatedBy: " ")[1]
                        image = value
                        params["mtype[]"] = type
                        multipartFormData.append(image, withName: "sub_image[]",fileName: "file\(index).jpg", mimeType: "image/jpg")
                    }
                }else{
                    type = key.components(separatedBy: " ")[0]
                    index = key.components(separatedBy: " ")[1]
                    image = value
                    if key == mainImageKey {
                        //MainVideo
                        multipartFormData.append(image, withName: "main_image",fileName: "video\(index).mp4", mimeType: "video/mp4")
                    }else{
                        index = "6"
                        image = value
                        params["mtype[]"] = type
                        multipartFormData.append(image, withName: "sub_image[]",fileName: "video\(index).mp4", mimeType: "video/mp4")
                    }
                 
                }
               
                 print("send Image Parameters : -----> ", params)
            for (key,value) in params {
                multipartFormData.append((value as AnyObject).description.data(using: String.Encoding.utf8)!, withName: key)
            }
        }
        

        },to:Constants.ADDADVS_URL)
        .responseDecodable(of:AddAdvsModel.self){ response in
            Loading().finishProgress(self)
            switch response.result {
            case .success(let data):
                print("success")
                print(data)
                if data.statusCode == 200{
//                    completion(true,data.message ?? "")
                    print(data.message ?? "")
                    let vc = UIStoryboard(name: ADVS_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: SUCCESS_ADDING_VCID) as! SuccessAddingVC
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }else{
//                    completion(false , data.message ?? "")
                    print(data.message)
                    StaticFunctions.createErrorAlert(msg: data.message ?? "")
                }
            case .failure(let error):
                print(error)
                if let decodingError = error.underlyingError as? DecodingError {
                           // Handle decoding errors
//                           completion(false, "Decoding error: \(decodingError)")
                    StaticFunctions.createErrorAlert(msg: "Decoding error: \(decodingError)")
                       } else {
                           // Handle other network or server errors
                           print("error" , SERVER_ERROR)
                           StaticFunctions.createErrorAlert(msg: SERVER_ERROR)
                           
                       }
                   }
            
        }
        
    }
    
    }
    

//MARK: CollectionView Delegate

extension AddAdvsVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvsImagesCollectionViewCell", for: indexPath) as? AdvsImagesCollectionViewCell else {return UICollectionViewCell()}
//        mainImageKey = Array(selectedMedia.keys)[selectedIndexPath.item]
        cell.indexPath = indexPath
        cell.delegate = self
        cell.configureCell(images:  Array(images.values), selectedIndex: selectedIndexPath, mainImageKey: mainImageKey, imagekeyOfIndex: Array(images.keys)[indexPath.row])
//        if mainImageKey == Array(images.keys)[indexPath.row] {
//            cell.isSelected = true
//        }else {
//            cell.isSelected = false
//        }
        print(mainImageKey)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        mainImageKey = Array(images.keys)[indexPath.row]
        
    }
    
}

extension AddAdvsVC {
    
    //MARK: Methods
    private func setupView(){
        
        descTextView.addPlaceholder("Please Enter the full description with the advantages and disadvantages, if any , and the pruchase and sale price.".localize)
        configerSelectedButtons()
    }
    
    private func configerSelectedButtons() {
        addMorePhotoButton.isHidden = true
        moreImageViewContainer.isHidden = true
        addNewPhoneViewContainer.isHidden = true
        addNewPhoneLabel.isHidden = true
        setupSellViewUI()
        setupHasPhoneViewUI()
        rentButtonImageView.isHidden = true
        rentButtonLabel.textColor = .black
        setImage(to: hasWhatsImageView, from: "")
        setImage(to: hasChatImageView, from: "")
        hasChatLabel.textColor = .black
        hasWhatsLabel.textColor = .black
        whatsViewContainer.borderWidth = 1.2
        chatViewContainer.borderWidth =  1.2
        whatsViewContainer.borderColor = .gray
        chatViewContainer.borderColor =  .gray
        
        
    }
    
    private func setupSellViewUI() {
        tajeer = 0
        sellViewContainer.borderWidth = 1.2
        rentViewContainer.borderWidth = 0.7
        sellViewContainer.backgroundColor = UIColor(named: "#0EBFB1")
        rentViewContainer.backgroundColor = .white
        sellViewContainer.borderColor = .white
        rentViewContainer.borderColor = .gray
        setImage(to: sellButtonImageView, from: "radiobtn")
        sellButtonImageView.isHidden = false
        rentButtonImageView.isHidden = true
        sellButtonLabel.textColor = .white
        rentButtonLabel.textColor = .black
        
    }
    private func setupHasPhoneViewUI(){
//        has_phone = "on"
        phoneCallViewContainer.borderWidth = 1.2
        phoneCallViewContainer.backgroundColor = UIColor(named: "#0EBFB1")
        phoneCallViewContainer.borderColor = .white
        hasCallLabel.textColor = .white
        setImage(to: hasPhoneImageView, from: "checkbox")
        
    }
    
    
    private func setupRentViewUI() {
        tajeer = 1
        sellViewContainer.borderWidth = 0.7
        rentViewContainer.borderWidth = 1.2
        rentViewContainer.backgroundColor = UIColor(named: "#0EBFB1")
        sellViewContainer.backgroundColor = .white
        sellViewContainer.borderColor = .gray
        rentViewContainer.borderColor = .white
        sellButtonImageView.isHidden = true
        rentButtonImageView.isHidden = false
        setImage(to: rentButtonImageView, from: "radiobtn")
        sellButtonLabel.textColor = .black
        rentButtonLabel.textColor = .white
    }

   
}

//MARK: Setup Drop Down
extension AddAdvsVC {
    //get Cities
    
 private  func getCitis(){
        CountryController.shared.getCities(completion: {[weak self]  cities, check, error in
            guard let self = self else{return}
            for city in cities {
                if  MOLHLanguage.currentAppleLanguage() == "en" {
                    
                    self.cityList.append(city.nameEn ?? "")
                    self.cityIDsList.append(city.id ?? 0)
                    print(self.cityList)
                }
                else{
                    self.cityList.append(city.nameAr ?? "")
                    self.cityIDsList.append(city.id ?? 0)
                    print(self.cityList)
                }
            }
            if self.cityId == AppDelegate.currentUser.cityId ?? 0 {
//                self.cityId = self.cityIDsList[0]
            }
            self.setupCitiesDropDown()
            self.getRegions(cityId: self.cityId)
        }, countryId: countryId)
        
        
    }
    
  private  func getRegions(cityId:Int){
        print(cityId)
        CountryController.shared.getStates(completion: {[weak self] regions, check, error in
            guard let self = self else{return}
            self.regionsList.removeAll()
            self.regionsIDsList.removeAll()
            for region in regions {
                if  MOLHLanguage.currentAppleLanguage() == "en" {
                    
                    self.regionsList.append(region.nameEn ?? "")
                    self.regionsIDsList.append(region.id ?? 0)
                    print(self.regionsList)
                }
                else{
                    self.regionsList.append(region.nameAr ?? "")
                    self.regionsIDsList.append(region.id ?? 0)
                    print(self.regionsList)
                }
            }
            self.setupRegionsDropDown()
        }, countryId: cityId)
    }
    
    
  private  func getMainCats(){
        CategoryController.shared.getCategoories { [weak self]categories, check, error in
            guard let self = self else {return}
            
            for cat in categories {
                if MOLHLanguage.currentAppleLanguage() == "en"{
                    self.mainCatsList.append(cat.nameEn ?? "")
                    self.mainCatsIDsList.append(cat.id ?? 0)
                    print(self.mainCatsIDsList)
                    print(self.mainCatsList)
                }else{
                    self.mainCatsList.append(cat.nameAr ?? "")
                    self.mainCatsIDsList.append(cat.id ?? 0)
                    print(self.mainCatsIDsList)
                    print(self.mainCatsList)
                }
            }
            if self.mainCatID == -1 {
                self.mainCatID = self.mainCatsIDsList[0]
            }
            
            if self.mainCatID == 1 {
                self.rentViewContainer.isHidden = false
            }else {
                self.rentViewContainer.isHidden = true
            }
           
            self.setupMainCategoryDropDown()
            self.getSubCats(catId: self.mainCatID)
        }
    }
    
    private  func getSubCats(catId:Int){
        CategoryController.shared.getSubCategories(completion: {[weak self] subCategories, check, error in
            guard let self = self else {return}
            self.subCatsList.removeAll()
            self.subCatsIDsList.removeAll()
            for cat in subCategories {
                if MOLHLanguage.currentAppleLanguage() == "en"{
                    self.subCatsList.append(cat.nameEn ?? "")
                    self.subCatsIDsList.append(cat.id ?? 0)
                    print(self.subCatsIDsList)
                }else{
                    self.subCatsList.append(cat.nameAr ?? "")
                    self.subCatsIDsList.append(cat.id ?? 0)
                    print(self.subCatsIDsList)
                }
            }
            self.setupSubCategoryDropDown()
        }, categoryId: catId)
      }
    
    
    // Main Category
    private func setupMainCategoryDropDown() {
        mainCatDropDwon.anchorView = mainCatButton
        //  regionsDropDwon.frame = regionButton.bounds
        if MOLHLanguage.currentAppleLanguage() == "en"{
            mainCatDropDwon.anchorView = mainCatButton
        }else{
            mainCatDropDwon.anchorView = subCatButton
        }
        self.mainCatsList.removeLast()
        mainCatDropDwon.bottomOffset = CGPoint(x: 0, y: mainCatButton.bounds.height)
        mainCatDropDwon.dataSource = mainCatsList
//        mainCatButton.setTitle(mainCatsList[0], for: .normal)
                    if let region = mainCatsIDsList.firstIndex(of: mainCatID) {
                        mainCatButton.setTitle(mainCatsList[region], for: .normal)
                    }else{
                        mainCatButton.setTitle(mainCatsList[0], for: .normal)
                    }
        if self.mainCatID == 1 {
            self.rentViewContainer.isHidden = false
        }else {
            self.rentViewContainer.isHidden = true
        }
        mainCatDropDwon.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else {return}
            self.mainCatID = self.mainCatsIDsList[index]
            self.mainCatName = self.mainCatsList[index]
            print(self.mainCatID)
            
            self.getSubCats(catId:self.mainCatID )
           // self.mainCatButton.setTitle(self.mainCatName, for: .normal)
            
            if let region = self.mainCatsIDsList.firstIndex(of: self.mainCatID) {
                self.mainCatButton.setTitle(self.mainCatsList[region], for: .normal)
            }else {
                self.mainCatButton.setTitle(self.mainCatsList[0], for: .normal)
            }
            if self.mainCatID == 1 {
                self.rentViewContainer.isHidden = false
            }else {
                self.rentViewContainer.isHidden = true
            }
        }
        
        
    }
    
    // Sub Category
    private func setupSubCategoryDropDown() {
//        subCatDropDwon.anchorView = subCatButton
      //  regionsDropDwon.frame = regionButton.bounds
       if MOLHLanguage.currentAppleLanguage() == "en"{
            subCatDropDwon.anchorView = subCatButton
        }else{
            subCatDropDwon.anchorView = mainCatButton
        }
        subCatDropDwon.bottomOffset = CGPoint(x: 0, y: subCatButton.bounds.height)
        subCatDropDwon.dataSource = subCatsList
//        subCatButton.setTitle(subCatsList[0], for: .normal)
            if let subCatId = subCatsIDsList.firstIndex(of: subCatID) {
                subCatButton.setTitle(subCatsList[subCatId], for: .normal)
            }else{
                subCatButton.setTitle(subCatsList[0], for: .normal)
            }
        subCatDropDwon.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else {return}
            self.subCatID = self.subCatsIDsList[index]
            self.subCatName = self.subCatsList[index]
            print(self.subCatID)
            self.subCatButton.setTitle(self.subCatName, for: .normal)
        }
    }
    
    // Citis DropDwon
    private func setupCitiesDropDown() {
//        cityDropDwon.anchorView = cityButton
      //  regionsDropDwon.frame = regionButton.bounds
       if MOLHLanguage.currentAppleLanguage() == "en"{
            cityDropDwon.anchorView = cityButton
        }else{
            cityDropDwon.anchorView = regionButton
        }
        cityDropDwon.bottomOffset = CGPoint(x: 0, y: cityButton.bounds.height)
        cityDropDwon.dataSource = cityList
//        cityButton.setTitle(cityList[0], for: .normal)
        if cityList.count > 0 && cityIDsList.count > 0{
            if let cityID = cityIDsList.firstIndex(of: cityId) {
                cityButton.setTitle(cityList[cityID], for: .normal)
            }else {
                cityButton.setTitle(cityList[0], for: .normal)
            }
        }
            
        cityDropDwon.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else {return}
            self.cityId = self.cityIDsList[index]
            print(self.cityId)
            
            self.getRegions(cityId: self.cityId)
            self.cityName = self.cityList[index]
            print(self.cityId)
            self.cityButton.setTitle(self.cityName, for: .normal)
        }
    }
    
    // regions
    private func setupRegionsDropDown() {
//        regionsDropDwon.anchorView = regionButton
       if MOLHLanguage.currentAppleLanguage() == "en"{
            regionsDropDwon.anchorView = regionButton
        }else{
            regionsDropDwon.anchorView = cityButton
        }
      //  regionsDropDwon.frame = regionButton.bounds
        regionsDropDwon.bottomOffset = CGPoint(x: 0, y: regionButton.bounds.height)
        regionsDropDwon.dataSource = regionsList
//        if regionsIDsList.count > 0 {
//            regionButton.setTitle(regionsList[0], for: .normal)
//        }
        
        print(regionId)
        if regionsList.count > 0 && regionsIDsList.count > 0 {
            if let region = regionsIDsList.firstIndex(of: regionId) {
              regionButton.setTitle(regionsList[region], for: .normal)
          }else {
              regionButton.setTitle(regionsList[0], for: .normal)
          }
        }
           
        regionsDropDwon.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else {return}
            self.regionId = self.regionsIDsList[index]
            
            self.regionName = self.regionsList[index]
            print(self.regionId)
            self.regionButton.setTitle(self.regionName, for: .normal)
        }
    }
    
}
//MARK: AdvsImagesCollectionViewCellDelegate

extension AddAdvsVC:AdvsImagesCollectionViewCellDelegate{
    func didSelectCell(indexPath: IndexPath) {
        selectedIndexPath = indexPath
        mainImageKey = Array(images.keys)[indexPath.item]
        collectionView.reloadData()
    }
    
    func didRemoveCell(indexPath: IndexPath) {
        self.selectedImages.remove(at: indexPath.item)
        if let removedKey = Array(images.keys)[safe: indexPath.item] {
            self.images.removeValue(forKey: removedKey)
            self.selectedMedia.removeValue(forKey: removedKey)
        }
//        if let removedKey = selectedMediaKeys[safe: indexPath.item] {
//            self.selectedMedia.removeValue(forKey: removedKey)
//            self.selectedMediaKeys.remove(at: indexPath.item)
//        }
        collectionView.reloadData()
    }
    
    
}

//MARK: Session Object

extension AddAdvsVC {
    // Function to save session data
    func saveSessionData(images: [String:UIImage],mediaKeys:[String], description: String, title: String,price:String,catId:Int,subCatId:Int,CityId:Int,RegionId:Int,selectedMedia:[String:Data] , selectedMediaKeys:[String]?,mainImageKey:String?) {
        var sessionData: [String: Any] = [:]
        var imagesData: [String: Data] = [:] // Cache to store images as Data
                
                for (key, image) in images {
                    if let imageData = image.jpegData(compressionQuality: 0.01) {
                        imagesData[key] = imageData
                    }
                }
        
        sessionData["images"] = imagesData
        sessionData["mediaKeys"] = mediaKeys
        sessionData["description"] = description
        sessionData["title"] = title
        sessionData["price"] = price
        sessionData["catId"] = catId
        sessionData["subCatId"] = subCatId
        sessionData["CityId"] = CityId
        sessionData["RegionId"] = RegionId
        sessionData["selectedMedia"] = selectedMedia
        sessionData["selectedMediaKeys"] = selectedMediaKeys
        sessionData["mainImageKey"] = mainImageKey

        UserDefaults.standard.set(sessionData, forKey: "postSessionData")
    }

    // Function to retrieve session data
    func retrieveSessionData() -> (images: [String:Data]?, mediaKeys: [String]?, description: String?, title: String?, price: String?, catId: Int?, subCatId: Int?, CityId: Int?, RegionId: Int?,selectedMedia:[String:Data]?, selectedMediaKeys:[String]?,mainImageKey:String?) {
        if let sessionData = UserDefaults.standard.dictionary(forKey: "postSessionData") {
            let images = sessionData["images"] as? [String:Data]
            let mediaKeys = sessionData["mediaKeys"] as? [String]
            let description = sessionData["description"] as? String
            let title = sessionData["title"] as? String
            let price = sessionData["price"] as? String
            let catId = sessionData["catId"] as? Int
            let subCatId = sessionData["subCatId"] as? Int
            let cityId = sessionData["CityId"] as? Int
            let regionId = sessionData["RegionId"] as? Int
            let selectedMedia = sessionData["selectedMedia"] as? [String:Data]
            let selectedMediaKeys = sessionData["selectedMediaKeys"] as? [String]
            let mainImageKey = sessionData["mainImageKey"] as? String
            return (images, mediaKeys, description, title, price, catId, subCatId, cityId, regionId, selectedMedia,selectedMediaKeys,mainImageKey)
        }
        return (nil, nil, nil, nil, nil, nil, nil, nil, nil,nil,nil,nil)
    }


    // Function to clear session data
    func clearSessionData() {
        UserDefaults.standard.removeObject(forKey: "postSessionData")
    }
}

extension AddAdvsVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField  == advsTitleTF {
            let count =  (textField.text?.components(separatedBy: " ").count)! - 1
            if count < 5 {
                textField.allowsEditingTextAttributes
            }else {
                textField.deleteBackward()
                dismissKeyboard()
                StaticFunctions.createErrorAlert(msg:"The ad title should not exceed five words".localize)
                return textField.allowsEditingTextAttributes
            }
            
            return count < 5
        }
        return false
    }
}
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
