//
//  monasba
//
//  Created by iOSAYed on 1/16/21.
//  Copyright © 2023 roll. All rights reserved.
//

import UIKit
import Alamofire

enum ImageDataSource {
    case url(URL)
    case image(UIImage)
}

class EditAdVC:UIViewController, PickupMediaPopupEditAdsVCDelegate  {
    
    @IBOutlet weak private var adsMainImage: UIImageView!
    @IBOutlet weak private var titleLabel: UITextField!
    @IBOutlet weak private var descTextView: UITextView!
    @IBOutlet weak private var oneImageView: UIView!
    @IBOutlet weak private var collectionView: UICollectionView!
    //price
    @IBOutlet weak private var PriceTxetField: UITextField!
    @IBOutlet weak private var sw_price: UISwitch!
    @IBOutlet weak private var pricev: UIView!
    //contact
    @IBOutlet weak private var lbl_put_phone: UILabel!
    @IBOutlet weak private var txt_phone: UITextField!
    @IBOutlet weak private var view_put_phone: UIView!
    @IBOutlet weak private var sw_my_phone: UISwitch!
    //tajeer
    @IBOutlet weak private var tajeerView: UIView!
    @IBOutlet weak private var tajeerButtonImage: UIImageView!
    @IBOutlet weak private var tajeerLabel: UILabel!
    //sell
    @IBOutlet weak private var sellView: UIView!
    @IBOutlet weak private var sellButtonImage: UIImageView!
    @IBOutlet weak private var sellLabel: UILabel!
    //has_phone
    @IBOutlet weak private var has_phonev: UIView!
    @IBOutlet weak private var has_phone_img: UIImageView!
    @IBOutlet weak private var has_phone_txt: UILabel!
    //has_wts
    @IBOutlet weak private var has_wtsv: UIView!
    @IBOutlet weak private var has_wts_img: UIImageView!
    @IBOutlet weak private var has_wts_txt: UILabel!
    //has_chat
    @IBOutlet weak private var has_chatv: UIView!
    @IBOutlet weak private var has_chat_img: UIImageView!
    @IBOutlet weak private var has_chat_txt: UILabel!
    //location
    @IBOutlet weak private var loc_main: UILabel!
    @IBOutlet weak private var loc_sub: UILabel!
   
   private var tajeer = 0
   private var has_phone = "on"
   private var has_wts = "off"
   private var has_chat = "off"
   private var deletedImages = [String]()
   private var catId = ""
   private var cityId = ""
   private var countryId = ""
   private var regionId = ""
   private var subCatId = ""
   private var editedMainImage = false
    
    var selectedImages = [UIImage]()
    var selectedVideos = [Data]()
    var selectedMedia = [String:Data]()
    var productId = 0
    var product = Product()
//    var images = [String]()
    var dataSource: [ImageDataSource] = []
    var isMainImage = false
    var isEditImages = false
    var mainImage:Data?
    var productsImages = [ProductImage]()
    var imagesDeleted = [Int]()
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    //MARK: Private Methods
    
    private func configureUI(){
        has_chatv.borderWidth = 0.7
        has_wtsv.borderWidth = 0.7
        tajeerView.borderWidth = 0.7
        configerSelectedButtons()
    }
    
    
    
    func PickupMediaPopupEditVC(_ controller: PickupMediaPopupEditAdsVC, didSelectImages image: UIImage, videos: [Data], selectedMedia: [String : Data]) {
        if isMainImage {
            adsMainImage.image = image
            mainImage = image.jpegData(compressionQuality: 0.1)!
            editedMainImage = true
//            guard  mainImage == image.jpegData(compressionQuality: 0.1) else {return}
        }else{
            isEditImages = true
            self.dataSource.append(.image(image))
        }
        
//        self.selectedImages = images
        self.selectedVideos = videos
        self.selectedMedia = selectedMedia
//        print("Images Count ", images.count)
        print(selectedVideos)
        print("Videos Count " , selectedVideos.count)
        print("selectedMedia ------->",selectedMedia)
        self.collectionView.reloadData()
    }
    
    //MARK: IBActions
    
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapEditMainImageButton(_ sender: UIButton) {
        isMainImage = true
        
        let vc = UIStoryboard(name: ADVS_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier:  PICKUP_MEDIA_POPUP_EDIT_VCID) as! PickupMediaPopupEditAdsVC
        vc.delegate = self
        vc.image = adsMainImage.image ?? UIImage()
//            vc.images = selectedImages
        //vc.videos = selectedVideos
       // vc.selectedMedia = selectedMedia
        present(vc, animated: false)
    }
    
