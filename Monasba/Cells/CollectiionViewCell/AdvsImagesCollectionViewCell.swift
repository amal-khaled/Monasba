//
//  AdvsImagesCollectionViewCell.swift
//  Monasba
//
//  Created by iOSayed on 07/05/2023.
//

import UIKit

protocol AdvsImagesCollectionViewCellDelegate:AnyObject{
    func didRemoveCell(indexPath:IndexPath)
}

class AdvsImagesCollectionViewCell: UICollectionViewCell {
    
    var indexPath:IndexPath?
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var mainImageFlag: UILabel!
    
    @IBOutlet weak var removeButton: UIButton!
    
    weak var delegate:AdvsImagesCollectionViewCellDelegate?
    
    override class func awakeFromNib() {
    }
    
    func configureCell(images:[UIImage]){
        guard let indexPath = indexPath else {return}
        
        imageView.image = images[indexPath.row]
        if indexPath.row == 0 {
            mainImageFlag.isHidden = false
        }else {
            mainImageFlag.isHidden = true
        }
    }
    
    @IBAction func didTapRemoveCellButton(_ sender: UIButton) {
        
        guard let delegate = delegate, let indexPath = indexPath else { return }
        delegate.didRemoveCell(indexPath: indexPath)
    }
    
}
