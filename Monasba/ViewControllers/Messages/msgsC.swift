
//
//  homeC.swift
//  monasba
//
//  Created by khaled on 1/16/21.
//  Copyright © 2021 roll. All rights reserved.
//

import UIKit
import Alamofire
import M13Checkbox

class msgsC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource{
    @IBOutlet weak var hdr: UIView!
    
    var cids = [String]()
    var crids = [String]()
    var cimgs = [String]()
    var cnames = [String]()
    var cmsgs = [String]()
    var cdates = [String]()
    var ccounts = [String]()
    var cuser_make_block = [String]()
    var cselected = [Bool]()
    var cshow_check = [Int]()
    var roomsData = [RoomsDataModel]()
    
    @IBOutlet weak var lst: UICollectionView!
    
    @IBOutlet weak var noMessagesView: UIView!
    
    @IBOutlet weak var selectAndDeleteViewContainer: UIView!
    //secondery header
    @IBOutlet weak var lbl_del: UILabel!
    @IBOutlet weak var img_del: UIImageView!
    @IBOutlet weak var btn_del: UIButton!
    @IBOutlet weak var btn_select: UIButton!
    @IBOutlet weak var select_allv: UIView!
    @IBOutlet weak var chk_select_all: M13Checkbox!
    @IBAction func go_select() {
        if roomsData.count != 0{
            if btn_select.titleLabel?.text == "تحديد"{
//                txtBtn(btn_select,"إلغاء")
                btn_select.setTitle("إلغاء", for: .normal)
                btn_del.isUserInteractionEnabled = true
//                StaticFunctions.setTextColor(lbl_del, UIColor(named: "#0EBFB1"))
                lbl_del.textColor = UIColor(named: "#0EBFB1")
//                StaticFunctions.setTextColor(lbl_del, UIColor(named: "#0EBFB1"))
                StaticFunctions.setImageFromAssets(img_del, "del_main")
//                showV(v: [select_allv])
                select_allv.isHidden = false
                toggle_show_chk(1)
            }else{
                reset()
            }
        }else{
//              msg("لا توجد محادثات","msg")
            StaticFunctions.createSuccessAlert(msg: "لا توجد محادثات")
        }
    }
    
    func reset(){
        chk_select_all.checkState = .unchecked
//        txtBtn(btn_select,"تحديد")
        btn_select.setTitle("تحديد", for: .normal)
        btn_del.isUserInteractionEnabled = false
//        setTxtColor(lbl_del, colors.gray2_hash)
        StaticFunctions.setTextColor(lbl_del, UIColor.gray)
//        simg(img_del, "del_gray")
        StaticFunctions.setImageFromAssets(img_del, "del_gray")
//        hideV(v: [select_allv])
        select_allv.isHidden = true
        toggle_show_chk(0)
        toggle_selection(false)
    }
    
    func toggle_show_chk(_ val:Int){
        if roomsData.count != 0{
            for i in 0...roomsData.count-1{
                cshow_check[i] = val
            }
            lst.reloadData()
        }else {
          //  msg("لا توجد اشعارات","msg")
        }
        
        
    }
    
    func toggle_selection(_ val:Bool){
        for i in 0...cselected.count-1{
            cselected[i] = val
        }
        lst.reloadData()
    }
    
    
    @IBAction func go_del() {
        if cselected.count != 0 {
        var ids = [String]()
        var id = "0"
        for  i in 0...cselected.count-1{
            if(cselected[i]){
                if let roomId = roomsData[i].id {
                    ids.append("\(roomId)")
                    id = "\(roomId)"
                }
                
            }
        }
        if(ids.count == 0){
//            msg("لم تقم بتحديد اي محادثة");
            StaticFunctions.createErrorAlert(msg: "لم تقم بتحديد اي محادثة")
        }else{
            var endPointURL = ""
            print("ids\(ids)")
//            BG.load(self)
            var params : [String: Any]  = ["uid":AppDelegate.currentUser.id]
            if ids.count > 1 {
                endPointURL = "del_multi_room"
                for i in 0...ids.count-1 {
                    params["room_id[\(i)]"] = "\(ids[i])"
                }
            }else{
                endPointURL = "destroy_room"
                params["room_id"] = "\(id)"
            }
            print("prameters",params)
            guard let url = URL(string: Constants.DOMAIN+endPointURL)else {return}
            AF.request(url, method: .post, parameters: params, encoding:URLEncoding.httpBody).responseDecodable(of:SuccessModel.self){ res in
                switch res.result {
                    
                case .success(let data):
                    print(data)
                    if let message = data.message {
                        if message.contains("تم حذف  ينجاح"){
//                            self.msg(message,"msg")
                            StaticFunctions.createSuccessAlert(msg: message)
                            self.reset()
                            self.selectAndDeleteViewContainer.isHidden = true
                            self.get()
                            
                        }else{
//                            self.msg(message,"msg")
                            StaticFunctions.createErrorAlert(msg: message)
                        }
                        
                    }
                case .failure(let error):
                    print(error)
                }
            }
            //
            //        .responseString { (e) in
            //                    BG.hide(self)
            //                    if let res = e.value {
            //                        if(res.contains("true")){
            //                            self.reset()
            //                            self.get()
            //                        }
            //                    }
            //            }
        }
        }else{
//            self.msg("لا توجد محادثات لحذفها" ,"msg")
            StaticFunctions.createErrorAlert(msg: "لا توجد محادثات لحذفها")
        }
    }
    
