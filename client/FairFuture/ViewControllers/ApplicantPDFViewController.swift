//
//  ApplicantPDFViewController.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/22/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import GoogleAPIClientForREST

class ApplicantPDFViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var file: GTLRDrive_File!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: file.webViewLink)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    
    @IBAction func addResume(_ sender: Any) {
        
    }
    @IBAction func cancel(_ sender: Any) {
        
    }
}
