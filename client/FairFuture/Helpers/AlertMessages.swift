//
//  AlertMessages.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/16/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    func displayAlertMessage(userMessage:String){
        
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
        
    }
}
