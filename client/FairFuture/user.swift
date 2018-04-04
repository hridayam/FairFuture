//
//  user.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/3/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation

struct User: Decodable {
    var firstName:String
    var email: String
    var lastName: String
    var id: String
    var role: String
}

struct UserData: Decodable {
    var user: User
    var token: String
}

struct Login: Codable {
    var email: String
    var password: String
}
