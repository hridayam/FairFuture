//
//  PdfFileController.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/29/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation
import Alamofire

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
            "Content-Type": "application/json"
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
                "Content-Type": "multipart/form-data"
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
        if AuthController.user!.role == "applicant" {
            url = URL(string: "\(SERVER_URL)/resumes/all")!
        } else {
            url = URL(string: "\(SERVER_URL)/resumes/all/employer")!
        }
        
        
        let headers: HTTPHeaders = [
            "Authorization": AuthController.token
        ]
        
        Alamofire.request(
            url,
            method: .get,
            headers: headers).responseJSON {
                (response) -> Void in
                
                guard response.result.isSuccess else {
                    print("Error while fetching file data: \(response.result.error)")
                    return
                }
                
                guard let value = response.result.value as? [String: AnyObject] else {
                    print("Malformed data received from file info fetch service")
                    return
                }
                
                print(value)
                if let temp = response.result.value as? [[String: Any]] {
                    
                    let taskArray = temp.flatMap { $0["task_id"] as? String }
                    print(taskArray)
                    
                    var temp = [value["resumes"] as! [String: AnyObject]]
                    
                    for i in 0..<temp.count {
                        resume.fileName = temp[i]["fileName"] as? String
                        resume.fileURL = temp[i]["fileURL"] as? String
                        resume.sharedWith = temp[i]["sharedWith"] as? [String?]
                        resume.uploadedBy = temp[i]["uploadedBy"] as? String
                        resumes.append(resume)
                    }
                    
                    //print(resumes)
                    closure(resumes)
                }
        }
    }
}
