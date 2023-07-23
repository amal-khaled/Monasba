//
//  BlockUserVC.swift
//  Monasba
//
//  Created by iOSayed on 20/07/2023.
//

import Foundation

class BlockUserVC: UIViewController {
    
    
    
    var otherUserId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapBlockUser(_ sender: UIButton) {
        
        ProfileController.shared.blockUser(completion: { check, message in
            if check == 0 {
                StaticFunctions.createSuccessAlert(msg: message)
                self.dismiss(animated: false)
            }else{
                StaticFunctions.createErrorAlert(msg: message)
            }
        }, OtherUserId: otherUserId)
//        let params : [String: Any]  = ["to_uid":otherUserId ,
//                                       "from_uid":AppDelegate.currentUser.id ?? 0]
//        print("parameters of Blocked ", params)
//        guard let url = URL(string: Constants.DOMAIN + "blocked")else {return}
//        Network.shared.postRequest(url: url, parameter: params, method: .post, headers: nil) { [weak self]( successModel:SuccessModel?, errorModel:ErrorModel?, error) in
//            guard let self = self else {return}
//            if let error = error {
//                print(error)
//                self.msg(error.localizedDescription)
//            }else if let  errorModel = errorModel{
//                print(errorModel.message)
//                self.msg(errorModel.message)
//            }else{
//                self.msg("لقد قمت بحظر الحساب\(user.otherUserName)","ok")
//                self.blockDialogBottomConstraint.constant = -400
//                self.hideV(v: [self.overlay])
//                //self.dismiss(animated: true)
//                self.goNav("mainv")
//            }
//
//        }
    }
    
    @IBAction func didTapCancel(_ sender: UIButton) {
        
    }
}
