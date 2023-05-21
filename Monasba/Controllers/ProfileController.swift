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
            //"id": "\(user.id ?? 0)",
            "id" :"2359",
            "anther_user_id": "0"
        ]
        
       
        APIConnection.apiConnection.postConnection(completion: {
            data  in
            guard let data = data else { return }
            
            do {
                let ProfileModel = try JSONDecoder().decode(ProfileModel.self, from: data)
                completion(ProfileModel.data,ProfileModel.message ?? "")
                
            } catch (let jerrorr){
                
                print(jerrorr)
                completion(nil,SERVER_ERROR)
                
                
            }
            
        }, link: Constants.PROFILE_URL , param: param)
    }
    
}
