//
//  NotificationsViewController.swift
//  Monasba
//
//  Created by Amal Elgalant on 25/05/2023.
//

import UIKit
import M13Checkbox

class NotificationsViewController: UIViewController {
    var notiiifications = [UserNotification]()
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var checkBoxValueChanged: M13Checkbox!
    @IBOutlet weak var selectAllView: UIView!
    @IBOutlet weak var deleteLabel: UILabel!
    @IBOutlet weak var deleteImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
//    let cellSpacingHeight: CGFloat = 8
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
getData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        deleteNotifications()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension NotificationsViewController{
    func getData(){
        NotificationsController.shared.getNotifications(completion: {
            notifications, check, msg in
            
            self.notiiifications = notifications
            self.tableView.reloadData()
            if check == 1{
                StaticFunctions.createErrorAlert(msg: msg)
            }
        })
    }
    func deleteNotifications(){
        NotificationsController.shared.deleteNotifications(completion: {
        check, msg in
            if check == 0{
                self.notiiifications.removeAll()
                self.tableView.reloadData()
                StaticFunctions.createSuccessAlert(msg: msg)

            }
           else{
                StaticFunctions.createErrorAlert(msg: msg)
            }
        })
    }
}
extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiiifications.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NotificationTableViewCell
        cell.setData(userNotification: notiiifications[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        if let notificatinSenderId = notiiifications[index].oid {
            switch notiiifications[index].ntype {
            case "ASK_REPLY" :
//                order.quest_id = "\(notificatinSenderId)"
//                goNav("ask_repliesv","AskReplies")
                print("ASK_REPLY")
            case "REPLY_COMMENT":
                print("REPLY_COMMENT")
//                print("\(notificatinSenderId)")
//                order.comment_id = "\(notificatinSenderId)"
//                goNav("comment_repliesv","AskReplies")
            case "COMMENT_ADV":
                print("COMMENT_ADV")
                let vc = UIStoryboard(name: PRODUCT_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: PRODUCT_VCID) as! ProductViewController
                vc.product.id = notificatinSenderId
                self.navigationController?.pushViewController(vc, animated: true)
            case "ADD_ADV":
                let vc = UIStoryboard(name: PRODUCT_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: PRODUCT_VCID) as! ProductViewController
                vc.product.id = notificatinSenderId
                self.navigationController?.pushViewController(vc, animated: true)
                print("ADD_ADV")
            case "LIKE_COMMENT":
                let vc = UIStoryboard(name: PRODUCT_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: PRODUCT_VCID) as! ProductViewController
                vc.product.id = notificatinSenderId
                self.navigationController?.pushViewController(vc, animated: true)
                print("LIKE_COMMENT")
            case "FOLLOW":
                let vc = UIStoryboard(name: PROFILE_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: OTHER_USER_PROFILE_VCID) as! OtherUserProfileVC
                vc.user.id = notificatinSenderId
                self.navigationController?.pushViewController(vc, animated: true)
                print("FOLLOW")
            case "CHAT":
//
//                print(receiver.room_id)
//                receiver.room_id = "\(notificatinSenderId)"
//                print(receiver.room_id)
//
//
//                if data[index].userf?.count != 0 {
//                    if let userName = data[index].userf?[0].name , let userPic =  data[index].userf?[0].pic , let userId = data[index].userf?[0].id {
//                        user.other_id = "\(userId)"
//                        user.otherUserPic = userPic
//                        user.otherUserName = userName
//                    }
//                        goNav("chatv","Chat")
                        print("CHAT")
//                }else {
//                   // let userId = data[index].userf?[0].id
//                    self.msg(" هذا المستخدم تم حذف بياناته من قبل المسؤل","msg")
//                }
            default:
                print("FOLLOW")
            }
        }
    }
}