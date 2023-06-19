//
//  FavouritesVC.swift
//  Monasba
//
//  Created by iOSayed on 19/06/2023.
//

import Foundation

import UIKit
import Alamofire

class FavouritesVC: UIViewController {
    var data = [FavProdData]()
    
    @IBOutlet weak var lst: UICollectionView!
    
    @IBOutlet weak var emptyView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden = true
        
        lst.backgroundColor = UIColor.clear.withAlphaComponent(0)
        lst.register(FavouritesCollectionViewCell.self, forCellWithReuseIdentifier: "FavouritesCollectionViewCell")
        lst.configure(top:15, bottom:100, left: 15, right: 15,hspace:15)
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        get()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationItem.backBarButtonItem?.tintColor = .white
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        
    }
   
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    func clear_all(){
        data.removeAll()
        lst.reloadData()
    }
    
    
    func get(){
        clear_all()
        let params : [String: Any]  = ["uid":AppDelegate.currentUser.id ?? 0]
        guard let url = URL(string: Constants.DOMAIN+"fav_by_user") else{return}
        print(params)
        AF.request(url, method: .post, parameters: params)
            .responseDecodable(of: FavouriteProductModel.self) { e in
               print(e)
                switch e.result {
                case let .success(data):
                    guard let favProd = data.data?.data else {return}
                    self.data = favProd
                    print(data)
                    DispatchQueue.main.async {
                        self.lst.reloadData()
                        if favProd.count != 0 {
                            self.emptyView.isHidden = true
                        }else{
                            self.emptyView.isHidden = false
                        }
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                    self.emptyView.isHidden = false

                }
            }
    }
   
    
}
extension FavouritesVC:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
       return data.count
   }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let inx = indexPath.row
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouritesCollectionViewCell", for: indexPath) as? FavouritesCollectionViewCell else{return UICollectionViewCell()}
       cell.configure(data: data[inx])
      //  cell.titleText.text = "dsdsdsdsdddsdsddd"
//       cell.removeFromFavButton.tag = inx
//       cell.removeFromFavButton.addTarget(self, action: #selector(removeFromFavs), for: .touchUpInside)
       return cell
   }
   
   @objc func removeFromFavs(_ sender:UIButton){
       print(sender.tag)
       if let prodId = data[sender.tag].id {
           let params : [String: Any]  = ["prod_id":prodId]
           guard let url = URL(string: Constants.DOMAIN+"fav_prod") else {return}
           print(params, url)
           print(Constants.headerProd)
           AF.request(url , method: .post,parameters: params, headers:Constants.headerProd)
               .responseDecodable(of: SuccessModel.self) { res in
                   print(res.value)
                   switch res.result {
                       
                   case .success( _):
                       self.get()
                   case .failure(let error):
                       StaticFunctions.createErrorAlert(msg: "the data you entered does not match our data".localize)
                       print(error.localizedDescription)
                   }
                   
               }
           
       }
   }
   
   func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: lst.frame.width - 30, height: 120)
   }
   
   
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let inx = indexPath.row
       guard let prodId = data[inx].id else {return}
//        order.product_id = "\(prodId)"
         let vc = UIStoryboard(name: PRODUCT_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: PRODUCT_VCID) as! ProductViewController
         vc.modalPresentationStyle = .fullScreen
         vc.product.id = prodId
         self.navigationController?.pushViewController(vc, animated: true)
//        goNav("prodv","Prods")
   }
}
