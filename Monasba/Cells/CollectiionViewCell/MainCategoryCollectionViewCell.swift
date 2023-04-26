//
//  MainCategoryCollectionViewCell.swift
//  Monasba
//
//  Created by Amal Elgalant on 25/04/2023.
//

import UIKit
import SDWebImage

class MainCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    func setData(category: Category){
        categoryImageView.sd_setImage(with: URL(string: category.image ?? ""), placeholderImage: UIImage(named: "logo_monasba"))
        titleLbl.text = category.name ?? ""
    }
    
}
