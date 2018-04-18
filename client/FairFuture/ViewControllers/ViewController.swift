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
        do {
            let dictionary = try Locksmith.loadDataForUserAccount(userAccount: "FFUserAccount")
            if let token =  dictionary?["token"] {
                // TODO: add segue to profile
                print(token)
            }else {
                self.performSegue (withIdentifier: "loginView", sender: self);
            }
        } catch {
            print("something went wrong")
        }
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

