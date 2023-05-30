//
//  AddAdvsController.swift
//  Monasba
//
//  Created by iOSayed on 13/05/2023.
//

import Foundation
import Alamofire

class AddAdvsController{
    
    static let shared = AddAdvsController()
    
    func addAdvs(params:[String:Any] ,images:[UIImage],videos:[Data] , completion:@escaping(Bool,String)-> Void){
        
        var parameters = [String:Any]()
        
        //main_image
        AF.upload(multipartFormData: {  multipartFormData in
            // Upload the main image
//            parameters =   [            "uid":111,
//                                        "name":"test", "price":"1200",
//                                        "amount":"0", "lat": "0", "lng":"0",
//                                        "prod_size":"25","color":"red",
//                                        "color_name":"red",
//                                        "cat_id":1,
//                                        "sub_cat_id": 10,
//                                        "sell_cost":"1200","errors":"",
//                                        "brand_id":"Nike",
//                                        "material_id":"",
//                                        //AppDelegate.currentUser.countryId ?? "0"
//                                        "country_id":"6",
//                                        "city_id":47,
//                                        "region_id":7465,
//                                        "loc":" EGYPT",
//                                        "phone":"54545","wts":"211212","descr":"testt",
//                                        "has_chat":"on","has_wts":"on","has_phone":"on",
//                                        "tajeer_or_sell":0]
            
            for (index,image) in images.enumerated() {
                
                if index == 0 {
                    if let imageData = image.jpegData(compressionQuality: 0.01) {
                        multipartFormData.append(imageData, withName: "main_image", fileName: "main_image.jpg", mimeType: "image/jpg")
                    }
                }else{
                    if let imageData = image.jpegData(compressionQuality: 0.01) {
                        parameters["mtype[]"] = "IMAGE"
                        multipartFormData.append(imageData, withName: "sub_image[]", fileName: "file\(index).jpg", mimeType: "image/jpg")
                    }
                }
               
                // Upload the sub-images
//                for (index, image) in images.enumerated() {
//                    if index != 0 { // Skip the first image (already uploaded as main image)
//                        if let imageData = image.jpegData(compressionQuality: 0.01) {
//                            parameters["mtype[]"] = "IMAGE"
//                            multipartFormData.append(imageData, withName: "sub_image[]", fileName: "file\(index).jpg", mimeType: "image/jpg")
//                        }
//                    }
//                }
                
                //                // Upload the videos
                //                for (index, video) in videos.enumerated() {
                //                    parameters["mtype[]"] = "VIDEO"
                //                    multipartFormData.append(video, withName: "sub_image[]", fileName: "sub_video\(index).mp4", mimeType: "video/mp4")
                //                }
                print(params)
                for (key,value) in params {
                    multipartFormData.append((value as AnyObject).description.data(using: String.Encoding.utf8)!, withName: key)
                }
                
            }
          
            
        },to:Constants.ADDADVS_URL)
        .responseDecodable(of:AddAdvsModel.self){ response in
            
            switch response.result {
            case .success(let data):
                print("success")
                if data.statusCode == 200{
                    completion(true,data.message ?? "")
                }else{
                    completion(false , data.message ?? "")
                }
            case .failure(let error):
                print(error)
                completion(false,SERVER_ERROR)
                
            }
        }
        
    }
}
