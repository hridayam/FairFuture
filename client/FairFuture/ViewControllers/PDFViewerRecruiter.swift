//
//  File.swift
//  FairFuture
//
//  Created by admin on 4/30/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import GoogleAPIClientForREST

class PDFViewerRecruiter: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var url: String!
    var id: String!
    var docURL: URL!
    var file: GTLRDataObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        docURL = URL(string: url)!
        let data = try! Data(contentsOf: docURL)
        webView.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: docURL.deletingLastPathComponent())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: IBAction method implementation
    
}
