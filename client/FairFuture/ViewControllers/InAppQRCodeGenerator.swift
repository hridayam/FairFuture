//
//  InAppQRCodeGenerator.swift
//  FairFuture
//
//  Created by Jonathan Doctolero on 4/27/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import GoogleAPIClientForREST

class InAppQRCodeGenerator: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var url: String!
    var id: String!
    var docURL: URL!
    var file: GTLRDataObject!
    
    @IBOutlet weak var imgQRCode: UIImageView!
    
    var qrcodeImage: CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        docURL = URL(string: "\(SERVER_URL)\(url!)")!
        var urlRequest = URLRequest(url: docURL)
        webView.load(urlRequest)
        createQRCode(data: id)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: IBAction method implementation
    
///*** CREATE QR CODE HERE *** \\\
    //it doesn't have to be a utton
    func createQRCode(data: String){
        if qrcodeImage == nil {
            let data = data.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            //generate QR code
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel") //qr code setting
            
            qrcodeImage = filter?.outputImage
            
            displayQRCodeImage()
            }
        else {
            imgQRCode.image = nil
            qrcodeImage = nil
            }
        
    }
    
    
    // MARK: Custom method implementation
    
    func displayQRCodeImage() {
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        imgQRCode.image = UIImage(ciImage: transformedImage)
                
    }
    //TODO: Save QR Code CIImage
    
}
