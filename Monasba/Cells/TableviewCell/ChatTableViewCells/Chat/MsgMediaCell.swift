//
//  ProdSpecialCell.swift
//  monasba
//
//  Created by khaled on 21/05/2022.
//  Copyright © 2022 roll. All rights reserved.
//

import UIKit

class MsgMediaCell: MsgGlobalCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var videov: UIView!
    @IBOutlet weak var img_video: UIImageView!
    override func awakeFromNib() {
        img.apply_right_bubble()
        videov.apply_right_bubble()
        container.apply_right_bubble()
    }
    
    override func configure(data:Result) {
        if data.rid == AppDelegate.currentUser.id {
            container.backgroundColor = .gray
        }else {
            container.backgroundColor =  UIColor(named: "#0EBFB1")
        }
        
        if let image = data.image {
            img.setImageWithLoading(url: image)
        }
        if data.mtype == "VIDEO"{
            videov.showMe()
            img_video.showMe()
        }else{
            videov.hideMe()
            img_video.hideMe()
        }
    }
}
