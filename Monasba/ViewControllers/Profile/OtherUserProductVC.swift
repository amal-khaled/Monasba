//
//  OtherUserProductVC.swift
//  Monasba
//  Created by iOSayed on 14/06/2023.
//

import UIKit
import Alamofire

class OtherUserProductVC: UIViewController {
    var products = [SpecialProdModel]()
    var page = 1
    var lastPage = 0
    var otherUserID = "0"
    var otherUserCountryId = 0
    @IBOutlet weak var lst: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserIDNotification(_:)), name: .userIDNotification, object: nil)

     
        //lst.backgroundColor = UIColor.clear.withAlphaComponent(0)
        lst.flipX()
//        lst.registerCell(cell: OtherUserProductCell.self)
//        lst.register(OtherUserProductCell.self, forCellWithReuseIdentifier: "OtherUserProductCell")
        lst.register(UINib(nibName: "OtherUserProductCell", bundle: nil), forCellWithReuseIdentifier: "OtherUserProductCell")
        if let layout = lst.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        lst.configure(top:15, bottom:400, left: 15, right: 15,hspace:15)
        
        
    }
    
    @objc func handleUserIDNotification(_ notification: Notification) {
        if let userID = notification.userInfo?["userID"] as? String {
            // Use the userID here
            print(userID)
            self.otherUserID = userID
            products.removeAll()
            get(page: page)
        }
    }
    
    func clear_all(){
        lst.reloadData()
    }
    func get(page:Int){
       // products.data?.data?.removeAll()
        let params : [String: Any]  = ["uid":2359,"country_id":5, "page":page]
        print("parameters for get my advs ======> ", params)
        guard let url = URL(string: Constants.DOMAIN+"prods_by_user") else{return}
        AF.request(url, method: .post, parameters: params)
            .responseDecodable(of: SpecialProductModel.self) { e in
                print("my advs response =======> " , e)
                switch e.result {
                case let .success(data):
                    print(data.data?.data)
                    if let data = data.data?.data {
                        self.products.append(contentsOf: data)
                    }
                    
                    if let lastPage = data.data?.lastPage {
                        self.lastPage = lastPage
                    }
                    print("My advs Data  =======> ",self.products)
                    DispatchQueue.main.async {
                        self.lst.reloadData()
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        
        
    }
    
}
extension OtherUserProductVC :UICollectionViewDelegate,UICollectionViewDataSource {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
//        guard let count = products.count else{return Int()}
//        print(count)
        return products.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let inx = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherUserProductCell", for: indexPath) as! OtherUserProductCell
            cell.configure(data: products[inx])
            cell.flipX()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: lst.frame.width / 2 - 20, height: 170)
    }
    
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let inx = indexPath.row
        if let prodId = products[inx].id {
//            order.product_id = "\(prodId)"
//            goNav("prodv","Prods")
        }
       
    }
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      //  guard let count = products.data?.data?.count else{return}
        if indexPath.item == products.count - 1 {
                
                print(" ------------ fetch  More Data ---------")
            if page < lastPage  && indexPath.row == products.count - 1{
                    page += 1
                    DispatchQueue.main.async {
                        self.get(page: self.page)
                    }
                    
                    
                }
                
            }
        }
    
}
