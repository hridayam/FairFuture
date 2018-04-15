//
//  AuthController.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/14/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation

final class AuthController {
    static let serviceName = "FairFutureService"
    
    static var isSignedIn:Bool {
        guard let currentUser = Settings.currentUser else {
            return false
        }
        
        do {
            // 2
            //let password = try KeychainPasswordItem(service: serviceName, account: currentUser.email).readPassword()
            return password.count > 0
        } catch {
            return false
        }
    }
}
