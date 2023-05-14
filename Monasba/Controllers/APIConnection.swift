//
//  APIConnection.swift
//  Monasba
//
//  Created by Amal Elgalant on 26/04/2023.
//


import Foundation
import Alamofire
import MOLH

class APIConnection{
    static var apiConnection = APIConnection()
    
    func getConnection (completion: @escaping(Data?)-> (), link : String){
        var header: HTTPHeaders =
        [
         "OS": "ios",
         "Accept":"application/json",
         "locale": MOLHLanguage.currentAppleLanguage()
         //         "App-Version": version as! String,
         //         "Os-Version": UIDevice.current.systemVersion
        ]
        if AppDelegate.currentUser.toke != "" && AppDelegate.currentUser.toke != nil{
            header["Authorization"] = "Bearer \(AppDelegate.currentUser.toke ?? "")"
        }
        AF.request(link, method: .get, headers: header ).responseJSON { response in
            print("=============================================")
            print(link)
            print(header)
            
            print(response.result)
            print("=============================================")
            
            if let JSON = response.data {
                completion(JSON)
            }
            
            else {
                completion(nil)
            }
        }
    }
    //JSONEncoding.default
    func postConnection (completion: @escaping(Data?)-> (), link : String, param: Parameters ){
        var header: HTTPHeaders =
        [
         "OS": "ios",
         "Accept":"application/json",
         "locale": MOLHLanguage.currentAppleLanguage()
         //         "App-Version": version as! String,
         //         "Os-Version": UIDevice.current.systemVersion
        ]
        print(AppDelegate.currentUser.toke)
        if AppDelegate.currentUser.toke != "" && AppDelegate.currentUser.toke != nil{
            header["Authorization"] = "Bearer \(AppDelegate.currentUser.toke ?? "")"
        }
        print(param)
        AF.request(link, method: .post, parameters: param, headers: header).responseJSON { response in
            print("=============================================")
            print(link)
            print(param)
            print(header)
            
            print(response.result)
            print("=============================================")
            if let JSON = response.data {
                completion(JSON)
            }
            
            else {
                completion(nil)
            }
        }
    }
}
