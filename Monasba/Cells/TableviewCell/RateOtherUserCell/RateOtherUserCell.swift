//
//  RateOtherUserCell.swift
//  Monasba
//
//  Created by iOSayed on 14/06/2023.
//

import UIKit
import Cosmos

class RateOtherUserCell: UITableViewCell {

        @IBOutlet weak var rate: CosmosView!
        @IBOutlet weak var lbl_name: UILabel!
        @IBOutlet weak var lbl_comment: UILabel!
        @IBOutlet weak var lbl_date: UILabel!
        @IBOutlet weak var img: UIImageView!
        
        
        func configure(data:RateDataModel) {
            guard let userPic = data.fromUserPic , let userName = data.fromUserName  , let userId = data.userRatedID , let date = data.date else {return}
            img.setImageWithLoading(url: userPic)
            lbl_name.text = userName
            lbl_comment.text = data.comment
            lbl_comment.setLineSpacing()
            rate.rating = Double(data.rate)
            lbl_date.text = cDate(GetDateFromString(date),"EEEE d MMMM")
        }
    }