    @IBAction func checkboxValueChanged(_ sender: M13Checkbox) {
        switch sender.checkState {
        case .unchecked:
            toggle_selection(false)
        case .checked:
            toggle_selection(true)
        case .mixed:
            print("mixed")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if !StaticFunctions.isLogin(){
            basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
            
        }
        lst.backgroundColor = UIColor.clear.withAlphaComponent(0)
        selectAndDeleteViewContainer.isHidden = true
        //chk_select_all
        chk_select_all.markType = .checkmark
        chk_select_all.boxType = .square
        chk_select_all.boxLineWidth = 2
        chk_select_all.checkmarkLineWidth = 2
        chk_select_all.secondaryTintColor = UIColor(named: "#0EBFB1")
        chk_select_all.secondaryCheckmarkTintColor = UIColor.white
        chk_select_all.tintColor = UIColor(named: "#0EBFB1")
        chk_select_all.stateChangeAnimation = .bounce(.fill)
        get()
    }
    
    func clear_all(){
        cids.removeAll()
        crids.removeAll()
        cimgs.removeAll()
        cnames.removeAll()
        cmsgs.removeAll()
        cdates.removeAll()
        ccounts.removeAll()
        cuser_make_block.removeAll()
        cselected.removeAll()
        cshow_check.removeAll()
        roomsData.removeAll()
        lst.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //selectAndDeleteStckView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !StaticFunctions.isLogin(){
            basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
        }
        if roomsData.count == 0 {
            selectAndDeleteViewContainer.isHidden = true
        }else {
            selectAndDeleteViewContainer.isHidden = false
        }
    }
    
    
    func get(){
        clear_all()
//        BG.load(self)
      //  let params : [String: Any]  = ["uid":user.id]
    //let headerTest = headerProd:HTTPHeaders = ["Authorization":"Bearer \(user.accessToken)"]
       // selectAndDeleteStckView.isHidden = true
        guard let url = URL(string: Constants.DOMAIN+"get_rooms")else{return}
        print(" ========> ",Constants.headerProd)
        print(AppDelegate.currentUser.toke ?? "")
        AF.request(url, method: .post, headers: Constants.headerProd).responseDecodable(of:AllRoomsSuccessModel.self){ [weak self] res in
            guard let self = self else {return}
//            BG.hide(self)
           
            print(res)
            switch res.result {
            case .success(let data):
                if let data = data.data {
                    print(data)
                    self.roomsData = data
                    if data.count > 0 {
                            DispatchQueue.main.async {
                                self.selectAndDeleteViewContainer.isHidden = false
                                self.noMessagesView.isHidden = true
                        }
                       
                    }
                    for _ in 0..<data.count{
                        self.cshow_check.append(0)
                        self.cselected.append(false)
                    }
                    
                }
                DispatchQueue.main.async {
                    self.lst.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        }
//            .responseJSON { (e) in
//                BG.hide(self)
//                if let res = e.value {
//                    print(res)
//                    if let arr = res as? NSArray {
//                        for itm in arr {
//                            if let d = itm as? NSDictionary {
//
//                                let u = d["user"] as! NSDictionary
//
//                                let last_msg = d["last_msg"] as! NSDictionary
//                                if(last_msg["mtype"] as! String == "TEXT"){
//                                    self.cmsgs.append(last_msg["msg"] as! String)
//                                }else{
//                                    self.cmsgs.append("تم ارسال مرفق")
//                                }
//
//                                if let name = d.value(forKey: "id") as? String {
//                                    self.cids.append(name)
//                                    print(self.cids)
//                                }
//                                if let name = u.value(forKey: "id") as? String {
//                                    self.crids.append(name)
//                                }
//                                if let name = u.value(forKey: "name") as? String {
//                                    self.cnames.append(name)
//                                }
//                                if let name = u.value(forKey: "pic") as? String {
//                                    self.cimgs.append(name)
//                                }
//                                if let name = last_msg.value(forKey: "date") as? String {
//                                    self.cdates.append(name)
//                                }
//                                if let name = d.value(forKey: "unseen_count") as? String {
//                                    self.ccounts.append(name)
//                                }
//                                if let name = d.value(forKey: "user_make_block") as? String {
//                                    self.cuser_make_block.append(name)
//                                }
//                                self.cshow_check.append(0)
//                                self.cselected.append(false)
//
//                            }
//                        }
//                    }
//                    self.lst.reloadData()
//                }
//        }
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
//        guard let count = roomsData.count else {return Int()}
        print(roomsData.count)
        return roomsData.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let inx = indexPath.row
        let cell = lst.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! roomCell
         if roomsData[indexPath.row].messages?.sid == AppDelegate.currentUser.id {
             lst.contentMode = .right
         }else {
             lst.contentMode = .left
         }
         
        if roomsData[inx].user?.count != 0{
            if  let userName = roomsData[inx].user?[0].name  {
                
                cell.name.text = userName
            }
            cell.img.setImageWithLoading(url: roomsData[inx].user?[0].pic ?? "users/1675802939.png")
        }else{
            cell.name.text = "User"
            cell.img.image = UIImage(named: "logo_photo")
        }
        
        //let pic = roomsData[inx].user?[inx].pic
        
//        cell.img.imgUrl = roomsData[inx].user?[inx].pic ?? ""
//        cell.name.text = roomsData[inx].user?[inx].username
        
        if(roomsData[inx].messages?.mtype == "TEXT"){
            cell.last_msg.text = roomsData[inx].messages?.msg
        }else{
            self.cmsgs.append("تم ارسال مرفق")
            cell.last_msg.text = cmsgs[0]

        }
        if let count = roomsData[inx].unseenCount {
            cell.count.text = "\(count)"
        }
        
        if let date = roomsData[inx].date {
            cell.since.text = diffDates(GetDateFromString(date)).replace("-", "")
        }
        
        if(roomsData[inx].unseenCount == 0){
//            setBgColor(cell.count, "#ffffff")
            cell.count.backgroundColor = UIColor.white
        }else{
            cell.count.backgroundColor = UIColor(hexString: "#444A50")
//            setBgColor(cell.count, "#444A50")
        }
        
        if(cshow_check[inx] == 1){
            cell.chk_width.constant = 44
            print(cshow_check[inx])
        }else{
            cell.chk_width.constant = 13
        }
        
        if(cselected[inx]){
            cell.chk.checkState = .checked
        }else{
            cell.chk.checkState = .unchecked
        }
        
        cell.chk.tag = inx
        cell.chk.addTarget(self, action: #selector(cellCheckboxValueChanged), for: .valueChanged)
        
        cell.shadow(1, 0.03)
        cell.last_msg.setLineSpacing(lineSpacing: 1, lineHeightMultiple: 1.5)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: lst.frame.width - 30, height: 90)
    }
    
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let inx = indexPath.row
        if let roomId = roomsData[inx].id {
            receiver.room_id = "\(roomId)"
            Constants.room_id = "\(roomId)"
        }
         if roomsData[inx].user?.count != 0 {
             if let receiverName = roomsData[inx].user?[0].name , let lastName = roomsData[inx].user?[0].lastName{
                 receiver.name = receiverName
                 Constants.otherUserName = "\(receiverName) \(lastName)"
             }
             if let receiverId = roomsData[inx].user2{
                 receiver.id = "\(receiverId)"
                     Constants.userOtherId = "\(receiverId)"
             }
             if let receiverPic = roomsData[inx].user?[0].pic {
                 Constants.otherUserPic = receiverPic
             }
     //        goNav("chatv","Chat")
             //Goto Chat
             let vc = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
             vc.modalPresentationStyle = .fullScreen
             present(vc, animated: true)
             
         }else {
//             self.msg(" لم يعد بإمكانك التحدث مع هذا المستخدم تم حذف بياناتة من مناسبة ","msg")
             StaticFunctions.createErrorAlert(msg: " لم يعد بإمكانك التحدث مع هذا المستخدم تم حذف بياناتة من مناسبة ")
         }
        
        //receiver.name = cnames[inx]
       // receiver.id = crids[inx]
       // user.other_id = crids[inx]
//        order.room_id = cids[inx]
      //  user.otherUserPic = cimgs[inx]
      //  user.otherUserName = cnames[inx]
       
    }
    
    @objc func cellCheckboxValueChanged(_ sender: M13Checkbox) {
        let inx = sender.tag
        switch sender.checkState {
        case .unchecked:
            cselected[inx] = false
            
        case .checked:
            cselected[inx] = true
            
        case .mixed:
            print("")
            
        }
    }
}