    @IBAction func didTapShowPickedImageViewButton(_ sender: UIButton) {
        isMainImage = false
        if selectedImages.count < 6 {
            let vc = UIStoryboard(name: ADVS_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier:  PICKUP_MEDIA_POPUP_EDIT_VCID) as! PickupMediaPopupEditAdsVC
            vc.delegate = self
//            vc.images = selectedImages
            vc.videos = selectedVideos
            vc.selectedMedia = selectedMedia
            present(vc, animated: false)
        }else{
            StaticFunctions.createErrorAlert(msg: "You have reached the limit of videos and photos".localize)
        }
    }
    
    @IBAction func didTapTajeerButton(_ sender: UIButton) {
        setupTajeerViewUI()
    }
    
    @IBAction func didTapSellButton(_ sender: UIButton) {
        setupSellViewUI()
    }
    
    @IBAction func didTapChatButton(_ sender: UIButton) {
        if (has_chat == "off"){
            has_chat = "on"
            has_chatv.borderWidth = 1.2
            has_chatv.borderColor = .white
            has_chatv.backgroundColor = UIColor(named: "#0EBFB1")
            StaticFunctions.setTextColor(has_chat_txt, UIColor.white)
            StaticFunctions.setImageFromAssets(has_chat_img, "checkbox")
        }else{
            has_chat = "off"
            has_chatv.borderWidth = 1.2
            has_chatv.borderColor = .gray
            has_chatv.backgroundColor = .white
            StaticFunctions.setTextColor(has_chat_txt, UIColor.black)
            StaticFunctions.setImageFromAssets(has_chat_img, "")
        }
    }
    
    @IBAction func didTapWhatsButton(_ sender: UIButton) {
        if (has_wts == "off"){
            setupWhatsOff()
        }else{
            setupWhatsOn()
        }
    }
    
    
    @IBAction func didTapCallButton(_ sender: UIButton) {
        if (has_phone == "off"){
            setupHasPhoneViewUI()
        }else{
            setupNotHasPhoneViewUI()
        }
    }
    
    @IBAction func didTapSwitchPhoneButton(_ sender: Any) {
        if sw_my_phone.isOn{
            lbl_put_phone.isHidden = true
            view_put_phone.isHidden = true
        }else{
            lbl_put_phone.isHidden = false
            view_put_phone.isHidden = false
        }
    }
    
