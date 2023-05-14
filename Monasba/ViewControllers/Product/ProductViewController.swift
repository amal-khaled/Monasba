//
//  ProductViewController.swift
//  Monasba
//
//  Created by Amal Elgalant on 05/05/2023.
//

import UIKit
//import ImageSlideshow
import MOLH
import MediaSlideshow

class ProductViewController: UIViewController {
    
    @IBOutlet weak var callLbl: UILabel!
    @IBOutlet weak var chatBtn: UIView!
    @IBOutlet weak var whatsappBtn: UIView!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var reportView: UIStackView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentsCountLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var selLbl: UILabel!
    @IBOutlet weak var sellImage: UIView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var nameBtn: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var imageSlider: MediaSlideshow!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userVerifieddImage: UIImageView!
    
    var product = Product()
    var images = [ProductImage]()
    var sliderImages = [String]()
    var comments = [Comment]()

    var isFav = false
    
    var tableHeight: CGFloat {
        tableView.layoutIfNeeded()

        return tableView.contentSize.height
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        getData()
        setupSlider()
    }
//    override func (_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = false
//
//    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func userClickedAction(_ sender: Any) {
    }
    @IBAction func backAction(_ sender: Any) {

        navigationController?.popViewController(animated: true)
    }
    @IBAction func addToFavAction(_ sender: Any) {

    }
    @IBAction func shareAction(_ sender: Any) {

    }
    @IBAction func callAction(_ sender: Any) {

    }
    @IBAction func whatsappAction(_ sender: Any) {

    }
    @IBAction func chatActoin(_ sender: Any) {

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
extension ProductViewController{
    func getData(){
        ProductController.shared.getProducts(completion: {
            product, check, msg in
            
            if check == 0{
                self.product = product.data
                self.images = product.images
                self.comments = product.comments
                self.tableView.reloadData()
                self.tableViewHeight.constant = self.tableHeight
//                self.tableView.layoutIfNeeded()
                self.setData()
            }else{
                StaticFunctions.createErrorAlert(msg: msg)
                self.navigationController?.popViewController(animated: true)
            }
            
        }, id: product.id ?? 0)
    }
    
    func setData(){
        print(product.name)

        if let mainImage = product.image{
            if mainImage != ""{
                if mainImage.contains(".mp4") || mainImage.contains(".mov"){
                    images.insert(ProductImage(id: -1, prodID: 0, pimage: mainImage, imageType: "VIDEO", createdAt: "", updatedAt: "", image: Constants.IMAGE_URL + mainImage), at: 0)
                }else{
                    images.insert(ProductImage(id: -1, prodID: 0, pimage: mainImage, imageType: "IMAGE", createdAt: "", updatedAt: "", image: Constants.IMAGE_URL + mainImage), at: 0)
                }
                
            }
        }
        let dataSource = ImageAndVideoSlideshowDataSource(sources:[
            

        ])

        for img in images{
            print("imgs count ",images.count)
            if let image = img.image  {
                print(image)
                guard let media_type = img.imageType  else {return}
                // prodC.sources_urls.append("\(user.newUrl)\(timg)")
                sliderImages.append(image)
                if media_type == "VIDEO"{
                    
                    if image != "" {
                        dataSource.sources.append(
                            
                            .av(AVSource(url: URL(string:image)!, autoplay: true)))
                    }
                }else{
                    if image != "" {
                        
                        dataSource.sources.append(
                            .image(AlamofireSource(urlString:image )!))
                    }
                    
                }
            }}
            
                imageSlider.dataSource = dataSource
                imageSlider.reloadData()
        
        self.nameBtn.text = product.name
        if let createDate = product.createdAt{
            if createDate.count > 11 {
                self.dateLbl.text =  "\(createDate[11..<16])"

            }
        }
        if  MOLHLanguage.currentAppleLanguage() == "en" {
            currencyLbl.text = product.currencyEn
            locationLbl.text = product.cityNameEn

        }else{
            currencyLbl.text = product.currencyAr
            locationLbl.text = product.cityNameAr

        }
        self.descriptionLbl.text = product.description
        self.descriptionLbl.sizeToFit()
        if product.userVerified == 1{
            userVerifieddImage.isHidden = false
        }else{
            userVerifieddImage.isHidden = true
        }

        if let tajeerOrSell = product.type  {

            if( tajeerOrSell == 1){
                selLbl.text = "rent"
                selLbl.textColor = .black
                sellImage.layer.borderWidth = 1.0
                sellImage.layer.borderColor = UIColor.black.cgColor
                sellImage.clipsToBounds = true
                sellImage.backgroundColor = .white
            }else{
                selLbl.text = "sell"
                sellImage.layer.borderWidth = 1.0
                sellImage.layer.borderColor = UIColor(named: "#0EBFB1")?.cgColor
                sellImage.clipsToBounds = true
                selLbl.textColor = .white
                sellImage.backgroundColor = UIColor(named: "#0EBFB1")
            }
        }
        if product.fav == 1 {
            self.favBtn.setImage(UIImage(named: "heartFill"), for: .normal)
            isFav = true
        }else{
            self.isFav = false
            self.favBtn.setImage(UIImage(named: ""), for: .normal)

        }

        userNameLbl.text = (product.userName ?? "") + " " + (product.userLastName ?? "")

        self.userImageView.setImageWithLoading(url: product.userPic ?? "users/1675802939.png")


        if   product.userVerified == 1 {
            self.userVerifieddImage.isHidden = false
        }else{
            self.userVerifieddImage.isHidden = true
        }
        if( product.hasPhone == "on"){
            callBtn.isHidden = false
            callLbl.isHidden = true
        }else{
            callBtn.isHidden = true
            callLbl.isHidden = false
        }

        if( product.hasWhatsapp == "on"){
            whatsappBtn.isHidden = false
        }else{
            whatsappBtn.isHidden = true

        }

        if(product.hasChat == "on"){
            if AppDelegate.currentUser.id != (product.userId ?? 0){
                chatBtn.isHidden = false
            }

        }else{
            chatBtn.isHidden = true
        }


        self.priceLbl.text = "\(product.price ?? 0)"
        
        
    }
    func setupSlider(){
        imageSlider.activityIndicator = DefaultActivityIndicator()
        imageSlider.contentScaleMode = .scaleToFill
        imageSlider.slideshowInterval = 2
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        imageSlider.addGestureRecognizer(gestureRecognizer)
    }
    @objc func didTap() {
        imageSlider.presentFullScreenController(from: self)

    }
}
extension ProductViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductCommentTableViewCell
        cell.setData(comment: comments[indexPath.row])
        return cell
    }
}
