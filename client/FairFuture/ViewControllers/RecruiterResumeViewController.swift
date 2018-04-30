//
//  RecruiterResumeViewController.swift
//  FairFuture
//
//  Created by hridayam bakshi on 4/29/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import Foundation
import UIKit

class RecruiterResumeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
}