    @IBAction func didTapSaveButton(_ sender: UIButton) {
        
//        var phone = AppDelegate.currentUser.phone ?? ""
        guard var phone = AppDelegate.currentUser.phone else {return}
        if(!sw_my_phone.isOn){
            phone = txt_phone.text!
        }
        let errors = "لايوجد"
        guard let price = PriceTxetField.text else {return}
        guard let url = URL(string: Constants.DOMAIN+"prods_update")else{return}
        var params : [String: Any]  = ["id":product.id ?? 0,
                                       "name":titleLabel.text ?? "", "price":price,
                                       "uid":AppDelegate.currentUser.id ?? 0,"cat_id":catId,"sub_cat_id":subCatId,
                                       "country_id":countryId,"city_id":cityId,"region_id":regionId,
                                       "amount":0,
                                      "errors":errors,
                                       "brand_id":"NIKE",
                                       "material_id":"Hareer",
                                       "phone":phone,"wts":phone,"descr":descTextView.text!,
                                       "has_chat":has_chat,"has_wts":has_wts,"has_phone":has_phone,
                                       "tajeer_or_sell":tajeer]
        print(params)
        var type = ""
        var index = ""
        var indexDeletedImage = 0
        var image = Data()
        
        if isEditImages || editedMainImage {
           
            AF.upload(multipartFormData: { [weak self] multipartFormData in
                guard let self = self else {return}
                print(self.editedMainImage)
                print(self.selectedMedia.count , self.isEditImages)
                if self.editedMainImage {
                    guard let mainImage = self.mainImage else {return}
                multipartFormData.append(mainImage, withName: "main_image",fileName: "file.jpg", mimeType: "image/jpg")
                }
                print(self.selectedMedia.count , self.isEditImages)
                
                if self.selectedMedia.count > 0 || self.isEditImages{
                    for (value,key) in self.selectedMedia {
                        
                        if value.contains("IMAGE"){
                            type = value.components(separatedBy: " ")[0]
                            index = value.components(separatedBy: " ")[1]
//                            type = value
                            image = key
                            print( "VALUE  ",value ,"KEY  " ,key)
                            params["mtype[]"] = type
                            multipartFormData.append(image, withName: "sub_image[]",fileName: "file\(index).jpg", mimeType: "image/jpg")
                        }else{
                             index = "6"
                            type = value
                            image = key
                            params["mtype[]"] = type
                            multipartFormData.append(image, withName: "sub_image[]",fileName: "video\(index).mp4", mimeType: "video/mp4")
                        }
                    }
                }
                    
                    if self.imagesDeleted.count > 0 {
                        for img in self.imagesDeleted {
                            indexDeletedImage += 1
//                          , "delete_img_ids[]":"6235"
                            params["delete_img_ids[\(indexDeletedImage)]"] = img

                        }
                    }
                   
                    
                for (key,value) in params {
                    multipartFormData.append((value as AnyObject).description.data(using: String.Encoding.utf8)!, withName: key)
                }
           
                print("send Image Parameters : -----> ", params)
                 
            },to:"\(url)")
            .responseDecodable(of:EditAdvSuccessModel.self){ response in
                print(response)
                switch response.result {
                case .success(let data):
                    if let message = data.message , let success = data.success{
                        if success {
                        print(message)
                            StaticFunctions.createSuccessAlert(msg:message)
                            self.navigationController?.popViewController(animated: true)
                        }else{
                            StaticFunctions.createErrorAlert(msg: message)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }else{
            
            if imagesDeleted.count > 0 {
                for img in imagesDeleted {
                    indexDeletedImage += 1
                    //                          , "delete_img_ids[]":"6235"
                    params["delete_img_ids[\(indexDeletedImage)]"] = img
                    
                }
            }
            print(params)
            AF.request(url, method: .post, parameters: params, encoding:URLEncoding.httpBody).responseDecodable(of:EditAdvSuccessModel.self){ response in
                print(response)
                switch response.result {
                case .success(let data):
                    if let message = data.message , let success = data.success{
                        if success {
                            print(message)
                            StaticFunctions.createSuccessAlert(msg:message)
                            self.navigationController?.popViewController(animated: true)
                        }else{
                            StaticFunctions.createErrorAlert(msg:message)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
            
        }
        
    }
    
    @IBAction func didTapDeleteButton(_ sender: UIButton) {
        let params : [String: Any]  = ["id":product.id ?? 0]
        guard let url = URL(string: Constants.DOMAIN+"prods_delete")else{return}
        AF.request(url, method: .post, parameters: params, encoding:URLEncoding.httpBody).responseDecodable(of:SuccessModel.self){res in
            switch res.result{
            case .success(let data):
                if let success = data.success {
                    if success {
                        StaticFunctions.createSuccessAlert(msg:"Ads Deleted Seccessfully".localize)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
//MARK: fileprivate Methods
extension EditAdVC{
    
    fileprivate  func getData(){
        ProductController.shared.getProducts(completion: {
            product, check, msg in
            
            if check == 0{
                self.product = product.data
                self.productsImages = product.images
                print(product.images)
                for i in product.images{
//                    self.images.append(i.image ?? "")
                    guard let imageURL = URL(string: i.image ?? "" ) else { return }
                    if i.image?.contains(".mp4") == true {
                        self.dataSource.append(.image(self.generateThumbnailImage(url: imageURL)))
                        
                    }else{
                        self.dataSource.append(.url(imageURL))
                    }
                    
                }
                print(self.dataSource)
                self.setData()
                
            }else{
                StaticFunctions.createErrorAlert(msg: msg)
                self.navigationController?.popViewController(animated: true)
            }
            
        }, id: productId)
    }
    
    fileprivate func setData(){
        self.titleLabel.text = product.name
        
        self.descTextView.text = product.description
        if let price = product.price {
            self.PriceTxetField.text = "\(price)"
        }
        if let tajeer = product.type {
            self.tajeer = tajeer
        }
        
        if let countryId = product.countryId {
            self.countryId = "\(countryId)"
        }
        if let cityId = product.cityId {
            self.cityId = "\(cityId)"
        }
        if let regionId = product.regionId {
            self.regionId = "\(regionId)"
        }
//        if let catId = data.prod?.catID {
//            self.catId = "\(catId)"
//        }
//        if let subCatId = data.prod?.subCatID {
//            self.subCatId = "\(subCatId)"
//        }
            //contact
        self.has_phone = product.hasPhone == "on" ? "off":"on"
        self.has_wts = product.hasWhatsapp == "on" ? "off":"on"
        self.has_chat = product.hasChat == "on" ? "off":"on"
        
        if product.hasWhatsapp == "on" {
            setupWhatsOn()
        }
        if product.hasPhone == "on" {
            setupHasPhoneViewUI()
        }
        
        self.txt_phone.text = product.phone
        
        if product.type == 1 {
            setupTajeerViewUI()
        }else{
            setupSellViewUI()
        }
        
        //Main Image
        if let mainImage = product.mainImage {
            adsMainImage.setImageWithLoading(url: mainImage)
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func configerSelectedButtons() {
        descTextView.textAlignment = .center
        setupSellViewUI()
        setupHasPhoneViewUI()
        tajeerButtonImage.isHidden = true
        tajeerLabel.textColor = .black
        StaticFunctions.setImageFromAssets(has_wts_img, "")
        StaticFunctions.setImageFromAssets(has_chat_img, "")
        has_chat_txt.textColor = .black
        has_wts_txt.textColor = .black
        has_wtsv.borderWidth = 1.2
        has_chatv.borderWidth =  1.2
        has_wtsv.borderColor = .gray
        has_chatv.borderColor =  .gray
        view_put_phone.isHidden = true
        lbl_put_phone.isHidden = true
    }
    fileprivate func setupTajeerViewUI() {
        tajeer = 1
        sellView.borderWidth = 0.7
        tajeerView.borderWidth = 1.2
        sellButtonImage.borderWidth = 0.7
        sellButtonImage.borderColor = .white
        tajeerView.backgroundColor = UIColor(named: "#0EBFB1")
        sellView.backgroundColor = .white
    sellView.borderColor = .gray
        tajeerView.borderColor = .white
        sellButtonImage.isHidden = true
        tajeerButtonImage.isHidden = false
    StaticFunctions.setImageFromAssets(tajeerButtonImage, "radiobtn")
    StaticFunctions.setTextColor(sellLabel, UIColor.black)
    StaticFunctions.setTextColor(tajeerLabel, UIColor.white)
        
    }
    
    fileprivate func setupSellViewUI() {
        tajeer = 0
        sellView.borderWidth = 1.2
        tajeerView.borderWidth = 0.7
        tajeerButtonImage.borderWidth = 0.7
        tajeerButtonImage.borderColor = .white
        sellView.backgroundColor = UIColor(named: "#0EBFB1")
        tajeerView.backgroundColor = .white
        sellView.borderColor = .white
        tajeerView.borderColor = .gray
        StaticFunctions.setImageFromAssets(sellButtonImage, "radiobtn")
        sellButtonImage.isHidden = false
        tajeerButtonImage.isHidden = true
        StaticFunctions.setTextColor(sellLabel, UIColor.white)
        StaticFunctions.setTextColor(tajeerLabel, UIColor.black)
    }
    
    fileprivate func setupHasPhoneViewUI(){
        has_phone = "on"
        has_phonev.borderWidth = 1.2
        has_phonev.backgroundColor = UIColor(named: "#0EBFB1")
        has_phonev.borderColor = .white
        StaticFunctions.setTextColor(has_phone_txt,UIColor.white)
        StaticFunctions.setImageFromAssets(has_phone_img, "checkbox")
    }
    fileprivate func setupNotHasPhoneViewUI() {
        has_phone = "off"
        has_phonev.borderWidth = 1.2
        has_phonev.borderColor = .gray
        has_phonev.backgroundColor = .white
        StaticFunctions.setTextColor(has_phone_txt, UIColor.black)
        StaticFunctions.setImageFromAssets(has_phone_img, "")
    }
    fileprivate func setupWhatsOff() {
        has_wts = "on"
        has_wtsv.borderWidth = 1.2
        has_wtsv.borderColor = .white
        has_wtsv.backgroundColor = UIColor(named: "#0EBFB1")
        StaticFunctions.setTextColor(has_wts_txt, UIColor.white)
        StaticFunctions.setImageFromAssets(has_wts_img, "checkbox")
    }
    
    fileprivate func setupWhatsOn() {
        has_wts = "off"
        has_wtsv.borderWidth = 1.2
        has_wtsv.borderColor = .gray
        has_wtsv.backgroundColor = .white
        StaticFunctions.setTextColor(has_wts_txt, UIColor.black)
        StaticFunctions.setImageFromAssets(has_wts_img, "")
    }
}
extension EditAdVC : UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvsImagesCollectionViewCell", for: indexPath) as? AdvsImagesCollectionViewCell else {return UICollectionViewCell()}
//        if let url = URL(string:  self.dataSource[indexPath.item]) {
//            cell.imageView.sd_setImage(with:url , placeholderImage: nil)
//        }
        let data = dataSource[indexPath.item]
            
            switch data {
            case .url(let url):
                // Load image from URL and set it in the cell
                cell.imageView.sd_setImage(with:url , placeholderImage: nil)
            case .image(let image):
                // Set the gallery image in the cell
                cell.imageView.image = image
            }
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    
}

extension EditAdVC: AdvsImagesCollectionViewCellDelegate {
    func didRemoveCell(indexPath: IndexPath) {        self.imagesDeleted.append(self.productsImages[indexPath.item].id ?? 0)
        productsImages.remove(at: indexPath.item)
        self.dataSource.remove(at: indexPath.item)
        print(imagesDeleted)
        self.collectionView.reloadData()
    }
    
    
}
