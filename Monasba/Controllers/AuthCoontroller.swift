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
                let categoryArray = try JSONDecoder().decode(CategoryArray.self, from: data)
                
                if categoryArray.code == 200{
                    
                    completion(categoryArray.data, 0,"")
                }
                else {
                    completion([Category](),1,categoryArray.msg ?? "")
                }
                
            } catch (let jerrorr){
                
                print(jerrorr)
                completion([Category](),1,SERVER_ERROR)
                
                
            }
            
        }, link: Constants.GET_CATEGORIES_URL , param: param)
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
            "city_id":user.cityId,
            "region_id":user.regionId,

                     ]
        
       
        APIConnection.apiConnection.postConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
                let userObject = try JSONDecoder().decode(UserTokenObject.self, from: data)
                
                if userObject.code == 200{
                    AppDelegate.currentUser = userObject.data
                    AppDelegate.defaults.set( userObject.data.token ?? "", forKey: "token")

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
