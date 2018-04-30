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

class ApplicantProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var user: User?
    var image: UIImage?   //optional uiimage
    
    
    @IBOutlet weak var profileImage: CustomizableImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userRoleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBAction func profileImageEdit(_ sender: UIButton) {
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: handle Optionals properly
        print("here")
        
       
        
        user = AuthController.user
        user = AuthController.user
        nameLabel.text = "\(user!.firstName!) \(user!.lastName!)"
        emailLabel.text = "\(user!.email!)"
        userRoleLabel.text = "\(user!.role!)"
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
