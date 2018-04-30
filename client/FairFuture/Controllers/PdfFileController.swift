//
//  PdfFileController.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/29/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PdfFileController {
    var fileName: String!
    var file: Data!
    var fileURL: URL!
    func upload() {
        let url: URL = URL(string: "\(SERVER_URL)/resumes/upload")!
        let  params: Parameters = [
            "fileName" : fileName
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": AuthController.token,
            "Content-Type": "application/json",
            "Cache-Control": "no-cache, no-store, must-revalidate"
        ]
        
        Alamofire.request(
            url,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: headers).validate().responseJSON{
            (response) -> Void in
            guard response.result.isSuccess else {
                print("Error while fetching file data: \(response.result.error)")
                return
            }
        
            guard let value = response.result.value as? [String: AnyObject] else {
                print("Malformed data received from file info fetch service")
                return
            }
        
            let resume = value["resume"]
            let id = resume!["_id"]!
            let putURL = URL(string: "\(SERVER_URL)/resumes/upload/\(id!)")!
            let newHeaders: HTTPHeaders = [
                "Authorization": AuthController.token,
                "Content-Type": "multipart/form-data",
                "Cache-Control": "no-cache, no-store, must-revalidate"
            ]
            
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(self.fileURL, withName: "myfile")
                },
                to: putURL,
                method: .put,
                headers: newHeaders){ encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            print(response.value)
                            //debugPrint(response)
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
                }
        }
    }
    
    func getAll(closure: @escaping (_: [Resume?]) -> Void) {
        var resumes: [Resume] = []
        var resume = Resume()
        var url: URL
        if AuthController.user!.role == "applicant" || AuthController.user!.role == "Applicant" {
            url = URL(string: "\(SERVER_URL)/resumes/all")!
        } else {
            url = URL(string: "\(SERVER_URL)/resumes/all/employer")!
        }
        
        var mutableURLRequest = URLRequest(url: url)
        mutableURLRequest.httpMethod = GET
        mutableURLRequest.setValue(AuthController.token, forHTTPHeaderField: "Authorization")
        mutableURLRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        /*let headers: HTTPHeaders = [
            "Authorization": AuthController.token
        ]*/
        
        Alamofire.request(mutableURLRequest).responseJSON {
                (response) -> Void in
                
                guard response.result.isSuccess else {
                    print("Error while fetching file data: \(response.result.error)")
                    return
                }
                
                guard let value = response.result.value as? [String: AnyObject] else {
                    print("Malformed data received from file info fetch service")
                    return
                }
            
                //print("value: \(value)")
                
                if let dictionary = response.result.value {
                    let JSONData = JSON(dictionary)
                    let data =  JSONData["resumes"]
                    for i in 0..<data.count {
                        resume.id = data[i]["id"].string
                        resume.fileURL = data[i]["fileURL"].string
                        resume.sharedWith = data[i]["sharedWith"].arrayValue.map{$0.string}
                        resume.uploadedBy = data[i]["uploadedBy"].string
                        resume.fileName = data[i]["fileName"].string
                        //print(resume)
                        resumes.append(resume)
                    }
                    //print(resumes)
                    closure(resumes)
                }
        }
    }
    
    func share(id: String, closure: @escaping (_: Resume) -> Void) {
        let url = URL(string: "\(SERVER_URL)/resumes/share")!
    
        let headers: HTTPHeaders = [
            "Authorization": AuthController.token,
            "Content-Type": "application/json",
            "Cache-Control": "no-cache, no-store, must-revalidate"
        ]
        
        let  params: Parameters = [
            "fileId" : id
        ]
        
        Alamofire.request(
            url,
            method: .put,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: headers).validate().responseJSON {
                (response) -> Void in
                
                guard response.result.isSuccess else {
                    print("Error while fetching file data: \(response.result.error)")
                    return
                }
                
                guard let value = response.result.value as? [String: AnyObject] else {
                    print("Malformed data received from file info fetch service")
                    return
                }
                var resume = Resume()
                
                if let dictionary = response.result.value {
                    let JSONData = JSON(dictionary)
                    let data = JSONData["resume"]
                    
                        resume.id = data["id"].string
                        resume.fileURL = data["fileURL"].string
                        resume.sharedWith = data["sharedWith"].arrayValue.map{$0.string}
                        resume.uploadedBy = data["uploadedBy"].string
                        resume.fileName = data["fileName"].string
                        //print(resume)
                    
                    closure(resume)
                }
            }
        }
    
}
