//
//  EditAdVC.swift
//  Monasba
//
//  Created by iOSayed on 24/05/2023.
//

import UIKit

class EditAdVC: UIViewController {
    @IBOutlet weak var loadMoreImageButton: UIButton!
    
    @IBOutlet weak var overlayView: UIView!
    
    @IBOutlet weak var adsMainImage: UIImageView!
    @IBOutlet weak var oldLoadMoreImage: UIView!
    @IBOutlet weak var hdr: UIView!
    @IBOutlet weak var lbl_name: UITextField!
    @IBOutlet weak var udescr: NextGrowingTextView!
    @IBOutlet weak var oneImageView: UIView!
    
    @IBOutlet weak var moreImageView: UIView!
    
    @IBOutlet weak var popUpBottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var lst: UICollectionView!
    
    //material
    @IBOutlet weak var txt_material: UITextField!
    
    //brand
    @IBOutlet weak var txt_brand: UITextField!
    
    //price
    @IBOutlet weak var txt_sell_price: UITextField!
    @IBOutlet weak var txt_price: UITextField!
    @IBOutlet weak var sw_price: UISwitch!
    @IBOutlet weak var pricev: UIView!
    
    //contact
    @IBOutlet weak var lbl_put_phone: UILabel!
    @IBOutlet weak var txt_phone: UITextField!
    @IBOutlet weak var view_put_phone: UIView!
    @IBOutlet weak var sw_my_phone: UISwitch!
//    var images = [Image1]()
    var tajeer = 0;
    var has_phone = "on"
    var has_wts = "off"
    var has_chat = "off"
    var deletedImages = [String]()
    var catId = ""
    var cityId = ""
    var countryId = ""
    var regionId = ""
    var subCatId = ""
    var editedMainImage = false
    
    //tajeer
    @IBOutlet weak var tajeerv: UIView!
    @IBOutlet weak var tajeer_img: UIImageView!
    @IBOutlet weak var tajeer_txt: UILabel!
    
    //sell
    @IBOutlet weak var sellv: UIView!
    @IBOutlet weak var sell_img: UIImageView!
    @IBOutlet weak var sell_txt: UILabel!
    
    
    //has_phone
    @IBOutlet weak var has_phonev: UIView!
    @IBOutlet weak var has_phone_img: UIImageView!
    @IBOutlet weak var has_phone_txt: UILabel!
    
    //has_wts
    @IBOutlet weak var has_wtsv: UIView!
    @IBOutlet weak var has_wts_img: UIImageView!
    @IBOutlet weak var has_wts_txt: UILabel!
    
    //has_chat
    @IBOutlet weak var has_chatv: UIView!
    @IBOutlet weak var has_chat_img: UIImageView!
    @IBOutlet weak var has_chat_txt: UILabel!
    
    //location
    @IBOutlet weak var loc_main: UILabel!
    @IBOutlet weak var loc_sub: UILabel!
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        has_chatv.borderWidth = 0.7
        has_wtsv.borderWidth = 0.7
        tajeerv.borderWidth = 0.7
        configerSelectedButtons()
        sw_my_phone.setOn(true, animated: false)
        lst.backgroundColor = UIColor.clear.withAlphaComponent(0)
        lst.delegate = self
        lst.dataSource = self
        
      
        
    }
    private func configerSelectedButtons() {
//        udescr.textView.textAlignment = .center
        setupSellViewUI()
        setupHasPhoneViewUI()
        tajeer_img.isHidden = true
        tajeer_txt.textColor = .black
        
        setImage(to: has_wts_img, from: "")
        setImage(to: has_chat_img, from: "")
        has_chat_txt.textColor = .black
        has_wts_txt.textColor = .black
        has_wtsv.borderWidth = 1.2
        has_chatv.borderWidth =  1.2
        has_wtsv.borderColor = .gray
        has_chatv.borderColor =  .gray
        view_put_phone.isHidden = true
        lbl_put_phone.isHidden = true
       
    }
    
    fileprivate func setupSellViewUI() {
        sellv.borderWidth = 1.2
        tajeerv.borderWidth = 0.7
        tajeer_img.borderWidth = 0.7
        tajeer_img.borderColor = .white
        sellv.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.7490196078, blue: 0.6941176471, alpha: 1)
        tajeerv.backgroundColor = .white
        sellv.borderColor = .white
        
        tajeerv.borderColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        setImage(to: sell_img, from: "radiobtn")
        sell_img.isHidden = false
        tajeer_img.isHidden = true
        sell_txt.textColor = .white
        tajeer_txt.textColor = .black
        
    }
    
    fileprivate func setupHasPhoneViewUI(){
        has_phone = "on"
        has_phonev.borderWidth = 1.2
        has_phonev.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.7490196078, blue: 0.6941176471, alpha: 1)
        has_phonev.borderColor = .white
        has_phone_txt.textColor = .white
        setImage(to: has_phone_img, from: "checkbox")
        
    }
    
    
    
    
}
