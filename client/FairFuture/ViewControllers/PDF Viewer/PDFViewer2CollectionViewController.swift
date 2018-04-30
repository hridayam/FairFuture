//
//  PDFViewerCollectionViewController.swift
//  FairFuture
//
//  Created by admin on 4/29/18.
//  Copyright © 2018 hridayam bakshi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PDFCell"

class PDFViewerCollectionView2Controller: UICollectionViewController {
    var resumes = [Resume?]()
    var pdfList:[String] = []
    @IBOutlet var myView: UICollectionView!
    var url: String!
    var id: String!
    var refresher:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refresher = UIRefreshControl()
        myView.alwaysBounceVertical = true
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.refresher.tintColor = UIColor.red
        myView.addSubview(refresher)
        
        myView.delegate = self;
        //myView.register(NSClassFromString("PDFCell"), forCellWithReuseIdentifier: reuseIdentifier)
        loadData()
    }
    
    @objc func loadData() {
        let pfc = PdfFileController()
        pfc.getAll(closure: {
            (resume) in
            print(resume.count)
            self.pdfList = []
            for i in 0..<resume.count {
                print(resume[i]!.fileName!)
                self.resumes = resume
                
                self.pdfList.append(resume[i]!.fileName!)
            }
            print(self.pdfList)
            self.myView.reloadData()
            self.stopRefresher()         //Call this to stop refresher
        })
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    
    // Do any additional setup after loading the view.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(pdfList.count)
        return pdfList.count
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView?.indexPathForItem(at: location)
        
        if let index = indexPath {
            id = resumes[index.row]!.id!
            url = resumes[index.row]!.fileURL!
            self.performSegue(withIdentifier: "showPDF", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PDFViewerRecruiter {
            var qrvc = segue.destination as! PDFViewerRecruiter
            qrvc.id = id
            qrvc.url = url
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PDFViewer2CollectionViewCell
        
        // Configure the cell
        
        cell.pdfName.text = resumes[indexPath.row]?.fileName
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}

