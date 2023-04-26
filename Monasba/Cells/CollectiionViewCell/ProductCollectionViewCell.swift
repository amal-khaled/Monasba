////
////  ProductCollectionViewCell.swift
////  Monasba
////
////  Created by Amal Elgalant on 25/04/2023.
////
//
//import UIKit
//
//class ProductCollectionViewCell: UICollectionViewCell {
//    
//    
//    
//    
//    @IBOutlet weak var nameLbl: UILabel!
//    @IBOutlet weak var priceLbl: UILabel!
//    @IBOutlet weak var currencuLbl: UILabel!
//
//    
//    
//    
//
//    @IBOutlet weak var listStackViewContainer: UIStackView!
//    
//    @IBOutlet weak var listViewContsiner: UIView!
//    @IBOutlet weak var videoIcone: UIImageView!
//    @IBOutlet weak var subscribeImage: UIImageView!
//    @IBOutlet weak var sellView: UIView!
//    @IBOutlet weak var timeLbl: UILabel!
//    @IBOutlet weak var ownerName: UILabel!
//    @IBOutlet weak var cityLbl: UILabel!
//    @IBOutlet weak var sellLbl: UILabel!
//    
//    @IBOutlet weak var timeLabelList: UILabel!
//    @IBOutlet weak var imageView: UIImageView!
//    
//    @IBOutlet weak var gridTimeLabel: UILabel!
//    
//    func setData(product: Product, isList:Bool){
//     
//        nameLbl.text = product.name
//        priceLbl.text = product.price
//        
//        
//        
////        guard let createdDate = product.created_at, let local = product.loc  else {return}
////        cityLbl.text = product.loc?.components(separatedBy: "-")[0]
//       
//        if let loc = product.citiesNameAr {
//            cityLbl.text = loc
//        }
//        
//        if let userName = product.userName , let lastName = product.userLastName  {
//            ownerName.text = "\(userName) \(lastName)"
//        }else{
//            ownerName.text = " "
//        }
//   
//        if let tajeerOrSell = product.tajeerOrSell  {
//            
//            if( tajeerOrSell == 1){
//                sellLbl.text = "تأجير"
//                sellLbl.textColor = .black
//                sellView.layer.borderWidth = 1.0
//                sellView.layer.borderColor = UIColor.black.cgColor
//                sellView.clipsToBounds = true
//                sellView.backgroundColor = .white
//            }else{
//                sellLbl.text = "بيع"
//                sellView.layer.borderWidth = 1.0
//                sellView.layer.borderColor = colors.main.cgColor
//                sellView.clipsToBounds = true
//                sellLbl.textColor = .white
//                sellView.backgroundColor = colors.main
//            }
//            
//            
//           
//        }
//        if let image = product.img , let prodImage = product.prodImage {
//            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
//            if image != "" {
//                guard let url = URL(string: "\(user.newUrl)\(image)")else{return}
//                if image.contains(".mp4")  || image.contains(".mov") {
//                  //  imageView.videoUrl = image
//                   
//                    imageView.sd_setImage(with: url)
//                    
//                    videoIcone.showMe()
//                }else{
//                    imageView.sd_setImage(with: url)
////                    imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "logo_green"))
//                    
////                    imageView.imgUrl = image
//                    //                ?? "uploads/temp/1595447115_80f6957f3b12b6d9b61ba3d75c050bd3.jpg"
//                    videoIcone.hideMe()
//                }
//            }else {
//                guard let url = URL(string: "\(user.newUrl)\(prodImage)")else{return}
//                if prodImage.contains(".mp4")  || prodImage.contains(".mov") {
////                    imageView.videoUrl = prodImage
//                    imageView.sd_setImage(with: url)
//                    videoIcone.showMe()
//                }else{
////                    imageView.imgUrl = prodImage
//                    imageView.sd_setImage(with: url)
//                    videoIcone.hideMe()
//                }
//            }
//            
//        }
//        
//        if let userVerified  = product.userVerified
//        {
//            switch userVerified {
//                
//            case .integer( let userVerfied):
//                if   userVerfied == 1 {
//                    subscribeImage.isHidden = false
//                }else{
//                    subscribeImage.isHidden = true
//                }
//            case .string(_):
//                subscribeImage.isHidden = true
//            }
//
//        }
//        
//        
//    }
//}
