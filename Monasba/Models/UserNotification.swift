//
//  UserNotification.swift
//  Monasba
//
//  Created by Amal Elgalant on 25/05/2023.
//

import Foundation
struct UserNotificationArrayPaging: Codable{
    var data: UserNotificationArray!
    var code: Int!
    var msg: String!
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case code = "statusCode"
        case msg = "message"
    }
    
    
}

struct UserNotificationArray: Codable{
    var data: [UserNotification]!
    var code: Int!
    var msg: String!
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case code = "statusCode"
        case msg = "message"
    }
    
    
}
struct UserNotification: Codable {
    var id, uid, fid: Int?
    var ntype: String?
    var oid: Int?
    var ndate:String?
    var ncontent, nfrom, nto: String?
    var usersend, userf: [User]?
    
   
}
