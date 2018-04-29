//
//  QRCodeGenerateRequestController.swift
//  FairFuture
//
//  Created by admin on 4/24/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//



import Foundation
import Alamofire

class QRCodeGenerateController {
    
//    func getCode() {
//
//        Alamofire.request(
//            URL(string: "http://api.qrserver.com/v1/create-qr-code/?data=--------!&size=100x100")!,
//            method: .get)
//            .validate()
//            .responseJSON { (response) -> Void in
//                guard response.result.isSuccess else {
//                    print("Error while fetching signature: \(response.result.error)")
//                    completion()
//                    return
//                }
//
//                guard let value = response.result.value as? [String: Any] else {
//                    print("Malformed data received from signature fetch service")
//                    completion()
//                    return
//                }
//
//                print(value)
//                //let signature = CLDSignature(signature: value["signature"] as! String, timestamp: value["timestamp"] as! NSNumber)
//                //self.params.setParam("api_key", value: value["api_key"] as! String)
//                //self.params.setParam("signature", value: value["signature"] as! String)
//                //self.params.setParam("timestamp", value: value["timestamp"] as! String)
//                self.params.setSignature(signature)
//                self.params.setPublicId(self.alamofireParams["publicID"] as! String)
//
//                completion()
//        }
//    }
    
}
