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


//
//struct User:Codable{
//    var name: String?
//    var phone: String?
//    var id: Int?
//    var email: String?
//    var username: String?
//    var lastName: String?
//    var countryId: String?
//    var cityId: String?
//    var regionId: String?
//    var toke: String?
//
//
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case phone = "mobile"
//        case email = "email"
//        case username = "username"
//        case lastName = "last_name"
//        case countryId = "country_id"
//        case cityId = "city_id"
//        case regionId = "region_id"
//    }
//
//
//}

struct User: Codable {
    var id: Int?
    var name, lastName, username, pass: String?
    var loginMethod, uid, bio, phone: String?
    var email: String?
    var countryId, cityId, regionId: Int?
    var pic: String?
    var cover, regid: String?
    var typeMob, verified, blocked: Int?
    var notification, deactivate: Int?
    var note, passV: String?
    var isAdvertiser: Int?
    var countriesNameAr, countriesNameEn, citiesNameAr, citiesNameEn: String?
    var regionsNameAr, regionsNameEn: String?
    var numberOfProds, following, followers, userRate: Int?
    var isFollow, activeNotification: Int?
    var toke: String?
    enum CodingKeys: String, CodingKey {
        case id, name
        case lastName = "last_name"
        case username, pass
        case loginMethod = "login_method"
        case uid, bio, email
        case  phone = "mobile"
        case countryId = "country_id"
        case cityId = "city_id"
        case regionId = "region_id"
        case pic, cover, regid
        case typeMob = "type_mob"
        case verified, blocked
        case notification, deactivate, note
        case passV = "pass_v"
        case isAdvertiser = "is_advertiser"
        case countriesNameAr = "countries_name_ar"
        case countriesNameEn = "countries_name_en"
        case citiesNameAr = "cities_name_ar"
        case citiesNameEn = "cities_name_en"
        case regionsNameAr = "regions_name_ar"
        case regionsNameEn = "regions_name_en"
        case numberOfProds
        case following = "Following"
        case followers = "Followers"
        case userRate = "UserRate"
        case isFollow = "is_follow"
        case activeNotification = "active_notification"
    }
}
