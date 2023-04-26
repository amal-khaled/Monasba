//
//  SubCategoryCollectionViewCell.swift
//  Monasba
//
//  Created by Amal Elgalant on 25/04/2023.
//

import UIKit

class SubCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    
    func setData(category: Category){
        titleLbl.text = category.name ?? ""
    }
    

}
