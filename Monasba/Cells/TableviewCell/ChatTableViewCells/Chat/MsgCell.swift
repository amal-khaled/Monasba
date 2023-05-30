//
//  ProdSpecialCell.swift
//  monasba
//
//  Created by khaled on 21/05/2022.
//  Copyright © 2022 roll. All rights reserved.
//

import UIKit

class MsgCell: MsgGlobalCell {

    @IBOutlet weak var lbl_msg: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    
    override func awakeFromNib() {
        lbl_msg.apply_right_bubble()
    }
    
    override func configure(data:Result) {
        lbl_msg.text = data.msg
        if let date = data.date?.formattedDateSince {
            lbl_date.text = date

        }
    }
}
