//
//  AuthController.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/14/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation
import Locksmith

final class AuthController {
    static func login(loginData: Login) -> User? {
        var user: User?
        
        guard let url = URL(string: "\(SERVER_URL)/users/login") else {
            return nil
        }
        
        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = POST
        loginRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //let loginData = Login(email: "hridayambakshi@gmail.com", password: "password")
        
        let jsonLoginData: Data
        do {
            jsonLoginData = try JSONEncoder().encode(loginData)
            loginRequest.httpBody = jsonLoginData
        } catch {
            print("Error: cannot create JSON from login data")
            return nil
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: loginRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on /login")
                print(error!)
                return
            }
            //print(data)
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                //print (responseData, UTF8())
                let data = try JSONDecoder().decode(UserData.self, from: responseData)
                user = data.user
                
                print(user)
                try Locksmith.saveData(data: ["token": data.token], forUserAccount: "FFUserAccount")
            } catch {
                print("unable to parse response")
                print(error)
                return
            }
        }
        task.resume()
        return user
    }
}
