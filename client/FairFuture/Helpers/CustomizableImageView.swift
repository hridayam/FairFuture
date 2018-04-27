//
//  CustomizableImageView.swift
//  FairFuture
//
//  Created by admin on 4/20/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableImageView: UIImageView {

    
    @IBInspectable var cornerRadius: CGFloat = 0  {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            
        }
    }
    
    
    
}
