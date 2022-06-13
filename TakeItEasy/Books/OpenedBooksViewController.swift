//
//  OpenedBooksViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/8/22.
//

import UIKit
import WebKit

class OpenedBooksViewController: UIViewController {
    @IBOutlet weak var bookView: UIView!
    var urlString = ""
    var previewUrlString = ""
    var bookID = ""
    var bookTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(bookID, bookTitle)
        bookTitle = bookTitle.replacingOccurrences(of: " ", with: "_")
        urlString = "https://www.google.com/books/edition/" + bookTitle + "/" + bookID + "?hl=en&gbpv=1"
        print(urlString)
        let newURL = URL(string : urlString)
        let webKitView = WKWebView(frame: bookView.bounds)
        webKitView.load(URLRequest(url: newURL!))
        bookView.addSubview(webKitView)
    }

}
