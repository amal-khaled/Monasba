//
//  MyAdsVC.swift
//  Monasba
//
//  Created by iOSayed on 24/05/2023.
//

import UIKit
import Alamofire
import FirebaseDynamicLinks
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
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationItem.backBarButtonItem?.tintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back", style: .plain, target: nil, action: nil)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func didTapBackButton(_ sender:UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: Private Methods
    
    private func ConfigureUIView(){
        navigationController?.navigationBar.tintColor = .white
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
        return myAdCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myAdsCollectionView.frame.width - 10, height: myAdsCollectionView.frame.height / 2 )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: PRODUCT_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: PRODUCT_VCID) as! ProductViewController
        vc.modalPresentationStyle = .fullScreen
        vc.product = products[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
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
        let params : [String: Any]  = ["id":products[indexPath.item].id ?? 0]
        print(params)
        guard let url = URL(string: Constants.DOMAIN+"prods_delete")else{return}
        AF.request(url, method: .post, parameters: params, encoding:URLEncoding.httpBody).responseDecodable(of:SuccessModel.self){res in
            switch res.result{
            case .success(let data):
                if let success = data.success {
                    if success {
                        StaticFunctions.createSuccessAlert(msg:"Ads Deleted Seccessfully".localize)
                        self.getProductsByUser()
                        self.myAdsCollectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func shareAdCell(buttonDidPressed indexPath: IndexPath) {
        var product = products[indexPath.row]
        guard let link = URL(string: "https://www.monsbah.com/categories/\(product.subCatId ?? 0)/products/\(product.id ?? 0)") else { return }
        let dynamicLinksDomainURIPrefix = "https://monasba.page.link"
        
        guard let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix) else { return }
                linkBuilder.androidParameters = DynamicLinkAndroidParameters(packageName: "com.app.monasba")
        
        guard let longDynamicLink = linkBuilder.url else { return }
        print(longDynamicLink)
        linkBuilder.shorten() { url, warnings, error in
            guard let url = url, error == nil else {
                
                return }
            print("The short URL is: \(url)")
            let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
           
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func editAdCell(buttonDidPressed indexPath: IndexPath) {
        // GO TO Edit View Controller
        let product =  products[indexPath.item]
        let vc = UIStoryboard(name: ADVS_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: EDITAD_VCID) as! EditAdVC
        vc.modalPresentationStyle = .fullScreen
        vc.productId = product.id ?? 0
        navigationController?.pushViewController(vc, animated: true)
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

