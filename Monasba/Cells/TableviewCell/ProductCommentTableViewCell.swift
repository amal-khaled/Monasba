//
//  ProductCommentTableView swift
//  Monasba
//
//  Created by Amal Elgalant on 11/05/2023.
//

import UIKit

class ProductCommentTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var report_stack: UIStackView!
    @IBOutlet weak var reportView: UIView!
    @IBOutlet weak var btn_report: UIButton!
    @IBOutlet weak var img_liked: UIImageView!
    @IBOutlet weak var likeContainerView: UIView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var number_of_comments: UILabel!
    @IBOutlet weak var btn_view_comments: UIButton!
    @IBOutlet weak var btn_like: UIButton!

    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(comment: Comment){
        if !StaticFunctions.isLogin() {
            reportView.isHidden = false
        }else {
             reportView.isHidden = true
        }
         name.text = comment.commentUserName
        let isoDate = comment.date

        let dateFormatter = ISO8601DateFormatter()
        let pastDate = dateFormatter.date(from:isoDate ?? "")!
        
        
        date.text = pastDate.timeAgoDisplay()

//        date.text = comment.date.formattedDateSince
         commentLbl.text = comment.comment
         likes.text = "\(comment.countLike ?? 0)"
        //     number_of_comments.text = "(\(cnum_of_comments[inx]))"
        //  btn_like.isSelected
        
        if comment.isLike == 1{
            img_liked.image = UIImage(named: "heartFill")
        }else{
            img_liked.image = UIImage(named: "heartgrey")


        }
         commentLbl.sizeToFit()
        img.setImageWithLoading(url: comment.commentUserPic ?? "")
//         btn_view_comments.tag = inx
//         btn_view_comments.addTarget(self, action: #selector(showReplyPopUp), for: .touchUpInside)
        
        
//         btn_like.tag = inx
//         btn_like.addTarget(self, action: #selector(go_like), for: .touchUpInside)
        
//         btn_report.tag = inx
//         btn_report.addTarget(self, action: #selector(resportAboutComment), for: .touchUpInside)
        
        
//         shadow(8, 0.1)
    }
}
extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
