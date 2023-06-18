//
//  MyAdsVC.swift
//  Monasba
//
//  Created by iOSayed on 24/05/2023.
//

import UIKit

class MyAdsVC: UIViewController {

    @IBOutlet weak var myAdsCollectionView: UICollectionView!
    
    
    private  let cellIdentifier = "MyAdsCollectionViewCell"
    private var products = [Product]()
    private var page = 1
    private var isTheLast = false
            var userId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureUIView()
        getProductsByUser()
        print(userId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    @IBAction func didTapBackButton(_ sender:UIButton){
        dismissDetail()
    }
    
    
    //MARK: Private Methods
    
    private func ConfigureUIView(){
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        myAdsCollectionView.delegate = self
        myAdsCollectionView.dataSource = self
        myAdsCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }

}
//MARK: CollectionView Delegate & DataSource

extension MyAdsVC : UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myAdCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MyAdsCollectionViewCell else{return UICollectionViewCell()}
        myAdCell.delegate = self
        myAdCell.indexPath = indexPath
        myAdCell.setData(product: products[indexPath.item])
        myAdCell.userNameLabel.text = "ELSAYED AHMED"
        return myAdCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myAdsCollectionView.frame.width - 10, height: myAdsCollectionView.frame.height / 2 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: PRODUCT_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: PRODUCT_VCID) as! ProductViewController
        vc.modalPresentationStyle = .fullScreen
        vc.product = products[indexPath.row]
        presentDetail(vc)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (products.count-1) && !isTheLast{
            page+=1
            getProductsByUser()
            
        }
    }
}

//MARK: MyAdsCollectionViewCellDelegate

extension MyAdsVC:MyAdsCollectionViewCellDelegate {
    func deleteAdCell(buttonDidPressed indexPath: IndexPath) {
        //delete ad
    }
    
    func shareAdCell(buttonDidPressed indexPath: IndexPath) {
        shareContent(text:Constants.DOMAIN + "\(products[indexPath.row].id ?? 0)")
        
    }
    
    func editAdCell(buttonDidPressed indexPath: IndexPath) {
        // GO TO Edit View Controller
        let product =  products[indexPath.item]
        let vc = UIStoryboard(name: ADVS_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: EDITAD_VCID) as! EditAdVC
        vc.modalPresentationStyle = .fullScreen
        vc.product = product
        presentDetail(vc)
    }
    
    
}
extension MyAdsVC {
    private func getProductsByUser(){
//         guard let userId = AppDelegate.currentUser.id , let countryId = AppDelegate.currentUser.countryId else{return}
         
         ProfileController.shared.getProductsByUser(completion: {
             products, check, msg in
             print(products.count)
             if check == 0{
                 if self.page == 1 {
                     self.products.removeAll()
                     self.products = products
                     
                 }else{
                     self.products.append(contentsOf: products)
                 }
                 if products.isEmpty{
                     self.page = self.page == 1 ? 1 : self.page - 1
                     self.isTheLast = true
                 }
                 self.myAdsCollectionView.reloadData()
             }else{
                 StaticFunctions.createErrorAlert(msg: msg)
                 self.page = self.page == 1 ? 1 : self.page - 1
             }
             
             //use 128 as user id to check
         }, userId: userId , page: page, countryId:6 )
     }
}
