//
//  HomeViewController.swift
//  Monasba
//
//  Created by Amal Elgalant on 25/04/2023.
//

import UIKit
import MOLH
import RAMAnimatedTabBarController

class HomeViewController: UIViewController {
    @IBOutlet weak var mainCategoryCollectionView: UICollectionView!
    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var typeView: UIView!
    
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var gridBtn: UIButton!
    var coountryVC = CounriesViewController()
    var countryId = Constants.countryId
    var countryName = "Kuwait".localize
    var categoryId = -1
    var subcategoryId = -1
    var page = 1
    var isTheLast = false
    var sell:Int?
    var sorting = "newest"
    var cityName = "choose city"
    var cityId = -1
    var isList = true
    var products = [Product]()
    var categories = [Category]()
    var subCategories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Home".localize
//        self.navigationController?.navigationBar.barStyle = .default
//       n
//        self.navigationController?.navigationBar.isTranslucent = false
        let customNavBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0) + 60))
            customNavBar.backgroundColor = UIColor(named: "#0EBFB1")
        customNavBar.cornerRadius = 30
        // Set your desired background color
            view.addSubview(customNavBar)
//
            // Adjust the top constraint of your main content to align with the bottom of the custom navigation bar
//            if let topConstraint = view.constraints.first(where: { $0.firstAttribute == .top }) {
//                topConstraint.constant = 80
//            }
        NotificationCenter.default.addObserver(self, selector: #selector(self.chooseCategory(_:)), name: NSNotification.Name(rawValue: "chooseCategory"), object: nil)

        subCategoryCollectionView.semanticContentAttribute = .forceLeftToRight
        mainCategoryCollectionView.semanticContentAttribute = .forceLeftToRight
        getData()
//        didChangeCountry()
        getCategory()
        createAddAdvsButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        if categoryId == 1 {
            sell = nil
            typeLbl.text = "All".localize
            self.typeView.isHidden = false
        }else{
            self.typeView.isHidden = true
            
        }
//        if AppDelegate.currentUser.id == nil{
//            basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
//
//        }
    }
    
    
   
    //MARK: Methods
    
