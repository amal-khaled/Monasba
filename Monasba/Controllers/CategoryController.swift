//
//  CategoryController.swift
//  Monasba
//
//  Created by Amal Elgalant on 27/04/2023.
//

import Foundation
class CategoryController{
    static let shared = CategoryController()
    
    func getCategoories(completion: @escaping([Category], Int, String)->()){
        
        var param = [
                     "cat_id": "0",
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
    func getSubCategories(completion: @escaping([Category], Int, String)->(), categoryId: Int){
        
        var param = [
                     "cat_id": categoryId,
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
            
        }, link: Constants.GET_SUB_CATEGORIES_URL , param: param)
    }
}
