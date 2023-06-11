//
//  VerifyAccountVC.swift
//  Monasba
//
//  Created by iOSayed on 10/06/2023.
//

    import UIKit
    import Alamofire
    import DropDown
//    import NextGrowingTextView

class VerifyAccountVC: UIViewController, UITextFieldDelegate {
        
        @IBOutlet weak var pic: UIImageView!
        var tajeer = 0
        
        //tajeer
        @IBOutlet weak var tajeerv: UIView!
        @IBOutlet weak var tajeer_img: UIImageView!
        @IBOutlet weak var tajeer_txt: UILabel!
        
        //sell
        @IBOutlet weak var sellv: UIView!
        @IBOutlet weak var sell_img: UIImageView!
        @IBOutlet weak var sell_txt: UILabel!
        

        @IBOutlet weak var oneImageView: UIView!
        
        @IBOutlet weak var moreThanOneView: UIView!
        @IBOutlet weak var phoneNumber: UITextField!
        
        @IBOutlet weak var countryImage: UIImageView!
        @IBOutlet weak var phoneCode: UILabel!
        
        
        let textField = UITextField()
        lazy var dropDowns: [DropDown] = {
            return [
                self.countries,
                self.cats,
                self.documents
            ]
        }()
        
        var countPhoneNumber: Int {
            if AppDelegate.currentUser.countryId == 5 || AppDelegate.currentUser.countryId  == 10 {
                    return 9
                }else{
                    return  8
                }
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tajeerv.borderWidth = 0.7
            StaticFunctions.setImageFromAssets(sell_img, "radioImage")
            sellv.backgroundColor = UIColor(named: "#0EBFB1")
            StaticFunctions.setTextColor(sell_txt, UIColor.white)
            phoneNumber.delegate = self
            phoneCode.text = "\(AppDelegate.currentUser.phone?.prefix(3))"
            countriesBtn.setTitle(AppDelegate.currentUser.countriesNameEn, for: .normal)
            
            dropDowns.forEach { $0.dismissMode = .onTap }
            dropDowns.forEach { $0.direction = .any }
            customizeDropDown()
            setupDropDownCats()
//            getCountries()
            documents_name = ["بطاقة الهوية",
                                  "جواز سفر",
                                  "رخصة قيادة"]
            
            setupDropDownDocuments()
            
        }
        
        
        //===================================     cats   ===================================
        @IBOutlet weak var catsBtn: UIButton!
        
        var cat_name:String = ""
        var cats_name = [  "اختار الفئة",
                                "رياضة",
                                "موسيقى وغناء",
                                "ترفيه",
                                "تمثيل",
                                "موضة وأزياء",
                                "منشئ محتوى/مدوّن/شخصية مؤثرة",
                                "كاتب/مؤلف",
                                "حكومة وسياسة",
                                "نشاط تجاري/علامة تجارية"]
        
        let cats = DropDown()
        
        func setupDropDownCats() {
            cats.anchorView = catsBtn
            cats.textColor = .black
            cats.bottomOffset = CGPoint(x: 0, y: catsBtn.bounds.height)
            cats.dataSource = cats_name
            catsBtn.setTitle(cats_name[0], for: .normal)
            self.cat_name = self.cats_name[0]
            cats.selectionAction = { [unowned self] (index: Int, item: String) in
                self.cat_name = self.cats_name[index]
                self.catsBtn.setTitle(self.cat_name, for: .normal)
            }
        }
//        func open_country_dialog() {
//            let countrisC = countriesC(nibName: "countriesC", bundle: nil)
//            countrisC.delegate5 = self
//            presentDialogViewController(countrisC, animationPattern: .zoomInOut)
//        }
        
//        func closeDialog(){
//            dismissDialogViewController(.fadeInOut)
//        }
        
        
        @IBAction func selectCountry(_ sender: UIButton) {
          //  open_country_dialog()
        }
        
        
        @IBAction func show_cats(_ sender: Any) {
            cats.show()
        }
        //===================================    END cats   ===================================
        
        
        //===================================     documents   ===================================
        @IBOutlet weak var documentsBtn: UIButton!
        
