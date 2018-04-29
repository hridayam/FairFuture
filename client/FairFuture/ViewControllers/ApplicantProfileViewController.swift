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
    let imagePicker = UIImagePickerController() //create new image picker property
    var image: UIImage?   //optional uiimage
    
    
    @IBOutlet weak var profileImage: CustomizableImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBAction func profileImageEdit(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: handle Optionals properly
        print("here")
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        user = AuthController.user
        nameLabel.text = "\(user!.firstName) \(user!.lastName)"
        emailLabel.text = "\(user?.email)"
    }
    
    
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.image = pickedImage
        }
        
        // here we will upload image
        print("Image upload successful")
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
