//
//  CategoryViewController.swift
//  Monasba
//
//  Created by Amal Elgalant on 03/05/2023.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var sideCategoyCollectionView: UICollectionView!
    @IBOutlet weak var listMainCategory: UICollectionView!
    
    var categories = [Category]()
    var sideCatgeory = [Category]()
    var categoryIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategory()
        sideCategoyCollectionView.semanticContentAttribute = .forceLeftToRight
        // Do any additional setup after loading the view.
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
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == listMainCategory{
            return categories.count
        }else{
            return sideCatgeory.count
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == listMainCategory{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCell", for: indexPath) as! mainSideCategoryCollectionViewCell
            cell.setData(category: categories[indexPath.row])
            
            
//            if indexPath.row == categories.count - 1{
//                cell.cImageView.image = UIImage(named: "askImage")
//            }
            //}
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatSideCell", for: indexPath) as! SideCategoryCollectionViewCell
            cell.setData(category: sideCatgeory[indexPath.row])
            
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == listMainCategory{
            return CGSize(width: 110, height: 82)
        }else {
            //            if get_cats{
            return CGSize(width: collectionView.frame.width/2 - 11, height: 130)
            //            }else{
            //                print(collectionView.frame.width/2 - 11)
            //                return CGSize(width: collectionView.frame.width/2 - 11, height: 80)
            //            }
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       if collectionView == listMainCategory{

           self.categoryIndex = indexPath.row
           self.getSubCategory()
         
       }else{
           NotificationCenter.default.post(name: NSNotification.Name(rawValue:"chooseCategory"), object: nil, userInfo: ["cat_index": categoryIndex, "sub_cat_index": indexPath.row, "subCategories": sideCatgeory])
           self.navigationController?.popViewController(animated: true)
          

       }
   }
}
extension CategoryViewController{
    func getCategory(){
        CategoryController.shared.getCategoories(completion: {
            categories, check, msg in
            
            self.categories = categories
            if self.categories.count > 0{
                self.categoryIndex = 0
                self.getSubCategory()
            }
            self.listMainCategory.reloadData()

            self.listMainCategory.selectItem(at: [0,0], animated: false, scrollPosition: .centeredVertically)

            
        })
    }
    func getSubCategory(){
        CategoryController.shared.getSubCategories(completion: {
            categories, check, msg in
            self.sideCatgeory.removeAll()
            
            self.sideCatgeory = categories
            
            if categories.count > 0 {
                self.sideCategoyCollectionView.isHidden = false
            }else{
                self.sideCategoyCollectionView.isHidden = true
                
            }
            
            self.sideCategoyCollectionView.reloadData()
            
            
        }, categoryId: self.categories[categoryIndex].id ?? 0)
    }
}
