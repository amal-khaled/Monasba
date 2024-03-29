//
//  FollowersAndFollowingsVC.swift
//  Monasba
//
//  Created by iOSayed on 16/07/2023.
//

import UIKit

class FollowersAndFollowingsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!

    var userId = 0
    var otherUserId = 0
    var page = 1
    var isFollowings = true
    let collectionsTaps = ["Followings".localize , "Followers".localize]
    var data = [FollowersSuccessData]()
    var indexPath:IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        configeView()
        indexPath = [0,0]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: METHODS

    private func configeView(){
        self.title = "Followings / Followers".localize
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.delegate = self
        
        collectionView.register(UINib(nibName: "FollowAndFollowersTapsCell", bundle: nil), forCellWithReuseIdentifier: "FollowAndFollowersTapsCell")
        tableView.register(UINib(nibName: "FollowTVCell", bundle: nil), forCellReuseIdentifier: "FollowTVCell")
        collectionView.selectItem(at: [0,0], animated: true, scrollPosition: .centeredHorizontally)
        getFollowings(page: page)
    }
    
    
    private func getFollowers(){
        FollowersController.shared.getFollowers(completion: { followers, message in
            if let followers = followers {
                self.data = followers
                self.tableView.reloadData()
            }else {
                print(message)
            }
        }, for: userId)
    }

    private func getFollowings(page:Int){
        FollowersController.shared.getFollowings(completion: { followings, message in
            if let followings = followings {
                self.data.append(contentsOf: followings)
                self.tableView.reloadData()
            }else {
                print(message)
            }
        }, for: userId, page: page)
    }
}
extension FollowersAndFollowingsVC :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionsTaps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowAndFollowersTapsCell", for: indexPath) as? FollowAndFollowersTapsCell else {return UICollectionViewCell()}
        cell.setup(from: collectionsTaps[indexPath.item])
        self.indexPath = indexPath
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            self.indexPath = indexPath
            self.data.removeAll()
            self.page = 1
            self.isFollowings = true
            getFollowings(page: page)
        }else {
            self.indexPath = indexPath
            self.data.removeAll()
            self.isFollowings = false
            getFollowers()
        }
    }
    
    
}

extension FollowersAndFollowingsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inx = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowTVCell", for: indexPath) as! FollowTVCell
        if data.count >= indexPath.row {
            cell.configureFollow(data: data[inx], indexPath: self.indexPath ?? [0,0])
                cell.btn_follow.tag = inx
                cell.btn_follow.addTarget(self, action: #selector(go_follow), for: .touchUpInside)
        }
        
        return cell
    }

    
   @objc func go_follow(_ sender:UIButton){
//       if Constants.followIndex == 0  {
//           //following
//             otherUserId = data[sender.tag].toID ?? 0
//       }else{
//           //followers
//             otherUserId = data[sender.tag].userID ?? 0
//       }
//       guard  let otherUserId = data[sender.tag].userID,let url = URL(string: Constants.DOMAIN+"make_follow") else {return}
//       guard let url = URL(string: Constants.DOMAIN+"make_follow") else {return}
//       print(otherUserId)
//       let params : [String: Any]  = ["to_id":otherUserId]
//       print(params)
//       AF.request(url, method: .post, parameters: params,headers: Constants.headerProd).responseDecodable(of:SuccessModel.self){res in
//           print(res.result)
//           switch res.result {
//           case .success(let data):
//               if let message = data.message {
//                   StaticFunctions.createSuccessAlert(msg: message)
//                   self.get()
//               }
//           case .failure(let error):
//               print(error)
//           }
//       }
       
       if self.indexPath?.item == 0 {
           guard let id = data[sender.tag].toID else {return}
           print(id)
           self.otherUserId = id
//           getFollowings(page: page)
       }else{
           guard let id = data[sender.tag].userID else {return}
           print(id)
           self.otherUserId = id
//           getFollowers()
       }
       
       ProfileController.shared.followUser(completion: { check, message in
           if check == 0 {
//               StaticFunctions.createSuccessAlert(msg: message)
               if self.data[sender.tag].isFollow == 0 {
                   self.data[sender.tag].isFollow = 1
               }else{
                   self.data[sender.tag].isFollow = 0
               }
               self.tableView.reloadData()
           }else{
               StaticFunctions.createErrorAlert(msg: message)
           }
       }, OtherUserId: otherUserId)
   }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inx = indexPath.row
        
        
         let vc = UIStoryboard(name: PROFILE_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: OTHER_USER_PROFILE_VCID) as! OtherUserProfileVC
        if self.indexPath?.item == 0 {
            guard let id = data[inx].toID else {return}
            print(id)
            vc.OtherUserId = id
        }else {
            guard let id = data[inx].userID else {return}
            print(id)
            vc.OtherUserId = id
        }
         
         navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.isFollowings {
            if indexPath.row == (data.count-1){
                page+=1
                getFollowings(page: page)
                
            }
        }
    }
    }

