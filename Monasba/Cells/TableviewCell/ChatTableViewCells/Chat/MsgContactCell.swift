//
//  ProdSpecialCell.swift
//  monasba
//
//  Created by khaled on 21/05/2022.
//  Copyright © 2022 roll. All rights reserved.
//

import UIKit

class MsgContactCell: MsgGlobalCell {

    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var btn_save: UIButton!
    @IBOutlet weak var btn_call: UIButton!
    @IBOutlet weak var img: UIImageView!

    override func awakeFromNib() {
    }
    
    override func configure(data:Result) {
        if let locData = data.msg?.components(separatedBy: "%%"){
            lbl_name.text = locData[0].uppercased()
        }
        img.localImg(src: "profilepic")
    }
}
