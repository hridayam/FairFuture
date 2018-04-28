//
//  LoginViewController.swift
//  FairFuture
//
//  Created by Raghav on 3/27/18.
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
    // takes the email and password from the user and sends it to the login function in authcontroller class
    @IBAction func clickedLoginButton(_ sender: AnyObject) {
        // check validity of data
        guard let userEmail = userEmailTextField.text else {
            displayAlertMessage(userMessage:"please enter an email address")
            return
        }
        if !userEmail.isValidEmail() {
            displayAlertMessage(userMessage:"please enter a valid email address")
            return
        }
        guard let userPassword = userPasswordTextField.text else {
            displayAlertMessage(userMessage:"password cannot be empty")
            return
        }
        let loginData = Login(email: userEmail, password: userPassword)
        //let loginData = Login(email: "hridayambakshi@gmail.com", password: "password")
        // login and store user data
        AuthController.login(viewController: self, loginData: loginData, errMessage: "Unable to Login")
    }
    // regex to check email validity
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
}
