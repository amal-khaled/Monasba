//
//  ssas.swift
//  Monasba
//
//  Created by iOSayed on 14/06/2023.
//

//
//  homeC.swift
//  monasba
//
//  Created by khaled on 7/16/21.
//  Copyright © 2021 roll. All rights reserved.
//

import UIKit
import Alamofire

class profileRatesVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var lst: UITableView!
    var data = RateData()
    var UserId = 0
    
    var rateId = [String]()
    var otherUserId = [String]()
    var userId = [String]()
    var rateMessage = [String]()
    var rateStar = [String]()
    var rateDate = [String]()
    var otherUserName = [String]()
    var userPicture = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //lst.backgroundColor = UIColor.clear.withAlphaComponent(0)
        lst.registerCell(cell: RateOtherUserCell.self)
        lst.rowHeight = UITableView.automaticDimension
        lst.estimatedRowHeight = 50
        lst.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 400, right: 0)
        
//        addObserver("loadRatings", #selector(getRate))
//        getRate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver("loadRatings", #selector(getRate))
        
        getRate()
    }
    
    func clearAll()  {
         rateId.removeAll()
         otherUserId.removeAll()
         userId.removeAll()
         rateMessage.removeAll()
         rateStar.removeAll()
         rateDate.removeAll()
         otherUserName.removeAll()
         userPicture.removeAll()
    }
    
    @objc func getRate(){
        data.data?.removeAll()
        clearAll()
        let params : [String: Any]  = ["uid":UserId]
        print(params)
        guard let url = URL(string: Constants.DOMAIN+"get_rate_user")else{return}
        AF.request(url, method: .post, parameters: params).responseDecodable(of:RateSuccessModel.self){res in
            print(res.value)
            switch res.result {
                
            case .success(let data):
                if let rateData = data.data {
                    self.data = rateData
                    DispatchQueue.main.async {
                        self.lst.reloadData()

                    }
                }
            case .failure(let error):
                print(error)
            }
        }
            //.responseJSON{ e in
//            if let res = e.value {
//                print(res)
//                if let data = res as? NSDictionary  {
//
//                    if let rateData = data["data"] as? NSDictionary   {
//                if let arr = rateData as? NSArray {
//                    for itm in arr {
////                        if let d = itm as? NSDictionary {
////                            let u = d["user"] as! NSDictionary
//
//                            if let rateId = itm.value(forKey: "id") as? Int {
//                                self.rateId.append("\(rateId)")
//                            }
//                            if let otherUserId = itm.value(forKey: "user_rated_id") as? Int {
//                                self.otherUserId.append("\(otherUserId)")
//                            }
//                            if let userId = itm.value(forKey: "uid") as? Int {
//                                self.userId.append("\(userId)")
//                            }
//                            if let rateMessage = itm.value(forKey: "comment") as? String {
//                                self.rateMessage.append(rateMessage)
//                            }
//                            if let rateStar = itm.value(forKey: "rating") as? String {
//                                self.rateStar.append(rateStar)
//                            }
//                            if let rateDate = itm.value(forKey: "date") as? String {
//                                self.rateDate.append(rateDate)
//                            }
//                            if let otherUserName = itm.value(forKey: "name") as? String {
//                                self.otherUserName.append(otherUserName)
//                            }
//                            if let userPic = itm.value(forKey: "pic") as? String {
//                                self.userPicture.append(userPic)
//                            }
//                      //  }
//
//                    }
//                }
//            }
//        }
//                self.lst.reloadData()
//            }
//
//        }
//            .responseDecodable(of: [Rating].self) { e in
//                print(e)
//                switch e.result {
//                case let .success(data):
//                    self.data = data
//                    DispatchQueue.main.async {
//                        self.lst.reloadData()
//                    }
//                case let .failure(error):
//                    print(error.localizedDescription)
//                }
//            }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = data.data?.count else {return Int()}
        return count
        //  return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inx = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "RateOtherUserCell", for: indexPath) as! RateOtherUserCell
        if let data = data.data?[inx] {
            cell.configure(data: data )
        }
        return cell
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        remObserver()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inx = indexPath.row
       // user.other_id = data[inx].user.id
        if let userId = data.data?[inx].userRatedID {
            //user.other_id = "\(userId)"
           // goNav("otherProfilev","Profile")
        }
        
    }
}
