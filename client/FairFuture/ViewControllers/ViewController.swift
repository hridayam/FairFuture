//
//  ViewController.swift
//  FairFuture
//
//  Created by hridayam bakshi on 2/28/18.
//  Copyright © 2018 Raghav Gupta. All rights reserved.
//

import UIKit
import CloudKit
import Locksmith

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad() //do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() // dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // check if user is there. If not resirect to login screen
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "FFUserAccount")
        if dictionary != nil {
            if let token =  dictionary!["token"] as? String {
                print(token)
                if AuthController.user == nil {
                    AuthController.getUser(token: token, closure: {() -> Void in
                        self.displayUserInfo()
                    })
                } else {
                    // needed when logging in for the first time
                    displayUserInfo()
                }
            } else {
                self.performSegue (withIdentifier: "loginView", sender: self);
            }
        } else {
            self.performSegue (withIdentifier: "loginView", sender: self);
        }
    }
    
    func displayUserInfo(){
        OperationQueue.main.addOperation({
            if AuthController.user?.role ==  "applicant" || AuthController.user?.role ==  "Applicant" {
                self.performSegue (withIdentifier: "ApplicantProfile", sender: self);
            } else if AuthController.user?.role == "Company" {
                self.performSegue (withIdentifier: "RecruiterProfile", sender: self);
            }
        })
    }
    
    // logout and remove data from keychain
    @IBAction func clickedLogoutButton(_ sender: AnyObject) {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: "FFUserAccount")
            print("logged out")
        } catch {
            print ("something went wrong while logging out")
        }

        self.performSegue(withIdentifier: "loginView", sender: self);
    }
    
}

