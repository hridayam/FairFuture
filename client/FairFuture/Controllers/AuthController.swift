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
    static var user: User?
    static func login(viewController: UIViewController, loginData: Login, errMessage: String) {
        guard let url = URL(string: "\(SERVER_URL)/users/login") else {
            return
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
            return
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
                
                do {
                    try Locksmith.saveData(data: ["token": data.token], forUserAccount: "FFUserAccount")
                } catch {
                    print("unable to save in keychain")
                }
                
                //print("user: \(user)")
            } catch {
                print("unable to parse response")
                print(error)
            }
            
            var userReceived = false
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    userReceived = true
                }
            }
            
            OperationQueue.main.addOperation({
                viewControllerTask(viewController: viewController, bool: userReceived , errMessage: errMessage)
            })
        }
        task.resume()
    }
    
    static func register(viewController: UIViewController, user: Register, errMessage: String) {
        
        guard let url = URL(string: "\(SERVER_URL)/users/register") else {
            return
        }
        
        var registerRequest = URLRequest(url: url)
        registerRequest.httpMethod = POST
        registerRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //let loginData = Login(email: "hridayambakshi@gmail.com", password: "password")
        
        let jsonRegisterData: Data
        do {
            jsonRegisterData = try JSONEncoder().encode(user)
            registerRequest.httpBody = jsonRegisterData
        } catch {
            print("Error: cannot create JSON from login data")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: registerRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on /register")
                print(error!)
                return
            }
            //print(data)
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            var bool =  false
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    bool = true
                }
            }
            OperationQueue.main.addOperation({
                viewControllerTask(viewController: viewController, bool: bool, errMessage: errMessage)
            })
            //print(responseData)
        }
        task.resume()
    }
    
    static func viewControllerTask(viewController: UIViewController, bool: Bool ,errMessage: String) {
        if bool {
            viewController.dismiss(animated: true, completion: nil)
        } else {
            viewController.displayAlertMessage(userMessage: errMessage)
        }
    }
}
