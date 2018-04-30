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
    var resumeID: String?
    
    var obtainedResume = Resume.init()
    
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
        print("from recruiterpdfview")
        print(resumeID!)
        //let sendResume = PdfFileController.
//        var pfc = PdfFileController()
//        pfc.share(id: resumeID!, closure: {
//            (),_  -> Void in
//
//        })
        let pfc = PdfFileController()
        pfc.getAll(closure: {
            (resume) in
            //print(resume.count)
            print(resume)
            /*pfc.share(id: "5ae618117a67b9f3390384c1", closure: {() ->
             Void in
             print("shared")
             })*/
        })
        
        getResume(send: resumeID)
        
//        let urlRequest = URLRequest(url: docURL!)
//        print(urlRequest)
//        webView.load(urlRequest)
        
        //webView.load(getURLfromScannedQRCode())
        
        //let myURL = URL(string: file.webContentLink!)
        //let myRequest = URLRequest(url: myURL!)
        //webView.load(myRequest)
    }
    
    func getResume(send: String!){
        
        let pfc = PdfFileController()
        pfc.share(id: send, closure: {
            (resume) in
            //print(resume.count)
            print(resume.fileURL!)
            
            self.docURL = URL(string: "\(SERVER_URL)\(resume.fileURL!)")!
            let urlrequest = URLRequest.init(url: self.docURL)
            
            self.webView.load(urlrequest as URLRequest)
        })
        
    }
    
}

