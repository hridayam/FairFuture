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
    
    //    let data: Data // received from a network request, for example
    //    let json = try? JSONSerialization.jsonObject(with: data, options: [])
    
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
        //get from server then save to recruiter's files
        //request resume from server by using send: resumeID
        
        /// put obtained JSON in function below
        //let saveResume = Resume.init(json: <#T##[String : Any]#>)
        
        
    }
    
}

extension Resume{
    init?(json: [String: Any]) {
        guard let sharedWith = json["sharedwith"] as? [String],
            let uploadedBy = json["uploadedBy"] as? String,
            let fileName = json["fileName"] as? String,
            let id = json["id"] as? String,
            let fileURL = json["fileURL"] as? String
            else {
                return nil
        }
        
        self.sharedWith = sharedWith
        self.uploadedBy = uploadedBy
        self.fileName = fileName
        self.id = id
        self.fileURL = fileURL
    }
}
