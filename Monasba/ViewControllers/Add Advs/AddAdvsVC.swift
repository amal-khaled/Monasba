//
//  AddAdvsVC.swift
//  Monasba
//
//  Created by iOSayed on 01/05/2023.
//

import UIKit

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
    
    
    //MARK: App LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: IBActions
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addPhotoBtnAction(_ sender: UIButton) {
        
        let vc = UIStoryboard(name: ADVS_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier:  PICKUP_MEDIA_POPUP_VCID) as! PickupMediaPopupVC
        present(vc, animated: false)
    }
    
    @IBAction func mainCatsBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func subCatsBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func cityBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func regionBtnAction(_ sender: UIButton) {
        
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
