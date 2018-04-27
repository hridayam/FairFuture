//
//  RecruiterProfileViewController.swift
//  FairFuture
//
//  Created by Raghav on 4/20/18.
//  Copyright © 2018 Raghav Gupta. All rights reserved.
//

import Foundation
import UIKit

class RecruiterProfileViewController: UIViewController{
    var user: User?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        user = AuthController.user
        //TODO: handle Optionals properly
        nameLabel.text = "\(user!.firstName) \(user!.lastName)"
        emailLabel.text = "\(user?.email)"
    }
}
