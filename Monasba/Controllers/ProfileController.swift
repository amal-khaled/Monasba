//
//  ProfileController.swift
//  Monasba
//
//  Created by iOSayed on 21/05/2023.
//

import Foundation

class ProfileController {
    
    static let shared = ProfileController()
    
    func getProfile(completion: @escaping(User?, String)->(),user:User){
        
        var param = [
            "id" :AppDelegate.currentUser.id ?? 0,
            "anther_user_id": "0"
        ] as [String : Any]
        
       
        APIConnection.apiConnection.postConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
                
                let ProfileModel = try JSONDecoder().decode(ProfileModel.self, from: data)
                    var token = AppDelegate.currentUser.toke
                    AppDelegate.currentUser = ProfileModel.data ?? User()
                    AppDelegate.currentUser.toke = token
                AppDelegate.defaults.set( AppDelegate.currentUser.toke, forKey: "token")
                AppDelegate.defaults.set(AppDelegate.currentUser.id ?? 0, forKey: "userId")
                    completion(ProfileModel.data,ProfileModel.message ?? "")
                
                
            } catch (let jerrorr){
                
                print(jerrorr)
                AppDelegate.currentUser = User()
                AppDelegate.defaults.removeObject(forKey: "token")
                AppDelegate.defaults.removeObject(forKey: "userId") 

                completion(nil,SERVER_ERROR)
                
                
            }
            
        }, link: Constants.PROFILE_URL , param: param)
    }
    
    
    func getProductsByUser(completion: @escaping([Product], Int, String)->(),userId:Int, page: Int,countryId: Int){
        
        var param = ["page": page,
                     "uid": userId,
                     "country_id": countryId]
      
        APIConnection.apiConnection.postConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
                let productArray = try JSONDecoder().decode(ProductArrayPaging.self, from: data)
                
                if productArray.code == 200{
                    
                    completion(productArray.data.data, 0,"")
                }
                else {
                    completion([Product](),1,productArray.msg ?? "")
                }
                
            } catch (let jerrorr){
                
                print(jerrorr)
                completion([Product](),1,SERVER_ERROR)
                
                
            }
            
        }, link: Constants.PRODUCTS_BY_USER_URL , param: param)
    }
    
}