        var document_name:String = ""
        var documents_name = [String]()
      
        let documents = DropDown()
        
        func setupDropDownDocuments() {
            documents.anchorView = documentsBtn
            documents.textColor = .black
            documents.bottomOffset = CGPoint(x: 0, y: documentsBtn.bounds.height)
            documents.dataSource = documents_name
            documentsBtn.setTitle(documents_name[0], for: .normal)
            self.document_name = self.documents_name[0]
            documents.selectionAction = { [unowned self] (index: Int, item: String) in
                self.document_name = self.documents_name[index]
                self.documentsBtn.setTitle(self.document_name, for: .normal)
            }
        }
        
        @IBAction func show_documents(_ sender: Any) {
            documents.show()
        }
        //===================================    END documents   ===================================
        
        
      
        
//        func getCountries(){
//            guard let url = URL(string: user.newBaseUrl+"countries")else {return}
//            AF.request(url, method: .post)
//                .responseJSON { [weak self] (e) in
//                    guard let self = self else {return}
//                    BG.hide(self)
//                    if let result = e.value {
//                        if let dataDic = result as? NSDictionary {
//                            if let arr = dataDic["data"] as? NSArray {
//                                for itm in arr {
//                                    if let d = itm as? NSDictionary {
//                                        if let name = d.value(forKey: "name_ar") as? String {
//                                            self.countries_name.append(name)
//                                        }
//                                        if let id = d.value(forKey: "id") as? Int {
//                                            self.countries_id.append("\(id)")
//                                        }
//
//                                    }
//                                }
//                                print(self.countries_name)
//                            }
//
//                         //   self.setupCountriesDropDown()
//                        }
//
//                    }
//                }
//        }
        
        //===================================     countries   ===================================
        @IBOutlet weak var countriesBtn: UIButton!
        
        var country_id:String = ""
        var country_name:String = ""
        var countries_name = [String]()
        var countries_id = [String]()
            
        let countries = DropDown()
        
        func setupCountriesDropDown() {
            countries.anchorView = countriesBtn
            countries.textColor = .black
            countries.bottomOffset = CGPoint(x: 0, y: countriesBtn.bounds.height)
            countries.dataSource = countries_name
            countriesBtn.setTitle(countries_name[countries_id.firstIndex(of: "\(AppDelegate.currentUser.countryId ?? 0)")!], for: .normal)
            countries.selectionAction = { [unowned self] (index: Int, item: String) in
                self.country_id = self.countries_id[index]
                self.country_name = self.countries_name[index]
                print(self.country_id)
                self.countriesBtn.setTitle(self.country_name, for: .normal)
            }
        }
        
