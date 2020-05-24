//
//  AFWrapper.swift
//  Mindflow
//
//  Created by Manish on 11/6/17.
//  Copyright © 2018 MANHYA. All rights reserved.
//

//let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
//let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
//https://stackoverflow.com/questions/31949118/send-post-parameters-with-multipartformdata-using-alamofire-in-ios-swift

import UIKit
import Alamofire
import SwiftyJSON

class AFWrapper: NSObject {
    
    class func fetchDatatask(_ request: URLRequest, completion: @escaping (_ success: Bool, _ object: JSON) -> ()) {
        
        let confg = URLSessionConfiguration.default
        let session = URLSession(configuration: confg)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let responsData = data {
                if let value = String(data: responsData, encoding: String.Encoding.ascii) {
                    if let jsonData = value.data(using: String.Encoding.utf8) {
                        do {
                            let json = try JSONSerialization.jsonObject(with: jsonData, options:[]) as? [String: Any]
                            completion(true, JSON(json as AnyObject))
                            print(json as Any)
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
        task.resume()
    }

    // GET Request
    class func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    class func getImage(_ strURL : String, success:@escaping (UIImage) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL).responseData { responseObject in
            if responseObject.result.isSuccess {
                if let catPicture = responseObject.result.value {
                    success(UIImage(data: catPicture)!)
                }
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    //POST Request
    class func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL, method: .post, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    // Multipart Request
    class func requestMultipartPostURL (_ strURL : String, params : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.upload(
            multipartFormData: { MultipartFormData in

                for (key, value) in params! {
                    MultipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to: strURL) { (responseObject) in
            switch responseObject {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    guard ((response.result.value) != nil) else {return}
                    let resJson = JSON(response.result.value!)
                    success(resJson)
                }
            case .failure(let encodingError):
                let error : Error = encodingError
                failure(error)
            }
        }
    }
    
    // Multipart Request with image
    class func requestMultipartWithImagePostURL (_ strURL : String, params : [String : AnyObject]?,_ image: UIImage, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.upload(
            multipartFormData: { MultipartFormData in
                if let imageData = image.jpegData(compressionQuality: 0.75) {
                    MultipartFormData.append(imageData, withName: "profile_pic", fileName: "file.png", mimeType: "image/png")
                }
                
                for (key, value) in params! {
                    MultipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to: strURL) { (responseObject) in
            switch responseObject {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    guard ((response.result.value) != nil) else {return}
                    let resJson = JSON(response.result.value!)
                    success(resJson)
                }
            case .failure(let encodingError):
                let error : Error = encodingError
                failure(error)
            }
        }
    }
}


