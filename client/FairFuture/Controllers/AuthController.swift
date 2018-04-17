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
    static func login(viewController: UIViewController, loginData: Login) {
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
                
                print("user: \(user)")
            } catch {
                print("unable to parse response")
                print(error)
                return
            }
            
            /*if !Locksmith.loadDataForUserAccount(userAccount: "FFUserAccount")!.isEmpty {
                guard var data = try Locksmith.deleteDataForUserAccount(userAccount: "FFUserAccount") else {
                    print("something went wrong")
                }
            }*/
            OperationQueue.main.addOperation({
                retUser(viewController: viewController, user: user)
            })
            
            
        }
        task.resume()
    }
    
    static func retUser(viewController: UIViewController, user: User?)-> User? {
        viewController.dismiss(animated: true, completion: nil)
        return user
    }
    
    static func register(user: Register) -> Bool{
        
        guard let url = URL(string: "\(SERVER_URL)/users/register") else {
            return false
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
            return false
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
            print(responseData)
        }
        task.resume()
        // TODO: FIX SO IT RETURNS FALSE WHEN SERVER RETURNS ERROR
        return true
    }
}
