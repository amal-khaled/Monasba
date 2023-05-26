//
//  MyAdsVC.swift
//  Monasba
//
//  Created by iOSayed on 24/05/2023.
//

import UIKit

class MyAdsVC: UIViewController {

    @IBOutlet weak var myAdsCollectionView: UICollectionView!
    
    
    private  let cellIdentifier = "ProfileProductsCollectionViewCell"
    private var products = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myAdCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MyAdsCollectionViewCell else{return UICollectionViewCell()}
        myAdCell.delegate = self
        myAdCell.indexPath = indexPath
        
        return myAdCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myAdsCollectionView.frame.width - 30, height: myAdsCollectionView.frame.height / 2 )
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
        
    }
    
    
}
