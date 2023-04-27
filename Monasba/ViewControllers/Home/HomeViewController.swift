//
//  HomeViewController.swift
//  Monasba
//
//  Created by Amal Elgalant on 25/04/2023.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var mainCategoryCollectionView: UICollectionView!
    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var gridBtn: UIButton!
    var countryId = 6
    var categoryId = -1
    var subcategoryId = -1
    var page = 1
    var isTheLast = false
    var sell:Int?
    var sorting = "newest"
    var cityId = -1
    var isList = true
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func filterAction(_ sender: Any) {
    }
    
    @IBAction func sortActioon(_ sender: Any) {
    }
    @IBAction func typeActiion(_ sender: Any) {
    }
    @IBAction func countryAction(_ sender: Any) {
    }
    @IBAction func gridAction(_ sender: Any) {
        isList = false
        gridBtn.tintColor = UIColor(named: "#0EBFB1")
        listBtn.tintColor = UIColor(named: "#929292")
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
    @IBAction func ListAction(_ sender: Any) {
        isList = true
        listBtn.tintColor = UIColor(named: "#0EBFB1")
        gridBtn.tintColor = UIColor(named: "#929292")
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
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
extension HomeViewController{
    func getData(){
        ProductController.shared.getHomeProducts(completion: {
            products, check, msg in
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
                self.productCollectionView.reloadData()
            }else{
                StaticFunctions.createErrorAlert(msg: msg)
                self.page = self.page == 1 ? 1 : self.page - 1
            }
        }, page: page, countryId: countryId, cityId: cityId, categoryId: categoryId, subCategoryId: subcategoryId, type: 1, sorting: sorting, sell: sell)
    }
}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: ProductCollectionViewCell
        if isList{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-tableview", for: indexPath) as! ProductCollectionViewCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-grid", for: indexPath) as! ProductCollectionViewCell
        }
        cell.setData(product: products[indexPath.row])
        if (indexPath.row % 2) == 0 {
            cell.backView.backgroundColor = UIColor(hexString: "#F4F8FF", alpha: 1)
            cell.backView.backgroundColor = UIColor(hexString: "#F4F8FF", alpha: 1)
        }else{
            cell.backView.backgroundColor = .white
            cell.backView.backgroundColor = .white
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productCollectionView{
            if isList{
                return CGSize(width: UIScreen.main.bounds.width-10, height: (collectionView.bounds.height-40)/4)
            }else{
                print((UIScreen.main.bounds.width/2 )-15)
                return CGSize(width: (UIScreen.main.bounds.width/2)-15, height: 280)
                
            }
        }
        else {
            return CGSize(width: 108, height: 35)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (products.count-1) && !isTheLast{
            page+=1
            getData()
        }
    }
}
