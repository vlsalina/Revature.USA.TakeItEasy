//
//  ForumPageViewController.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/15/22.
//

import UIKit
import WebKit

class ForumPageViewController: UIViewController, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "loginA" {
            print("getting msg from webpage ", message.body)
        }
    }
    
    var webView : WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setWebView()
        
        view.addSubview(webView!)
        
        if let url = URL(string: "file:///Users/vince/Downloads/resource/index.html") {
            let request = URLRequest(url: url)
            webView?.load(request)
            
        }
    }
    
    func setWebView() {
        let wkuContentController = WKUserContentController()
        
        let userScript = WKUserScript(source: "mobileHeader('Take It Easy, and welcome to our forum page!')", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        wkuContentController.addUserScript(userScript)
        wkuContentController.add(self, name: "loginA")
        let wkWVConfig = WKWebViewConfiguration()
        wkWVConfig.userContentController = wkuContentController
        webView = WKWebView(frame: self.view.bounds, configuration: wkWVConfig)
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
