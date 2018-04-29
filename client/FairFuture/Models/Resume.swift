//
//  Resume.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/29/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation

struct Resume: Codable {
    var sharedWith:[String?]?
    var uploadedBy: String?
    var fileName: String?
    var id: String?
    var fileURL: String?
}
