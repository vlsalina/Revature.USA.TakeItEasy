//
//  GooglePageViewController.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/15/22.
//

import UIKit
import WebKit

class GooglePageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let webKitView = WKWebView()
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
