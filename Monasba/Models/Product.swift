//
//  Product.swift
//  Monasba
//
//  Created by Amal Elgalant on 25/04/2023.
//

import Foundation


struct ProductArrayPaging: Codable{
    var data: ProductArray!
    var code: Int!
    var msg: String!
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case code = "statusCode"
        case msg = "message"
    }
    
    
}
struct ProductArray: Codable{
    var data: [Product]!
   
    enum CodingKeys: String, CodingKey {
        case data = "data"
       
    }
    
    
}
struct ProductObject: Codable{
    var data: Product!
    var code: Int!
    var msg: String!
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case code = "statusCode"
        case msg = "message"
    }
    
    
}



struct Product: Codable{
    var id: Int?
    var name: String?
    var price: Int?
    var location: String?
    var image : String?
    var type: Int?
    var userName: String?
    var userLastName: String?
    var userPic: String?
    var userVerified: Int?
    var countryNameAr: String?
    var countryNameEn: String?
    var currencyAr: String?
    var currencyEn: String?
    var cityNameAr: String?
    var cityNameEn: String?
    let createdAt: String?

   
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case price = "price"
        case location = "loc"
        case image = "prods_image"
        case type = "tajeer_or_sell"
        case userName = "user_name"
        case userLastName = "user_last_name"
        case userPic = "user_pic"
        case userVerified = "user_verified"
        case countryNameAr = "countries_name_ar"
        case countryNameEn = "countries_name_en"
        case currencyAr = "countries_currency_ar"
        case currencyEn = "countries_currency_en"
        case cityNameAr = "cities_name_ar"
        case cityNameEn = "cities_name_en"
        case createdAt = "created_at"

        
        
    }
}
