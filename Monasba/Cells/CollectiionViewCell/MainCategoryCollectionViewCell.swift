//
//  MainCategoryCollectionViewCell.swift
//  Monasba
//
//  Created by Amal Elgalant on 25/04/2023.
//

import UIKit
import SDWebImage
import MOLH

class MainCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryContainerView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override var isSelected: Bool {
            didSet {
                self.contentView.backgroundColor = isSelected ? UIColor(named: "#0EBFB1") : UIColor(named: "#F3F3F3")
                self.titleLbl.textColor = isSelected ? UIColor.white :  UIColor(named: "blackColor")
              
            }
          
        }
    func setData(category: Category){
        
        if category.id == -1{
            categoryImageView.image = UIImage(named: "CategoryIcon")
        }else{
            categoryImageView.setImageWithLoading(url: category.image ?? "")
//            sd_setImage(with: URL(string: category.image ?? ""), placeholderImage: UIImage(named: "logo_monasba"))
        }
        
      //  categoryImageView.sd_setImage(with: URL(string: category.image ?? ""), placeholderImage: UIImage(named: "logo_monasba"))
        if  MOLHLanguage.currentAppleLanguage() == "en" {
            
            titleLbl.text = category.nameEn ??  category.nameAr ?? ""
        }
        
        else{
            titleLbl.text = category.nameAr ?? category.nameEn ?? ""

        }
    }
    
}
