//
//  Product.swift
//  Monasba
//
//  Created by Amal Elgalant on 25/04/2023.
//

import Foundation


struct ProductArray: Codable{
    var data: [Product]!
    var code: Int!
    var msg: String!
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case code = "statusCode"
        case msg = "message"
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
    var type: String?
    var userName: String?
    var userLastName: String?
    var userPic: String?
    var userVerified: Int?
    
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
        
        
        
    }
}
