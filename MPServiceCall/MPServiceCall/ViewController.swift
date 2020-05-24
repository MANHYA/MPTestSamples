//
//  ViewController.swift
//  MPServiceCall
//
//  Created by Manish on 2/20/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        callServiceWithImage()
    }
    
    func test() {
        
        let url = "http://techmilana.com/mindflow_api/actions.php?action=quiz_response&res_type=28&quiz=0&question=0&rating=5&type=2&user=31&review=Lkasklan&response_pic=kjgjkjkgj"
        
        //        let url = "http://techmilana.com/mindflow_api/actions.php?action=quiz_response&res_type=0&quiz=0&question=0&rating=5&type=2&user=31&review=Hfjhfjh&response_pic=dnfbdsnbkdfs"
        
        //        let url = "http://techmilana.com/mindflow_api/actions.php?action=quiz_response&res_type=18&quiz=7&question=7&rating=8&type=2&response_pic=jhfjhfjhfjhvj&user=27&review=fhcjhchc"
        //        let params = ["res_type":"0","quiz":"0","question":"0","rating":"5","type":"2","user":"31","review":"dfds","response_pic":"dlkfnsl"]
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.queryString, headers: nil).responseData(completionHandler: { (response) in
            
            if let value = String(data: response.data!, encoding: String.Encoding.ascii) {
                if let jsonData = value.data(using: String.Encoding.utf8) {
                    do {
                        let json = try JSONSerialization.jsonObject(with: jsonData, options:[]) as? [String: Any]
                        //  completion(true, JSON(json as AnyObject))
                        print(json as Any)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
        })
    }
    
    func callService() {
            var request = URLRequest(url: URL(string: "http://techmilana.com/mindflow_api/actions.php")!)
            request.httpMethod = "POST"
            let postString = "action=quiz_response&res_type=0&quiz=0&question=0&rating=5&type=2&user=31&review=Lkasklan&response_pic=kjgjkjkgj"
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error.debugDescription)")
                    return
                }
        
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response.debugDescription)")
        
                }
        
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")
            }
            task.resume()
            }
    
    func callServiceWithImage() {

        // User "authentication":
        let param = ["action":"quiz_response", "res_type":"30","quiz":"0","question":"0","rating":"5","type":"2","user":"27","review":"Lkasklanjgjkkjgjk12"]
        
             // Image to upload:
             let imageToUploadURL = Bundle.main.url(forResource: "1", withExtension: "png")
        
             // Server address (replace this with the address of your own server):
             let url = "http://techmilana.com/mindflow_api/actions.php"
        
             // Use Alamofire to upload the image
             Alamofire.upload(
                     multipartFormData: { multipartFormData in
                             // On the PHP side you can retrive the image using $_FILES["image"]["tmp_name"]
                            // multipartFormData.append(imageToUploadURL!, withName: "response_pic")
                        
                        let image = UIImage(named: "1")
                        
                        if let imageData = image!.jpegData(compressionQuality: 0.75) {
                            multipartFormData.append(imageData, withName: "response_pic",fileName: "file.jpg", mimeType: "image/jpg")
                        }
                             for (key, val) in param {
                                     multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: key)
                                 }
                     },
                     to: url,
                     encodingCompletion: { encodingResult in
                         switch encodingResult {
                         case .success(let upload, _, _):
                             upload.responseJSON { response in
                                 if let jsonResponse = response.result.value as? [String: Any] {
                                     print(jsonResponse)
                                 }
                             }
                         case .failure(let encodingError):
                             print(encodingError)
                         }
                 }
                 )
    }
    
    func call(url: String, params: Dictionary<String, Any>) {
        firstly {
            Alamofire
                .request("http://example.com", method: .post, parameters: params)
                .responseDecodable(Foo.self)
            }.done { foo in
                //…
            }.catch { error in
                //…
        }
    }
    
    func myMethod<T where T : UIViewController, T : MyProtocol>() -> T {
        
    }
    
    func call2() {
        firstly {
            URLSession.shared.dataTask(.promise, with: try makeUrlRequest()).validate()
            // ^^ we provide `.validate()` so that eg. 404s get converted to errors
            }.map {
                try JSONDecoder().decode(Foo.self, with: $0.data)
            }.done { foo in
                //…
            }.catch { error in
                //…
        }
        
        func makeUrlRequest(url: URL, obj: Dictionary<String, Any>) throws -> URLRequest {
            var rq = URLRequest(url: url)
            rq.httpMethod = "POST"
            rq.addValue("application/json", forHTTPHeaderField: "Content-Type")
            rq.addValue("application/json", forHTTPHeaderField: "Accept")
            rq.httpBody = try JSONEncoder().encode(obj)
            return rq
        }
    }
    
    func call3() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let fetchImage = URLSession.shared.dataTask(.promise, with: URL(string: "url")!).compactMap{ UIImage(data: $0.data) }
        let fetchLocation = CLLocationManager.requestLocation().lastValue
        
        firstly {
            when(fulfilled: fetchImage, fetchLocation)
            }.done { image, location in
                self.imageView.image = image
                self.label.text = "\(location)"
            }.ensure {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }.catch { error in
                self.show(UIAlertController(for: error), sender: self)
        }
    }
}




