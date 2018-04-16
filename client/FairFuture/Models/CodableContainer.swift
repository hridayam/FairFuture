//
//  CodableObject.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/16/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation

struct CodableContainer<T: Codable>: Codable {
    let data: T
}
