//
//  CloudinaryController.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/23/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation
import Cloudinary

class CloudinaryController {
    let config = CLDConfiguration(cloudName: CLOUD_NAME, secure: true)
    
    func uploadFIle(url: URL) {
        let cloudinary = CLDCloudinary(configuration: config)
        let params = CLDUploadRequestParams()
            .setUploadPreset("resume preset").setFolder("resume/\(AuthController.user!.id!)")
            .setResourceType("pdf")
        cloudinary.createUploader().upload(url: url, uploadPreset: "resume preset")
        //request.upload(url: url, uploadPreset: params)
    }
}
