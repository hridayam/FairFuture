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
        
        let data = try! Data(contentsOf: docURL)
        webView.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: docURL.deletingLastPathComponent())
    }
    
    
    @IBAction func addResume(_ sender: Any) {
        let alert = UIAlertController(
            title: "Enter Name",
            message: "",
            preferredStyle: UIAlertControllerStyle.alert
        )
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter File Name"
        })
        let ok = UIAlertAction(
            title: "SAVE",
            style: UIAlertActionStyle.default,
            handler: { alertT -> Void in
                if let fileID = alert.textFields![0].text{
                    self.savePDF(fileID: fileID)
                } else {
                    self.savePDF(fileID: "")
                }
            }
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
    
    func savePDF(fileID: String) -> Void {
        let pfc = PdfFileController()
        pfc.fileName = fileID
        pfc.file = file.data
        pfc.fileURL = docURL
        
        pfc.upload()
    }
    
    @IBAction func cancel(_ sender: Any) {
        
    }
}
