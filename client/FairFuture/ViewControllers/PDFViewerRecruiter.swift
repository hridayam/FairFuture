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
    //var id: String!
    var docURL: URL!
    //var file: GTLRDataObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        docURL = URL(string: "\(SERVER_URL)\(url!)")!
        let urlRequest = URLRequest(url: docURL)
        webView.load(urlRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: IBAction method implementation
    
}
