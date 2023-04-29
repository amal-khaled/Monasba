//
//  SubCategoryCollectionViewCell.swift
//  Monasba
//
//  Created by Amal Elgalant on 25/04/2023.
//

import UIKit
import MOLH

class SubCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    
    override var isSelected: Bool {
            didSet {
                
                self.contentView.backgroundColor = isSelected ? UIColor(named: "#0EBFB1") : UIColor(named: "#F3F3F3")
                self.titleLbl.textColor = isSelected ? UIColor.white : UIColor(named: "blackColor")

            }
          
        }
    
    func setData(category: Category){
        if  MOLHLanguage.currentAppleLanguage() == "en" {
            
            titleLbl.text = category.nameEn ?? category.nameAr ?? ""
        }
        
        else{
            titleLbl.text = category.nameAr ?? category.nameEn ?? ""

        }
        
    }
    

}
