//
//  UserData.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/14/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

// data sent by the server is stored here
import Foundation

struct UserData: Decodable {
    var user: User?
    var token: String?
}
