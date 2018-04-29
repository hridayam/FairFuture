//
//  RecruiterPDFViewController.swift
//  FairFuture
//
//  Created by Jonathan Doctolero on 4/28/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import WebKit
import GoogleAPIClientForREST

class RecruiterPDFViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var docURL: URL! //URL requested from database
    
    // use from the databse?
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"document" ofType:@"pdf"];
    //NSURL *targetURL = [NSURL fileURLWithPath:path];
    //NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    //[webView loadRequest:request];
    
    var file: GTLRDataObject!
    
    /*override func loadView() {
     let webConfiguration = WKWebViewConfiguration()
     webView = WKWebView(frame: .zero, configuration: webConfiguration)
     webView.uiDelegate = self
     //view = webView
     }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let pdfFilePath = Bundle.main.url(forResource: "resume", withExtension: "pdf")
        let urlRequest = URLRequest(url: docURL!)
        print(urlRequest)
        webView.load(urlRequest)
        //let myURL = URL(string: file.webContentLink!)
        //let myRequest = URLRequest(url: myURL!)
        //webView.load(myRequest)
    }
    
//
//    @IBAction func addResume(_ sender: Any) {
//        let alert = UIAlertController(
//            title: "Enter Name",
//            message: "",
//            preferredStyle: UIAlertControllerStyle.alert
//        )
//        alert.addTextField(configurationHandler: { (textField) in
//            textField.placeholder = "Enter File Name"
//        })
//        let ok = UIAlertAction(
//            title: "SAVE",
//            style: UIAlertActionStyle.default,
//            handler: { alertT -> Void in
//                if let fileID = alert.textFields![0].text{
//                    self.savePDF(fileID: fileID)
//                } else {
//                    self.savePDF(fileID: "")
//                }
//        }
//        )
//        let cancel = UIAlertAction(
//            title: "CANCEL",
//            style: UIAlertActionStyle.cancel,
//            handler: nil
//        )
//        alert.addAction(ok)
//        alert.addAction(cancel)
//        present(alert, animated: true, completion: nil)
//    }
    
    
}
