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
            if let token =  dictionary?["token"] as! String? {
                // TODO: add segue to profile
                print(token)
                if AuthController.user == nil {
                    AuthController.getUser(token: token, closure: {() -> Void in
                        self.displayUserInfo()
                    })
                }
                displayUserInfo()
            }else {
                self.performSegue (withIdentifier: "loginView", sender: self);
            }
        } catch {
            print("something went wrong")
        }
    }
    
    func displayUserInfo(){
        OperationQueue.main.addOperation({
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 500, height: 100))
            label.center = CGPoint(x: 160, y: 285)
            label.textAlignment = .center
            label.numberOfLines = 5
            label.text = "\(String(describing: AuthController.user?.firstName)) \(String(describing: AuthController.user?.lastName)) \(String(describing: AuthController.user?.email))"
            self.view.addSubview(label)
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

