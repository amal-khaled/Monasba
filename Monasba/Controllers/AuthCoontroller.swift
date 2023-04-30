//
//  AuthCoontroller.swift
//  Monasba
//
//  Created by Amal Elgalant on 29/04/2023.
//

import Foundation
class AuthCoontroller{
    static let shared = AuthCoontroller()
    
    func login(completion: @escaping(Int, String)->(), phone: String, passwoord: String){
        
        var param = [
                     "mobile": phone,
                     "password": passwoord
                     ]
        
       
        APIConnection.apiConnection.postConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
                let userObject = try JSONDecoder().decode(UserLoginObject.self, from: data)
                
                if userObject.code == 200{
                    AppDelegate.currentUser = userObject.data ?? User()
                    AppDelegate.defaults.set( userObject.token ?? "", forKey: "token")
                    AppDelegate.currentUser.toke = userObject.token ?? ""
                    completion( 0,"")
                }
                else {
                    completion(1,userObject.msg ?? "")
                }
                
            } catch (let jerrorr){
                
                print(jerrorr)
                completion(1,SERVER_ERROR)
                
                
            }
            
        }, link: Constants.LOGIN_URL , param: param)
    }
    func register(completion: @escaping( Int, String)->(), user: User, password:String){
        
       
        var param = [
            "name": user.name,
            "mobile":user.phone,
            "password":password,
            "email":user.email,
            "username":user.username,
            "last_name":user.lastName,
            "country_id":user.countryId,
            
            "regid":"1",

                     ]
        if user.cityId != "-1"{
            param["city_id"] = user.cityId
        }
        if user.regionId != "-1"{
            param["region_id"] = user.regionId
        }
        APIConnection.apiConnection.postConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
                let userObject = try JSONDecoder().decode(UserTokenObject.self, from: data)
                
                if userObject.code == 200{
                    AppDelegate.currentUser = userObject.data.data ?? User()
                    AppDelegate.defaults.set( userObject.data.token ?? "", forKey: "token")
                    AppDelegate.currentUser.toke = userObject.data.token ?? ""
                    completion( 0,"")
                }
                else {
                    completion(1,userObject.msg ?? "")
                }
                
            } catch (let jerrorr){
                
                print(jerrorr)
                completion(1,SERVER_ERROR)
                
                
            }
            
        }, link: Constants.SIGN_UP_URL , param: param)
    }
}
