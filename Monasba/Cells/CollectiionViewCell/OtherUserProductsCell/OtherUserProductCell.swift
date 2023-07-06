//
//  OtherUserProductCell.swift
//  Monasba
//
//  Created by iOSayed on 14/06/2023.
//

import UIKit

class OtherUserProductCell: UICollectionViewCell {
        
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var is_video: UIView!
    
    override class func awakeFromNib() {
            //view.shadow(2, 0.1)
        }
        
        func configure(data:SpecialProdModel) {
            if let image = data.img , let prodImage = data.prodsImage {
                if image != "" {
                    if image.contains(".mp4") || image.contains(".mov"){
                        img.setImageWithLoading(url: image)
                        is_video.showMe()
                    }else{
                        img.setImageWithLoading(url: image)
                        is_video.hideMe()
                    }
                }else {
                    if prodImage.contains(".mp4") || prodImage.contains(".mov"){
                        img.setImageWithLoading(url: prodImage)
                        is_video.showMe()
                    }else{
                        img.setImageWithLoading(url: prodImage)
                        is_video.hideMe()
                    }
                }
                
            }
            
    //        let prodpic = data.prodsImage ?? ""
    //        if prodpic.contains(".mp4") || prodpic.contains(".mov"){
    //            img.videoUrl = prodpic
    //            is_video.showMe()
    //        }else{
    //            img.imgUrl = prodpic
    //            is_video.hideMe()
    //        }
        }
    }

