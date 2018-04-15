//
//  KeychainPasswordItem.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/14/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation

let key = <# a key #>
let tag = "com.example.FairsFuture.mykey".data(using: .utf8)!
let addquery: [String: Any] = [kSecClass as String: kSecClassKey,
                               kSecAttrApplicationTag as String: tag,
                               kSecValueRef as String: key]
