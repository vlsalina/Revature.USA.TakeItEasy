//
//  OpenedBooksViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/8/22.
//

import UIKit
import WebKit
import PDFKit

class OpenedBooksViewController: UIViewController {
    //using the preview url will go to the classics style google books website
    //in order to use the new google books website (which has a more modern layout), the book title and bookid are added to a known url
    @IBOutlet weak var bookView: UIView!
    var bookAPIStatus = true
    var urlString = ""
    var previewUrlString = ""
    var bookID = ""
    var bookTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        if bookAPIStatus{
            openUsingAPIBooks()
        }
        else{
            openUsingLocalBooks()
        }
    }

    func openUsingAPIBooks(){
        bookTitle = bookTitle.replacingOccurrences(of: " ", with: "_")
        urlString = "https://www.google.com/books/edition/" + bookTitle + "/" + bookID + "?hl=en&gbpv=1"
        let newURL = URL(string : urlString)
        let webKitView = WKWebView(frame: bookView.bounds)
        webKitView.load(URLRequest(url: newURL!))
        bookView.addSubview(webKitView)    }

    func openUsingLocalBooks(){
        let pdfView = PDFView(frame: bookView.bounds)
        bookView.addSubview(pdfView)
        pdfView.autoScales = true
        let filePath = Bundle.main.url(forResource: bookTitle, withExtension: "pdf")
        pdfView.document = PDFDocument(url : filePath!)
    }
}
