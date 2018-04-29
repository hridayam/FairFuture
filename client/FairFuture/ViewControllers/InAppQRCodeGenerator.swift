//
//  InAppQRCodeGenerator.swift
//  FairFuture
//
//  Created by Jonathan Doctolero on 4/27/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation
import UIKit

class InAppQRCodeGenerator: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var imgQRCode: UIImageView!
    
    var qrcodeImage: CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: IBAction method implementation
    
///*** CREATE QR CODE HERE *** \\\
    //it doesn't have to be a utton
    @IBAction func performButtonAction(sender: AnyObject) {
        if qrcodeImage == nil {
            if textField.text == "" {
                return
            }
            
            //data to be converted into a QR code
            //data is to be converted into a QR CODE
            // qr code    STRING       //need this
            let data = textField.text?.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            //generate QR code
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel") //qr code setting
            
            qrcodeImage = filter?.outputImage
            
            textField.resignFirstResponder()
            
            btnAction.setTitle("Clear", for: UIControlState.normal)
            
            displayQRCodeImage()
        }
        else {
            imgQRCode.image = nil
            qrcodeImage = nil
            btnAction.setTitle("Generate", for: UIControlState.normal)
        }
        
    
        textField.isEnabled = !textField.isEnabled
        
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
