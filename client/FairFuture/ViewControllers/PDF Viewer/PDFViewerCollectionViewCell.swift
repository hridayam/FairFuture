//
//  PDFViewerCollectionViewCell.swift
//  FairFuture
//
//  Created by admin on 4/29/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import UIKit

class PDFViewerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pdfImage: UIImageView? =  UIImageView(image: #imageLiteral(resourceName: "PDFIcon"))
    
    @IBOutlet weak var pdfName: UILabel!
}
