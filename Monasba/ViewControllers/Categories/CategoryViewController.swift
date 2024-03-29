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
    var cities = [Country]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Categories".localize
        getCategory()
        getCities()
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
            if categoryIndex == (categories.count-1){
                return cities.count
                
            }else{
                return sideCatgeory.count
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == listMainCategory{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatCell", for: indexPath) as! mainSideCategoryCollectionViewCell
            cell.setData(category: categories[indexPath.row])
            
            
            
            
            
            return cell
        }else{
            if  categoryIndex != (categories.count-1){
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatSideCell", for: indexPath) as! SideCategoryCollectionViewCell
                cell.setData(category: sideCatgeory[indexPath.row])
                
                return cell
            }
            else{
               
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ask_cell", for: indexPath) as! AskSubCategoryCollectionViewCell
                    cell.setData(city: cities[indexPath.row])
                    
                    return cell
               
            }
            //ask_cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == listMainCategory{
            return CGSize(width: 110, height: 82)
        }else {
            if  categoryIndex != (categories.count-1){
                return CGSize(width: collectionView.frame.width/2 - 11, height: 130)
            }else{
                print(collectionView.frame.width/2 - 11)
                return CGSize(width: collectionView.frame.width/2 - 11, height: 80)
            }
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == listMainCategory{
            
            self.categoryIndex = indexPath.row
            self.getSubCategory()
            
        }else{
            if categoryIndex != (categories.count-1){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"chooseCategory"), object: nil, userInfo: ["cat_index": categoryIndex, "sub_cat_index": indexPath.row, "subCategories": sideCatgeory])
            self.navigationController?.popViewController(animated: true)
            }else{
                if StaticFunctions.isLogin(){
                let vc = UIStoryboard(name: CATEGORRY_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: ASK_CITY_VCID) as! AsksViewController
                vc.cityId = cities[indexPath.row].id ?? 46
                self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
                }
                
            }
            
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
    func getCities(){
        if AppDelegate.currentCountry.id == 5 || AppDelegate.currentCountry.id == 10{
            CountryController.shared.getCities(completion: {
                countries, check,msg in
                self.cities = countries
                
            }, countryId: AppDelegate.currentCountry.id ?? 0)
        }else{
            //asks_side
            self.cities = [ Country(nameAr: AppDelegate.currentCountry.nameAr ?? "الكويت", nameEn:  AppDelegate.currentCountry.nameEn ?? "Kuwait", id: AppDelegate.currentCountry.id  ?? 6)]
            
        }
    }
}
