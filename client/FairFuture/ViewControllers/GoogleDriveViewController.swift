//
//  GoogleDriveViewController.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/21/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation
import GoogleAPIClientForREST
import GoogleSignIn
import UIKit
import CloudKit

class GoogleDriveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GIDSignInDelegate, GIDSignInUIDelegate {
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLRAuthScopeDriveReadonly]
    
    private let service = GTLRDriveService()
    let signInButton = GIDSignInButton()
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    var filesStack = [[GTLRDrive_File]]()
    var filesView: UITableView!
    var filesParent: String?
    
    var files: [GTLRDrive_File]? {
        didSet {
            if filesStack.count != 0 {
                backButton.isHidden = false
                if filesParent != nil {
                    headerLabel.text = filesParent!
                } else {
                    headerLabel.text = "My Drive"
                }
            } else {
                backButton.isHidden = true
                //print("here")
                headerLabel.text = "My Drive"
            }
            
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height - headerLabel.frame.height
            
            filesView = UITableView(frame: CGRect(x: 0, y: barHeight + headerLabel.frame.height , width: displayWidth, height: displayHeight - barHeight))
            filesView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
            filesView.dataSource = self
            filesView.delegate = self
            self.view.addSubview(filesView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = "606220905552-l2apq06plcdl0muu4cvskj29df7ud9oa.apps.googleusercontent.com"
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()
        
        // Add the sign-in button.
        backButton.isHidden = true
        view.addSubview(signInButton)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        if filesStack.count == 0 {
            return
        }
        print(filesStack)
        files = filesStack.popLast()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription, doSomething: {(action: UIAlertAction) -> Void in
                //self.displayUserInfo()
            })
            self.service.authorizer = nil
        } else {
            self.signInButton.isHidden = true
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            listFiles(id: nil)
        }
    }
    
    // List up to 10 files in Drive
    func listFiles(id: String?) {
        let query = GTLRDriveQuery_FilesList.query()
        query.pageSize = 100
        //print(id)
        if id != nil {
            query.q = "mimeType = 'application/pdf' and '\(id!)' in parents or mimeType='application/vnd.google-apps.folder' and '\(id!)' in parents"
        } else {
            query.q = "mimeType = 'application/pdf' and 'root' in parents or mimeType='application/vnd.google-apps.folder' and 'root' in parents"
        }
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
        )
    }
    
    // Process the response and display output
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket, finishedWithObject result : GTLRDrive_FileList, error : NSError?) {
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription, doSomething: { (action: UIAlertAction) -> Void in
            })
        }
        if files != nil {
            //print(files?.count)
            filesStack.append(files!)
        }
        files = result.files
        //displayResult()
    }
    
    func displayResult() {
        if filesView != nil {
            filesView.removeFromSuperview()
            filesView = nil
        }
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        filesView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        filesView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        filesView.dataSource = self
        filesView.delegate = self
        filesView.allowsSelection = true
        self.view.addSubview(filesView)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        //(withIdentifier: "cell", for: indexPath)
        
        if files != nil {
            let file = files![indexPath.row]
            cell.textLabel?.text = file.name
            /*print(file.thumbnailLink)
            if file.thumbnailLink != nil {
                if let url = NSURL(string: file.thumbnailLink!) {
                    if let data = NSData(contentsOf: url as URL) {
                        cell.imageView?.image = UIImage(data: data as Data)
                    }
                }
            }*/
            if file.mimeType == "application/vnd.google-apps.folder" {
                let image = UIImage(named: "folder")
                cell.imageView?.contentMode = .scaleAspectFit
                cell.imageView?.image = image
            } else {
                cell.imageView?.image = nil
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files!.count
    }
    
    //onclick action controller for a specofoc row in the table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = files![indexPath.row]
        let id = file.identifier
        if file.mimeType == "application/vnd.google-apps.folder" {
            filesParent = file.name
            listFiles(id: id)
        } else {
            showAlert(title: "upload", message: file.name!, doSomething: { (action: UIAlertAction) -> Void in
                let query = GTLRDriveQuery_FilesGet.queryForMedia(withFileId: id!)
                self.service.executeQuery(query,
                                     delegate: self,
                                     didFinish: #selector(self.uploadToCloud(ticket:finishedWithObject:error:))
                )
            })
            //tableView.didSelectRow
            //cellForRow(at: indexPath)?.selectionStyle = UITableViewCellSelectionStyle.blue
        }
    }
    
    
    // after the file is downloaded from google drive, this method is called
    @objc func uploadToCloud(ticket: GTLRServiceTicket, finishedWithObject result : GTLRDataObject, error : NSError?) {
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription, doSomething: { (action: UIAlertAction) -> Void in
            })
        } else {
            print("downloaded \(result.contentType)")
            //print(result.contentType)
        }
    }
    
    // Helper for showing an alert
    func showAlert(title : String, message: String, doSomething: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: doSomething
        )
        let cancel = UIAlertAction(
            title: "CANCEL",
            style: UIAlertActionStyle.cancel,
            handler: nil
        )
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
