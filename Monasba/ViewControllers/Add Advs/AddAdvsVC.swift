//
//  AddAdvsVC.swift
//  Monasba
//
//  Created by iOSayed on 01/05/2023.
//

import UIKit
import DropDown
import MOLH


class AddAdvsVC: UIViewController {

    
    
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
    
    
    
    
    //MARK: Poropreties
    
    var hasPhone = "on"
    var hasWhats = "off"
    var hasChat = "off"
    
    var countryId = 5
    
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
    var cityId:Int = -1
    var cityName:String = ""
    var cityList = [String]()
    var cityIDsList = [Int]()
    
    let cityDropDwon = DropDown()
    
    // regions DropDwon
    var regionId:Int = -1
    var regionName:String = ""
    var regionsList = [String]()
    var regionsIDsList = [Int]()
    
    let regionsDropDwon = DropDown()
    //MARK: App LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        customizeDropDown()
        getCitis()
        getMainCats()
        //setupCitiesDropDown()
        
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
//    func setupRegion(){
//        for i in  Constants.STATUS {
//            if  MOLHLanguage.currentAppleLanguage() == "en" {
//
//                regionsList.append(i.nameEn ?? "")
//                regionsIDsList.append("\(String(describing: i.id))")
//            }
//            else{
//                regionsList.append(i.nameAr ?? "")
//                regionsIDsList.append("\(String(describing: i.id))")
//            }
//        }
//    }
    
    //MARK: IBActions
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func addPhotoBtnAction(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: ADVS_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier:  PICKUP_MEDIA_POPUP_VCID) as! PickupMediaPopupVC
        present(vc, animated: false)
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
        
        addNewPhoneViewContainer.isHidden = true
        addNewPhoneLabel.isHidden = true
        useRegisteredPhoneButton.backgroundColor = UIColor(named: "#0EBFB1")
        useRegisteredPhoneButton.setTitleColor(.white, for: .normal)
        useNewPhoneNumButton.backgroundColor = .white
        useNewPhoneNumButton.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func useNewPhoneNumBtnAction(_ sender: UIButton) {
        addNewPhoneViewContainer.isHidden = false
        addNewPhoneLabel.isHidden = false
        useNewPhoneNumButton.backgroundColor = UIColor(named: "#0EBFB1")
        useNewPhoneNumButton.setTitleColor(.white, for: .normal)
        useRegisteredPhoneButton.backgroundColor = .white
        useRegisteredPhoneButton.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func addAdBtnAction(_ sender: UIButton) {
        
    }
    
}
extension AddAdvsVC {
    
    //MARK: Methods
    private func setupView(){
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
    private  func customizeDropDown() {
        let appearance = DropDown.appearance()
        appearance.cellHeight = 37
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        appearance.separatorColor = UIColor(white: 1, alpha: 0.8)
        //appearance.cornerRadius = 4
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
//        appearance.shadowOpacity = 0.9
//        appearance.shadowRadius = 8
        appearance.animationduration = 0.25
        appearance.textColor = .black
        //appearance.textFont =  UIFont(name: "Tajawal-Regular", size: 14)!
        appearance.textFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    //get Cities
    
 private   func getCitis(){
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
            self.setupCitiesDropDown()
            self.getRegions(cityId: self.cityIDsList[0])
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
                }else{
                    self.mainCatsList.append(cat.nameAr ?? "")
                    self.mainCatsIDsList.append(cat.id ?? 0)
                    print(self.mainCatsIDsList)
                }
            }
           
            self.setupMainCategoryDropDown()
            self.getSubCats(catId: self.mainCatsIDsList[0])
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
        mainCatDropDwon.bottomOffset = CGPoint(x: 0, y: mainCatButton.bounds.height)
        mainCatDropDwon.dataSource = mainCatsList
        mainCatButton.setTitle(mainCatsList[0], for: .normal)
        //            if let region = mainCatsIDsList.firstIndex(of: mainCatID) {
        //                mainCatButton.setTitle(mainCatsList[region], for: .normal)
        //            }
        if self.mainCatID != 1 {
            self.rentViewContainer.isHidden = true
        }else {
            self.rentViewContainer.isHidden = false
        }
        mainCatDropDwon.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else {return}
            self.mainCatID = self.mainCatsIDsList[index]
            self.mainCatName = self.mainCatsList[index]
            print(self.mainCatID)
            
            self.getSubCats(catId:self.mainCatID )
            self.mainCatButton.setTitle(self.mainCatName, for: .normal)
            if self.mainCatID != 1 {
                self.rentViewContainer.isHidden = true
            }else {
                self.rentViewContainer.isHidden = false
            }
        }
        
        
    }
    
    // Sub Category
    private func setupSubCategoryDropDown() {
        subCatDropDwon.anchorView = subCatButton
      //  regionsDropDwon.frame = regionButton.bounds
        subCatDropDwon.bottomOffset = CGPoint(x: 0, y: subCatButton.bounds.height)
        subCatDropDwon.dataSource = subCatsList
        subCatButton.setTitle(subCatsList[0], for: .normal)
//            if let region = subCatsIDsList.firstIndex(of: subCatID) {
//                subCatButton.setTitle(subCatsList[region], for: .normal)
//            }
        subCatDropDwon.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else {return}
            self.mainCatID = self.subCatsIDsList[index]
            self.subCatName = self.subCatsList[index]
            print(self.subCatID)
            self.subCatButton.setTitle(self.subCatName, for: .normal)
        }
    }
    
    // Citis DropDwon
    private func setupCitiesDropDown() {
        cityDropDwon.anchorView = cityButton
      //  regionsDropDwon.frame = regionButton.bounds
        cityDropDwon.bottomOffset = CGPoint(x: 0, y: cityButton.bounds.height)
        cityDropDwon.dataSource = cityList
        cityButton.setTitle(cityList[0], for: .normal)
//            if let region = cityIDsList.firstIndex(of: cityId) {
//                cityButton.setTitle(cityList[region], for: .normal)
//            }
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
        regionsDropDwon.anchorView = regionButton
      //  regionsDropDwon.frame = regionButton.bounds
        regionsDropDwon.bottomOffset = CGPoint(x: 0, y: regionButton.bounds.height)
        regionsDropDwon.dataSource = regionsList
        if regionsIDsList.count > 0 {
            regionButton.setTitle(regionsList[0], for: .normal)
        }
        
        
//            if let region = regionsIDsList.firstIndex(of: regionId) {
//                regionButton.setTitle(regionsList[region], for: .normal)
//            }
        regionsDropDwon.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else {return}
            self.regionId = self.regionsIDsList[index]
            
            self.regionName = self.regionsList[index]
            print(self.regionId)
            self.regionButton.setTitle(self.regionName, for: .normal)
        }
    }
    
}