        @IBAction func show_countries(_ sender: Any) {
            countries.show()
        }
        //=================================    END countries   ===============================
        
        
        @IBAction func go() {
            //order.askImage
//                BG.load(self)
            guard let mobile = phoneNumber.text else{return}
            let params : [String: Any]  = ["uid":AppDelegate.currentUser.id,
                                              "note":" ",
                                               "account_type":tajeer,
                                               "category":cat_name,
                                               "document_type":document_name,
                                           "country_id":AppDelegate.currentUser.countryId, "mobile":mobile]
            if cat_name == "" && country_name == "" && document_name == "" {
                StaticFunctions.createErrorAlert(msg:"من فضلك ادخل جميع البيانات")
            }else {
                guard let url = URL(string: Constants.DOMAIN+"users_pending")else{return}
                print(params)
                AF.upload(multipartFormData: {multipartFormData in
                    
                    multipartFormData.append(Data(), withName: "image",fileName: "file.jpg", mimeType: "image/jpg")
                    print("send Image Parameters : -----> ", params)
                    for (key,value) in params {
                        multipartFormData.append((value as AnyObject).description.data(using: String.Encoding.utf8)!, withName: key)
                    }
                    
                    
                },to:"\(url)")
                .responseDecodable(of:SuccessfulVerifyModel.self){ response in
                    print(response)
//                    BG.hide(self)
                    switch response.result {
                    case .success(let data):
                        print(data)
                        if let success = data.success{
                            if success {
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                    self.goNav("SettingVC","Main")
                                    self.dismissDetail()
                                }
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            
    //            AF.request(user.url, method: .post, parameters: params, encoding:URLEncoding.httpBody , headers: temp.header)
    //                .responseString { (e) in
    //                    BG.hide(self)
    //                    if let res = e.value {
    //                        print(res)
    //                        if(res.contains("true")){
    //                            self.showMiracle()
    //                            self.dimissMe()
    //                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    //                                self.goNav("SettingVC","Main")
    //                            }
    //
    //                        }else{
    //                            self.msg("بيانات خطأ")
    //                        }
    //                    }
    //                }
            }
        }
        
    
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        dismissDetail()
    }
    
        @IBAction func go_pick_img() {
//            img = pic
            
        }
        
        
        @IBAction func rd_sell_tajeer(_ sender:UIButton) {
            tajeer = sender.tag
            if(sender.tag == 1){
    //            sellv.backgroundColor = colors.main
    //            tajeerv.backgroundColor = colors.whiteColor
                sellv.borderWidth = 0.7
                tajeerv.borderWidth = 1.2
                sellv.borderColor = UIColor.gray
                tajeerv.borderColor =  UIColor(named: "#0EBFB1")
                StaticFunctions.setImageFromAssets(sell_img, "radio_grey")
                StaticFunctions.setImageFromAssets(tajeer_img, "radioImage")
                StaticFunctions.setTextColor(sell_txt, UIColor.gray)
                StaticFunctions.setTextColor(tajeer_txt, UIColor.white)
                sellv.backgroundColor = UIColor.white
                tajeerv.backgroundColor = UIColor(named: "#0EBFB1")
                
                documents_name = [  "عقد تأسيس",
                                    "سجل تجاري",
                                    "الرخصة التجارية",
                                    ]
                
                
            }else{
    //            sellv.backgroundColor = colors.whiteColor
    //            tajeerv.backgroundColor = colors.main
                
                sellv.borderWidth = 1.2
                tajeerv.borderWidth = 0.7
                sellv.borderColor = UIColor(named: "#0EBFB1")
                tajeerv.borderColor = UIColor.gray
                StaticFunctions.setImageFromAssets(sell_img, "radioImage")
                StaticFunctions.setImageFromAssets(tajeer_img, "radio_grey")
                StaticFunctions.setTextColor(sell_txt, UIColor.white)
                StaticFunctions.setTextColor(tajeer_txt, UIColor.gray)
                sellv.backgroundColor = UIColor(named: "#0EBFB1")
                tajeerv.backgroundColor = UIColor.white
                documents_name = ["بطاقة الهوية",
                                      "جواز سفر",
                                      "رخصة قيادة"]
                
            }
            setupDropDownDocuments()
        }
//        @objc func showMiracle() {
//            let slideVC = OverlayView()
//            slideVC.imageName = "DoneImage"
//                slideVC.isForgetPassword = true
//                slideVC.onDoneBlock = { result in
//                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
//                       self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
//                }
//            slideVC.text = "جاري مراجعه حسابك من قبل الادارة"
//            slideVC.modalPresentationStyle = .custom
//            slideVC.transitioningDelegate = self
//            self.present(slideVC, animated: true, completion: nil)
//        }
    }
  
    extension VerifyAccountVC  {
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == phoneNumber{
                let maxLength = countPhoneNumber
                   let currentString = (textField.text ?? "") as NSString
                   let newString = currentString.replacingCharacters(in: range, with: string)

                   return newString.count <= maxLength
            }
            return true
        }
    }

extension VerifyAccountVC {
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
}
