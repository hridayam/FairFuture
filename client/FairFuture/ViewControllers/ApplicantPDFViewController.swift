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

class ApplicantPDFViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var docURL: URL!
    //var file: GTLRDrive_File!
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
    
    
    @IBAction func addResume(_ sender: Any) {
        let cc = CloudinaryController()
        cc.uploadFIle(url: docURL!)
    }
    
    @IBAction func cancel(_ sender: Any) {
        
    }
}
