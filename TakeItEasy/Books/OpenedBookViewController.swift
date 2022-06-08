//
//  OpenedBookViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/8/22.
//

import UIKit
import PDFKit

class OpenedBookViewController: UIViewController {
    @IBOutlet weak var bookView: UIView!
    var bookFileName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openBookPDF()
    }
    
    func openBookPDF(){
        let pdfView = PDFView(frame: bookView.bounds)
        bookView.addSubview(pdfView)
        pdfView.autoScales = true
        let filePath = Bundle.main.url(forResource: bookFileName, withExtension: "pdf")
        pdfView.document = PDFDocument(url : filePath!)
    }
}
