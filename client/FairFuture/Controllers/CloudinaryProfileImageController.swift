//
//  CloudinaryProfileImageController.swift
//  FairFuture
//
//  Created by Raghav on 4/25/18.
//  Copyright © 2018 Raghav Gupta. All rights reserved.

import Foundation
import Cloudinary
import Alamofire

class CloudinaryController {
    let config = CLDConfiguration(cloudName: CLOUD_NAME, apiKey: API_KEY, apiSecret: nil)
    let cloudinary: CLDCloudinary
    //var signature: CLDSignature!
    var params: CLDUploadRequestParams!
    var alamofireParams: Parameters!
    
    init() {
        cloudinary = CLDCloudinary(configuration: config)
    }
    
    func uploadFIle(url: URL, data: Data) {
        let folder = "resume/\(AuthController.user!.id!)"
        params = CLDUploadRequestParams()
        params.setFolder(folder).setResourceType("raw")
        
        alamofireParams = [
            "publicID": "resume_pdf",
            "folder": folder
        ]
        
        getSecret(parameters: alamofireParams, completion: { () -> Void in
            self.cloudinary.createUploader().signedUpload(url: url, params: self.params,
                                                          progress: {(progress: Progress) in
                                                            
            }, completionHandler: {(result: CLDUploadResult?, error: NSError?) in
                if let error = error {
                    print(error)
                } else {
                    print("uploaded")
                }
            })
        })
        
        /*cloudinary.createUploader().upload(url: url, uploadPreset: "", params: params,
         progress: {(progress: Progress) in
         
         }, completionHandler: {(result: CLDUploadResult?, error: NSError?) in
         if let error = error {
         print(error.localizedDescription)
         } else {
         print("uploaded")
         }
         })*/
        //cloudinary.createUploader().upload(url: url, uploadPreset: "resume preset")
        //cloudinary.createUploader().upload(url: url, uploadPreset: "resume")
    }
    
    func getSecret(parameters: Parameters, completion: @escaping () -> Void) {
        Alamofire.request(
            URL(string: "\(SERVER_URL)/cloudinary/signature")!,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching signature: \(response.result.error)")
                    completion()
                    return
                }
                
                guard let value = response.result.value as? [String: Any] else {
                    print("Malformed data received from signature fetch service")
                    completion()
                    return
                }
                
                print(value)
                //let signature = CLDSignature(signature: value["signature"] as! String, timestamp: value["timestamp"] as! NSNumber)
                //self.params.setParam("api_key", value: value["api_key"] as! String)
                //self.params.setParam("signature", value: value["signature"] as! String)
                //self.params.setParam("timestamp", value: value["timestamp"] as! String)
                //self.params.setSignature(signature)
                //self.params.setPublicId(self.alamofireParams["publicID"] as! String)
                
                completion()
        }
    }
    
    //always return true as not sending any data to cloudinary
    func fileExists(fileID: String) -> Bool {
        let url = cloudinary.createUrl().generate("resume/\(AuthController.user!.id!)/\(fileID)")
        print(url)
        if url != nil {
            return true
        } else {
            return false
        }
    }
}
