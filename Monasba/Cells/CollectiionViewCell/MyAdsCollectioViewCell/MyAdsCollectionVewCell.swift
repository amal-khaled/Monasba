//
//  MyAdsCollectionVewCell.swift
//  Monasba
//
//  Created by iOSayed on 24/05/2023.
//

import UIKit
import MOLH

protocol MyAdsCollectionViewCellDelegate: AnyObject {
    func deleteAdCell(buttonDidPressed indexPath: IndexPath)
    func shareAdCell(buttonDidPressed indexPath: IndexPath)
    func editAdCell(buttonDidPressed indexPath: IndexPath)
}

class MyAdsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var adTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel : UILabel!
    @IBOutlet weak var adImageView: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var isVideoImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var verifiedImage: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var sellLabel: UILabel!
    @IBOutlet weak var sellView: UIView!
    @IBOutlet weak var deleteAdButton: UIButton!
    @IBOutlet weak var shareAdButton: UIButton!
    
    
    //MARK: Properties
    weak var delegate: MyAdsCollectionViewCellDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(product: Product){
        
        adTitleLabel.text = product.name
        priceLabel.text = "\(product.price ?? 0)"
        
        if  MOLHLanguage.currentAppleLanguage() == "en" {
            currencyLabel.text = product.currencyEn
            cityLabel.text = product.cityNameEn
            
        }else{
            currencyLabel.text = product.currencyAr
            cityLabel.text = product.cityNameAr
            
        }
        userNameLabel.text = "\(product.userName ?? "") \(product.userLastName ?? "")"
        if product.userVerified == 1{
            verifiedImage.isHidden = false
        }else{
            verifiedImage.isHidden = true
        }
        
        if let tajeerOrSell = product.type  {
            
            if( tajeerOrSell == 1){
                sellLabel.text = "rent"
                sellLabel.textColor = .black
                sellView.layer.borderWidth = 1.0
                sellView.layer.borderColor = UIColor.black.cgColor
                sellView.clipsToBounds = true
                sellView.backgroundColor = .white
            }else{
                sellLabel.text = "sell"
                sellView.layer.borderWidth = 1.0
                sellView.layer.borderColor = UIColor(named: "#0EBFB1")?.cgColor
                sellView.clipsToBounds = true
                sellLabel.textColor = .white
                sellView.backgroundColor = UIColor(named: "#0EBFB1")
            }
        }
        if let createDate = product.createdAt{
            if  MOLHLanguage.currentAppleLanguage() == "en" {
                timeLabel.text = " \(diffDates(GetDateFromString(createDate)).components(separatedBy: "-")[1]) ago"
            }else {
                timeLabel.text = " قبل \(diffDates(GetDateFromString(createDate)).components(separatedBy: "-")[1])"
            }
        }
        var imageLink = Constants.IMAGE_URL +  (product.image ?? "")
        adImageView.setImageWithLoading(url: imageLink )
        if imageLink.contains(".mp4")  || imageLink.contains(".mov") {
            isVideoImageView.isHidden = false
        }else{
            isVideoImageView.isHidden = true
            
        }
        
    }
    
    //MARK: IBActions
    
    @IBAction func didTapEditAdButton(_ sender: UIButton) {
        guard let delegate = delegate , let indexPath = indexPath else {return}
        delegate.editAdCell(buttonDidPressed: indexPath)
        
    }
    
    @IBAction func didTapDeleteAdButton(_ sender: UIButton) {
        guard let delegate = delegate , let indexPath = indexPath else {return}
        delegate.deleteAdCell(buttonDidPressed: indexPath)
    }
    
    @IBAction func didTapShareAdButton(_ sender: UIButton) {
        guard let delegate = delegate , let indexPath = indexPath else {return}
        delegate.shareAdCell(buttonDidPressed: indexPath)
    }
    
}
