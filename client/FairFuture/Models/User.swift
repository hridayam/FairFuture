//
//  user.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/3/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

//used as a user model and stores all the required user data

import Foundation

struct User: Codable {
    var firstName:String?
    var lastName: String?
    var email: String?
    var id: String?
    var role: String?
}
