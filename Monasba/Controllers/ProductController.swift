//
//  ProductController.swift
//  Monasba
//
//  Created by Amal Elgalant on 26/04/2023.
//

import Foundation
class ProductController{
    static let shared = ProductController()
    
    func getHomeProducts(completion: @escaping([Product], Int, String)->(), page: Int,
                         countryId: Int,cityId: Int, categoryId: Int,subCategoryId: Int, type: Int, sorting: String, sell: Int?){
        
        var param = ["page": page,
                     "country_id": countryId,
                     sorting: 1]
        
        if categoryId != -1 {
            param["cat_id"] = categoryId
        }
        
        if categoryId == 1 && sell != nil{
            guard let sell = sell else{return}
            param["tajeer_or_sell"] = sell
        }
        
        if cityId != -1 {
            param["city_id"] = cityId
        }
        
        
        if subCategoryId != -1 {
            param["sub_cat_id"] = subCategoryId
        }
            
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
            
        }, link: Constants.HOME_PRODUCTS_URL , param: param)
    }
}
