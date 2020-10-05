//
//  TKTCloud.swift
//  TikiTechLibrary
//
//  Created by Nguyen Hieu Trung on 9/5/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import Foundation
import ObjectMapper

public class TKTCLoud {
    public static let shared = TKTCLoud()
    var configure: TKTConfiguration?
    
//    init(configure: TKTConfiguration) {
//        self.configure = configure
//    }
    
    public func setConfigure(configure: TKTConfiguration){
        self.configure = configure
    }
    
    public func getConfig() -> TKTConfiguration?{
        return configure
    }
    
    public func execute(complete: @escaping((_ json: [String: AnyObject])->Void)){
        //        let params = ["username":"john", "password":"123456"] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: "https://powerful-stream-90084.herokuapp.com/api/userskin/5f4a422ddf666f0b9c9aa9e2")!)
        request.httpMethod = "GET"
        //        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                complete(json)
                //                let model = UserSkinModel(JSON: json)
                //                print(json)
            } catch {
                print("error")
            }
        })
        
        task.resume()
    }
    
    func executeUpload(imageBase64: String, complete: @escaping((_ json: [String: AnyObject]?, _ error: Error?)->Void)){

        let params = ["image_base64": imageBase64,
                      "email":configure?.email ?? ""] as Dictionary<String, Any>
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        let strURL = (configure?.domain ?? "") + "/api/userskin"
        let request = NSMutableURLRequest(url: URL(string:  strURL)!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(configure?.apiKey ?? "", forHTTPHeaderField: "apikey")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error -> Void in
//            print(response!)
            if error != nil {
                complete(nil, error)
            }else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                    complete(json, nil)
                } catch let error {
                    print("error: \(error.localizedDescription)")
                }
            }
        })
        
        task.resume()
    }
}
