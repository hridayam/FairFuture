//
//  RegisterPageViewController.swift
//  FairFuture
//
//  Created by admin on 3/20/18.
//  Copyright © 2018 Raghav Gupta. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var reenterPasswordTextField: UITextField! //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickedRegisterButton(_ sender: AnyObject) { //
        
        //let userName = userNameTextField.text;
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        let reenterPassword = reenterPasswordTextField.text; //
        
        //check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || reenterPassword!.isEmpty){
            
            // Display alert message
            displayAlertMessage(userMessage: "all text fields must be field approprietly.");
            return;
            
        }
   
        // check if password match}
        if(userPassword != reenterPassword){
            
            //display alert message
            displayAlertMessage(userMessage: "Your Re-entered passwprd did not match.");
            return;
            
        }
    
        //store data
        UserDefaults.standard.set(userEmail,forKey:"userEmail");
        UserDefaults.standard.set(userPassword,forKey:"userPassword");
        UserDefaults.standard.synchronize();

        
        //display alert message with confirmation
        
        let myAlert = UIAlertController(title:"Alert", message:"Registration is successful. Thank you!", preferredStyle: UIAlertControllerStyle.alert);
            
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default) {
                action in
            self.dismiss(animated: true, completion:nil);
            
                 }
            
            myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
            
         }
    
    
    func displayAlertMessage(userMessage:String){
        
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
        
    }
    
    @IBAction func clickedAlreadyRegisteredButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)

    }
    

}
