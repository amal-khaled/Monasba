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
            "Authorization": "Bearer \(AppDelegate.currentUser.toke ?? "")",
         "OS": "ios",
         "Accept":"application/json",
         "locale": MOLHLanguage.currentAppleLanguage()
         //         "App-Version": version as! String,
         //         "Os-Version": UIDevice.current.systemVersion
        ]
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
            "Authorization": "Bearer \(AppDelegate.currentUser.toke ?? "")",
         "OS": "ios",
         "Accept":"application/json",
         "locale": MOLHLanguage.currentAppleLanguage()
         //         "App-Version": version as! String,
         //         "Os-Version": UIDevice.current.systemVersion
        ]
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
    
    func uploadConnection(completion: @escaping(Bool,String)-> (), link : String, param: Parameters , mediaArray:[String:Data]){
        
//        var header: HTTPHeaders =
//        [
//            "Authorization": "Bearer \(AppDelegate.currentUser.toke ?? "")",
//         "OS": "ios",
//         "Accept":"application/json",
//         "locale": MOLHLanguage.currentAppleLanguage()
//         //         "App-Version": version as! String,
//         //         "Os-Version": UIDevice.current.systemVersion
//        ]
        
        AF.upload(multipartFormData: { multipart in
            
            
            
            
            for (key,value) in param {
                multipart.append((value as AnyObject).description.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: Constants.ADDADVS_URL)
        .responseDecodable(of:SuccessModel.self){ response in
            
            switch response.result {
            case .success(let data):
                print(data.message ?? "")
                completion(true, data.message ?? "")
            case .failure(let error):
                print(error)
                completion(false,SERVER_ERROR)
            }
        }
    }
    
    
    func uploadImagesAndVideos(images: [UIImage], videos: [URL], completionHandler: @escaping (Result<String, Error>) -> Void) {
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
        
        AF.upload(multipartFormData: { multipartFormData in
            // Upload images
            for (index, image) in images.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    let fileName = "\(UUID().uuidString).jpg"
                    multipartFormData.append(imageData, withName: "sub_image[]", fileName: fileName, mimeType: "image/jpeg")
                }
            }
            
            // Upload videos
            for video in videos {
                do {
                    let videoData = try Data(contentsOf: video)
                    let fileName = "\(UUID().uuidString).mp4"
                    multipartFormData.append(videoData, withName: "sub_image[]", fileName: fileName, mimeType: "video/mp4")
                } catch {
                    completionHandler(.failure(error))
                    return
                }
            }
            
        }, to: Constants.ADDADVS_URL, headers: headers)
        
    }
    
}
