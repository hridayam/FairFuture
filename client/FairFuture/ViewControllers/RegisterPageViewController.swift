//
//  RegisterPageViewController.swift
//  FairFuture
//
//  Created by admin on 3/20/18.
//  Copyright © 2018 Raghav Gupta. All rights reserved.
//

import UIKit
import BEMCheckBox

class RegisterPageViewController: UIViewController, BEMCheckBoxDelegate {

    
    @IBOutlet weak var InstitutionCheckBox: BEMCheckBox!
    @IBOutlet weak var ApplicantCheckBox: BEMCheckBox!
    
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var reenterPasswordTextField: UITextField! 
    
    var firstName: String = ""
    var lastName: String = ""
    var userEmail: String = ""
    var userPassword: String = ""
    var reenterPassword: String = ""
    var role: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        InstitutionCheckBox.delegate = self
        ApplicantCheckBox.delegate = self
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        if checkBox.tag == 0 {
            ApplicantCheckBox.on = false
            role = "Company"
        }
        if (checkBox.tag == 1) {
            InstitutionCheckBox.on = false
            role = "Applicant"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickedRegisterButton(_ sender: AnyObject) { //
        
        firstName = (userFirstNameTextField.text)!;
        lastName = (userLastNameTextField.text)!;
        userEmail = (userEmailTextField.text)!;
        userPassword = (userPasswordTextField.text)!;
        reenterPassword = (reenterPasswordTextField.text)!; //
        
        //check for empty fields
        if(userEmail.isEmpty || userPassword.isEmpty || reenterPassword.isEmpty){
            
            // Display alert message
            displayAlertMessage(userMessage: "all text fields must be field approprietly.");
            return;
            
        }
   
        // check if password match}
        if(userPassword != reenterPassword){
            
            //display alert message
            displayAlertMessage(userMessage: "Your Re-entered password did not match.");
            return;
            
        }
        
        if (role.isEmpty) {
            displayAlertMessage(userMessage: "Please select a role");
            return;
        }

        let user = Register(firstName: firstName, lastName: lastName, password: userPassword, confirmPassword: reenterPassword, email: userEmail, role: role)
        
        AuthController.register(viewController: self, user: user, errMessage: "Unable to Register")
    }
    
    @IBAction func clickedAlreadyRegisteredButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)

    }
    

}
