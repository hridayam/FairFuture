//
//  ApplicantProfileViewController.swift
//  FairFuture
//
//  Created by Raghav on 4/19/18.
//  Copyright © 2018 Raghav Gupta. All rights reserved.
//

import Foundation
import UIKit
import Locksmith

class ApplicantProfileViewController: UIViewController {
    var user: User?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        user = AuthController.user
        //TODO: handle Optionals properly
        nameLabel.text = "\(user!.firstName!) \(user!.lastName!)"
        emailLabel.text = "\(user!.email!)"
    }
    
    @IBAction func clickedLogoutButton(_ sender: Any) {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: "FFUserAccount")
            print("logged out")
        } catch {
            print ("something went wrong while logging out")
        }
        
        self.performSegue(withIdentifier: "loginView", sender: self);
}
}

