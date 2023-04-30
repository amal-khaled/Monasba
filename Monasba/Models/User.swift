//
//  User.swift
//  Monasba
//
//  Created by Amal Elgalant on 29/04/2023.
//


import Foundation

struct UserArray: Codable{
    var data: [User]!
    var code: Int!
    var msg: String!
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case code = "statusCode"
        case msg = "message"
    }
    
    
}
struct UserLoginObject: Codable{
    var data: User!
    var code: Int!
    var msg: String!
    var token: String!

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case code = "statusCode"
        case msg = "message"
        case token = "accessToken"

    }
    
    
}
struct UserTokenObject: Codable{
    var data: UserObject!
    var code: Int!
    var msg: String!
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case code = "statusCode"
        case msg = "message"
    }
    
    
}


struct UserObject: Codable{
    var data: User!
   
    var token: String!
    enum CodingKeys: String, CodingKey {
        case data = "user"
        case token = "token"
    }
    
    
}



struct User:Codable{
    var name: String?
    var phone: String?
    var id: Int?
    var email: String?
    var username: String?
    var lastName: String?
    var countryId: String?
    var cityId: String?
    var regionId: String?
    var toke: String?
  
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case phone = "mobile"
        case email = "email"
        case username = "username"
        case lastName = "last_name"
        case countryId = "country_id"
        case cityId = "city_id"
        case regionId = "region_id"
    }
    
    
}
