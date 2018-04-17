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
        
        AuthController.login(viewController: self, loginData: loginData)
    }
}
