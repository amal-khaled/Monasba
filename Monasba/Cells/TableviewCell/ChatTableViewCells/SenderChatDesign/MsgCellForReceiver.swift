//
//  ProdSpecialCell.swift
//  monasba
//
//  Created by khaled on 21/05/2022.
//  Copyright © 2022 roll. All rights reserved.
//

import UIKit

class MsgCellForReceiver: MsgGlobalCell {

    @IBOutlet weak var lbl_msg: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    
    override func awakeFromNib() {
        lbl_msg.apply_right_bubble()
    }
    
    override func configure(data:Result) {
        print(data.rid , "user", AppDelegate.currentUser.id)
//        if data.rid == AppDelegate.currentUser.id {
//            lbl_msg.backgroundColor = .gray
//        }else {
//            lbl_msg.backgroundColor =  UIColor(named: "#0EBFB1")
//        }
        lbl_msg.text = data.msg
        if let date = data.date?.formattedDateSince {
            lbl_date.text = date

        }
    }
}
