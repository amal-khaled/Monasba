//
//  ProductCollectionViewCell.swift
//  Monasba
//
//  Created by Amal Elgalant on 25/04/2023.
//

import UIKit
import MOLH
import SDWebImage
class ProductCollectionViewCell: UICollectionViewCell {
    
    
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var currencuLbl: UILabel!
    
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var sellView: UIView!
    
    //    @IBOutlet weak var listStackViewContainer: UIStackView!
    //
    //    @IBOutlet weak var listViewContsiner: UIView!
    @IBOutlet weak var videoIcone: UIImageView!
    @IBOutlet weak var subscribeImage: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var sellLbl: UILabel!
    
    //    @IBOutlet weak var timeLabelList: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //    @IBOutlet weak var gridTimeLabel: UILabel!
    
    func setData(product: Product){
        
        nameLbl.text = product.name
        priceLbl.text = "\(product.price ?? 0)"
        
        if  MOLHLanguage.currentAppleLanguage() == "en" {
            currencuLbl.text = product.currencyEn
            cityLbl.text = product.cityNameEn
            
        }else{
            currencuLbl.text = product.currencyAr
            cityLbl.text = product.cityNameAr
            
        }
        
        
        
        
        
        
        ownerName.text = "\(product.userName ?? "") \(product.userLastName ?? "")"
        
        
        if product.userVerified == 1{
            subscribeImage.isHidden = false
        }else{
            subscribeImage.isHidden = true
        }
        
        if let tajeerOrSell = product.type  {
            
            if( tajeerOrSell == 1){
                sellLbl.text = "rent"
                sellLbl.textColor = .black
                sellView.layer.borderWidth = 1.0
                sellView.layer.borderColor = UIColor.black.cgColor
                sellView.clipsToBounds = true
                sellView.backgroundColor = .white
            }else{
                sellLbl.text = "sell"
                sellView.layer.borderWidth = 1.0
                sellView.layer.borderColor = UIColor(named: "#0EBFB1")?.cgColor
                sellView.clipsToBounds = true
                sellLbl.textColor = .white
                sellView.backgroundColor = UIColor(named: "#0EBFB1")
            }
            
            
            
        }
        if let createDate = product.createdAt{
            if createDate.count > 11 {
                self.timeLbl.text =  "\(createDate[11..<16])"
                
            }
        }
        var imageLink = Constants.IMAGE_URL +  (product.image ?? "")
        imageView.setImageWithLoading(url: imageLink )
        if imageLink.contains(".mp4")  || imageLink.contains(".mov") {
            videoIcone.isHidden = false
        }else{
            videoIcone.isHidden = true
            
        }
        
        
        
        
        
    }
}
extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}

extension UIView{
    
    func diffDates(_ dateRangeEnd:Date) -> String {
        let dateRangeStart = Date()
        return dateDiff(dateRangeStart, dateRangeEnd)
    }
    func GetDateFromString(_ DateStr: String)-> Date
    {
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let DateArray = DateStr.components(separatedBy: " ")
        let part1 = DateArray[0].components(separatedBy: "-")
        let part2 = DateArray[1].components(separatedBy: ":")
        let components = NSDateComponents()
        components.year = Int(part1[0])!
        components.month = Int(part1[1])!
        components.day = Int(part1[2])!
        components.hour = Int(part2[0])!
        components.minute = Int(part2[1])!
        components.second = Int(part2[2].components(separatedBy: ".")[0])!
        components.timeZone = TimeZone(abbreviation: "UTC")
        let date = calendar?.date(from: components as DateComponents)
        
        return date!
    }
    func dateDiff(_ dateRangeStart:Date , _ dateRangeEnd:Date) -> String {
        var result = ""
        let components = Calendar.current.dateComponents([.month,.day,.hour, .weekday,.minute,.second], from: dateRangeStart, to: dateRangeEnd)
        // print("diffrent  time  ======> ",components)
        
        if let months = components.month , let days = components.day, let hours  = components.hour , let minutes = components.minute , let seconds = components.second , let weeks = components.weekday{
            if( months != 0){
                print(months)
                result = "\(months) mon"
            }else if(weeks != 0){
                print(weeks)
                result = "\(weeks) week"
            }
            else if(days != 0){
            
                result = "\(days ) day"
              
            }else if(hours != 0){
                print(hours)
                result = "\(hours) h"
            }else if(minutes != 0){
                print(minutes)
                result = "\(minutes) min"
            }else{
                print(seconds)
                result = "\(seconds) sec"
            }
        }
        return result
    }
}
