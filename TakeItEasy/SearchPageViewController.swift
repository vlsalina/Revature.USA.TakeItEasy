//
//  SearchPageViewController.swift
//  TakeItEasy
//
//  Created by Matt Caulder on 6/11/22.
//

import UIKit
import WebKit

class SearchPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var webKitView = WKWebView()
        let newUrl = URL(string: "https://www.google.com")!
        webKitView.load(URLRequest(url: newUrl))
        view = webKitView
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
