//
//  LoginViewController.swift
//  FairFuture
//
//  Created by admin on 3/27/18.
//  Copyright © 2018 Raghav Gupta. All rights reserved.
//

import UIKit
import Locksmith

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func clickedLoginButton(_ sender: AnyObject) {
        
        guard let url = URL(string: "\(SERVER_URL)/users/login") else {
            return
        }
        
        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = POST
        loginRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let userEmail = userEmailTextField.text else {
            displayAlertMessage(userMessage:"please enter a valid email")
            return
        }
        guard let userPassword = userPasswordTextField.text else {
            displayAlertMessage(userMessage:"password cannot be empty")
            return
        }
        
        //let loginData = Login(email: userEmail, password: userPassword)
        let loginData = Login(email: "hridayambakshi@gmail.com", password: "password")
        
        AuthController.login(loginData: loginData)
        
        /*let jsonLoginData: Data
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
                let user = data.user
                
                print(user)
                try Locksmith.saveData(data: ["token": data.token], forUserAccount: "FFUserAccount")
            } catch {
                print("unable to parse response")
                print(error)
                return
            }
        }
        task.resume()*/
        
        /*let userEmailStored = UserDefaults.standard.string(forKey: "userEmail")
        
        let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword")
        
        if(userEmailStored == userEmail) {
            
            if(userPasswordStored == userPassword) {
                
                // Login is successfull
                UserDefaults.standard.set(true,forKey:"isUserLoggedIn")
                UserDefaults.standard.synchronize()
                
                self.dismiss(animated: true, completion:nil)
                
            }
        }*/
    }
}