//    func didChangeCountry(){
//        let changeCountryVC = ChangeCountryVC()
//        changeCountryVC.countryBtclosure = {
//            (country) in
//
//            self.countryName = MOLHLanguage.currentAppleLanguage() == "en" ? (country.nameEn ?? "") : (country.nameAr ?? "")
//            self.countryId = country.id ?? 6
//            self.cityId = -1
//
//            self.resetProducts()
//            self.getData()
//        }
  //  }
    
    func createCustomNavBar(){
        self.navigationController?.navigationBar.isHidden = true  // Hide the default navigation bar
            
            // Create a custom navigation bar
            let customNavBarHeight: CGFloat = 80  // Set your desired height
            let customNavBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: customNavBarHeight))
            customNavBar.backgroundColor = UIColor(named: "#0EBFB1")  // Set your desired background color
            
            let navigationItem = UINavigationItem(title: "Home".localize)  // Set the title
            
            // Create and set the left bar button items with images and text
            let leftImage1 = UIImage(named: "addAdvsImage")
        let leftBarButtonItem1 = UIBarButtonItem( image: leftImage1?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem1Tapped))
            navigationItem.leftBarButtonItems = [leftBarButtonItem1]
            
            // Create and set the right bar button items with images and text
            let rightImage1 = UIImage(named: "square")
        let rightBarButtonItem1 = UIBarButtonItem( image: rightImage1?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightBarButtonItem1Tapped))
            navigationItem.rightBarButtonItems = [rightBarButtonItem1]
            
            customNavBar.items = [navigationItem]
            
            view.addSubview(customNavBar)
            
            // Adjust the top constraint of your main content to align with the bottom of the custom navigation bar
            if let topConstraint = view.constraints.first(where: { $0.firstAttribute == .top }) {
                topConstraint.constant = customNavBarHeight
            }
    }
    @objc func leftBarButtonItem1Tapped() {
        // Handle left bar button item 1 tap
        print("Handle left bar button item 1 tap")
    }

    @objc func rightBarButtonItem1Tapped() {
        // Handle right bar button item 1 tap
        print("Handle right bar button item 1 tap")
    }
    
    func createAddAdvsButton(){
        let leftView = UIView()
        //view.backgroundColor = .black
        let leftButton = UIButton(type: .system)
        leftButton.setImage(UIImage(named: "addAdvsImage")?.withRenderingMode(.alwaysOriginal), for: .normal)
        leftButton.setTitle("Add Ad".localize, for: .normal)
        leftButton.addTarget(self, action: #selector(addAdvsBtnAction), for: .touchUpInside)
        leftButton.sizeToFit()
        leftView.addSubview(leftButton)
        leftView.frame = leftButton.bounds
        leftButton.semanticContentAttribute = .forceLeftToRight
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        let rightView = UIView()
        //view.backgroundColor = .black
        let rightButton = UIButton(type: .system)
        rightButton.semanticContentAttribute = .forceRightToLeft
        rightButton.setImage(UIImage(named: "square")?.withRenderingMode(.alwaysOriginal), for: .normal)
        rightButton.setTitle("Categories".localize, for: .normal)
        rightButton.addTarget(self, action: #selector(categoryBtnAction), for: .touchUpInside)
        rightButton.sizeToFit()
        rightView.addSubview(rightButton)
        rightView.frame = rightButton.bounds
        rightButton.semanticContentAttribute = .forceLeftToRight
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
    }
    
    @objc func addAdvsBtnAction(){
        if StaticFunctions.isLogin() {
            let vc = UIStoryboard(name: ADVS_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: ADDADVS_VCID) as! AddAdvsVC
            vc.modalPresentationStyle = .fullScreen
//            presentDetail(vc)
            navigationController?.pushViewController(vc, animated: true)
        }else{
            StaticFunctions.createErrorAlert(msg: "Please Login First To Can Uplaod ads!".localize)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
            }
        }
        
      
    }
    
    @objc func categoryBtnAction(){
        basicNavigation(storyName: CATEGORRY_STORYBOARD, segueId: CATEGORIES_VCID)
    }
    
    @objc func chooseCategory(_ notification: NSNotification) {
        let categoryIndex = notification.userInfo?["cat_index"] as! Int
        let subcategoryIndex = notification.userInfo?["sub_cat_index"] as! Int
        subCategories = notification.userInfo?["subCategories"] as! [Category]
        categoryId = categories[categoryIndex].id ?? 0
        subcategoryId = subCategories[subcategoryIndex].id ?? 0
        self.subCategories.insert(Category(nameAr: "الكل", nameEn: "All",id: -1, hasSubCat: 0), at: 0)

        mainCategoryCollectionView.selectItem(at: [0, categoryIndex+1], animated: true, scrollPosition: .centeredHorizontally)
        self.subCategoryCollectionView.isHidden = false
        self.subCategoryCollectionView.reloadData()
        subCategoryCollectionView.selectItem(at: [0, subcategoryIndex+1], animated: true, scrollPosition: .centeredHorizontally)
            // do something with your image
        
    }
    
    //MARK: IBActions
    
    @IBAction func filterAction(_ sender: Any) {
        let vc = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: CITY_VCIID) as!  CityViewController
        vc.countryId = countryId
        vc.cityId = cityId
        vc.cityName = cityName
        vc.cityBtclosure = {
            (value, name) in
            self.cityId = value
            self.resetProducts()
            self.getData()
        }
        self.present(vc, animated: false, completion: nil)
        
        
    }
    
    @IBAction func cateegoriesAction(_ sender: Any) {
        basicNavigation(storyName: CATEGORRY_STORYBOARD, segueId: CATEGORIES_VCID)
    }
    @IBAction func sortActioon(_ sender: Any) {
        let vc = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: SORT_VCID) as!  SortViewController
        vc.type = self.sorting
        vc.sortBtclosure = {
            (value) in
            self.sorting = value
            self.resetProducts()
            self.getData()
        }
        self.present(vc, animated: false, completion: nil)
    }
    @IBAction func typeActiion(_ sender: Any) {
        let vc = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: TYPE_VCID) as!  TypeViewController
        vc.typeBtclosure = {
            (value, name) in
            self.sell = value
            self.typeLbl.text = name
            self.resetProducts()
            self.getData()
        }
        self.present(vc, animated: false, completion: nil)
        
    }
    @IBAction func countryAction(_ sender: Any) {

        coountryVC = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: COUNTRY_VCIID) as!  CounriesViewController
        coountryVC.countryBtclosure = {
            (country) in
           
            self.countryLbl.text = MOLHLanguage.currentAppleLanguage() == "en" ? (country.nameEn ?? "") : (country.nameAr ?? "")
            self.countryId = country.id ?? 6
            self.cityId = -1

            self.resetProducts()
            self.getData()
        }
        self.present(coountryVC, animated: false, completion: nil)
    }
    @IBAction func goLogin(_ sender: Any) {
//        basicPresentation(storyName: Auth_STORYBOARD, segueId: "login_nav")
    }
    @IBAction func gridAction(_ sender: Any) {
        isList = false
        gridBtn.tintColor = UIColor(named: "#0EBFB1")
        listBtn.tintColor = UIColor(named: "#929292")
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
    @IBAction func categoriesAction(_ sender: Any) {
        
    }
    @IBAction func ListAction(_ sender: Any) {
        isList = true
        listBtn.tintColor = UIColor(named: "#0EBFB1")
        gridBtn.tintColor = UIColor(named: "#929292")
        DispatchQueue.main.async {
            self.productCollectionView.reloadData()
        }
    }
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
    
    func getCategory(){
        CategoryController.shared.getCategoories(completion: {
            categories, check, msg in
            
            self.categories = categories
            self.categories.insert(Category(nameAr: "الكل", nameEn: "All",id: -1, hasSubCat: 0), at: 0)
            self.mainCategoryCollectionView.reloadData()
            self.mainCategoryCollectionView.selectItem(at: [0,0], animated: false, scrollPosition: .centeredHorizontally)
            
        })
    }
    func getSubCategory(){
        CategoryController.shared.getSubCategories(completion: {
            categories, check, msg in
            self.subCategories.removeAll()
            
            self.subCategories = categories
            self.subCategories.insert(Category(nameAr: "الكل", nameEn: "All",id: -1, hasSubCat: 0), at: 0)
            
            if categories.count > 0 {
                self.subCategoryCollectionView.isHidden = false
            }else{
                self.subCategoryCollectionView.isHidden = true
                
            }
            
            self.subCategoryCollectionView.reloadData()
            self.subCategoryCollectionView.selectItem(at: [0,0], animated: false, scrollPosition: .centeredHorizontally)
            
        }, categoryId: self.categoryId)
    }
    func resetProducts(){
        self.page = 1
        self.isTheLast = false
        //        self.products.removeAll()
    }
    
}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productCollectionView{
            return products.count
        }else if collectionView == mainCategoryCollectionView{
            return categories.count-1
        }
        return subCategories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productCollectionView{
            
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
        }else if collectionView == mainCategoryCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cat-cell", for: indexPath) as! MainCategoryCollectionViewCell
            cell.setData(category: categories[indexPath.row])
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sub-cell", for: indexPath) as! SubCategoryCollectionViewCell
            cell.setData(category: subCategories[indexPath.row])
            return cell
        }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productCollectionView{
            let vc = UIStoryboard(name: PRODUCT_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: PRODUCT_VCID) as! ProductViewController
            vc.modalPresentationStyle = .fullScreen
            vc.product = products[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
//            presentDetail(vc)
        }
        else if collectionView == mainCategoryCollectionView{
            self.subcategoryId = -1
            self.categoryId = categories[indexPath.row].id ?? 0
            if categories[indexPath.row].hasSubCat == 1{
                getSubCategory()
            }else{
                //                subCategories.removeAll()
                subCategoryCollectionView.isHidden = true
            }
            if categoryId == 1 {
                sell = nil
                typeLbl.text = "All".localize
                self.typeView.isHidden = false
            }else{
                self.typeView.isHidden = true
                
            }
            self.resetProducts()
            self.getData()
            
        }
        else if collectionView == subCategoryCollectionView{
            self.subcategoryId = subCategories[indexPath.row].id ?? 0
            self.resetProducts()
            self.getData()
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (products.count-1) && !isTheLast{
            page+=1
            getData()
            
        }
    }
}
class RTLCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return  MOLHLanguage.currentAppleLanguage() == "en" ? false: true
    }
    
    override var developmentLayoutDirection: UIUserInterfaceLayoutDirection {
        return MOLHLanguage.currentAppleLanguage() == "en" ? UIUserInterfaceLayoutDirection.leftToRight: UIUserInterfaceLayoutDirection.rightToLeft
    }
}
