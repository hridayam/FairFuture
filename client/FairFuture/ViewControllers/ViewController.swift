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
    
//
//    @IBOutlet weak var uploadedNumbers: UILabel!
//
//    var randomNumbers: [Int] = []
//
    
//    func loadData() {
//        let publicData = CKContainer.default().publicCloudDatabase
//        let query = CKQuery(recordType: "numbers", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
//        publicData.perform(query, inZoneWith: nil, completionHandler: { (results: [CKRecord]?, error: Error?) -> Void in
//            if let records = results {
//                for i in 0..<records.count {
//                    self.randomNumbers.append(Int((records[i]["content"] as? String)!)!)
//                }
//            } else {
//                print(error?.localizedDescription)
//            }
//            DispatchQueue.main.async {
//                self.setLabel()
//            }
//        })
//    }
    
//    func setLabel () {
//        var temp: String = ""
//        for i in 0..<randomNumbers.count {
//            if temp == "" {
//                temp = "\(randomNumbers[i])"
//            } else {
//                temp = "\(temp)\n\(randomNumbers[i])"
//            }
//        }
//
//        uploadedNumbers.numberOfLines = randomNumbers.count
//        uploadedNumbers.text = temp
//        randomNumbers.removeAll()
//    }
    
//
//    @IBAction func uploadRandNumbers(_ sender: Any) {
//        let newRecord = CKRecord(recordType: "numbers")
//        newRecord["content"] = String(Int(arc4random_uniform(UInt32(100)))) as NSString
//        let publicData = CKContainer.default().publicCloudDatabase
//        publicData.save(newRecord, completionHandler: { (record: CKRecord?, error:Error?) -> Void in
//            if error == nil {
//                print ("record saved")
//                self.loadData()
//            } else {
//                print(error?.localizedDescription)
//            }
//        })
//    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        loadData()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad() //do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() // dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn");
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
        
        
        
        //if (!isUserLoggedIn["token"]){
            
        //self.performSegue (withIdentifier: "loginView", sender: self);
        
       //}
    }
    
    @IBAction func clickedLogoutButton(_ sender: AnyObject) {
        
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: "FFUserAccount")
            print("logged out")
            //UserDefaults.standard.set(false,forKey:"isUserLoggedIn")
            //UserDefaults.standard.synchronize()
        } catch {
            print ("something went wrong while logging out")
        }

        self.performSegue(withIdentifier: "loginView", sender: self);
    }
    
}

