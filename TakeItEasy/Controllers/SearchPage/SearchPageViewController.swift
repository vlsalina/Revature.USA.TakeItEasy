//
//  SearchPageViewController.swift
//  TakeItEasy
//
//  Created by Matt Caulder on 6/11/22.
//

import UIKit
import WebKit

class SearchPageViewController: UIViewController {
    
    @IBOutlet weak var navbar: UINavigationBar!
    
    private var webKitView: WKWebView?
    let newUrl = URL(string: "https://www.google.com")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webKitView = WKWebView()
        webKitView!.load(URLRequest(url: newUrl))
        view = webKitView
        configureNavbar()
    }
    
    func configureNavbar() {
        let userid = userDefaults.string(forKey: "currentUserName")
        self.navigationItem.title = userid
        
        let refresh = UIImage(systemName: "arrow.clockwise")
        let previous = UIImage(systemName: "chevron.backward")
        
        let refreshBTN = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(didTapRefresh))
        let previousBTN = UIBarButtonItem(image: previous, style: .plain, target: self, action: #selector(didTapPrevious))
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationItem.leftBarButtonItems = [previousBTN, refreshBTN]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutAction))
    }
    
    @objc private func didTapRefresh() {
        webKitView!.load(URLRequest(url: newUrl))
    }
    
    @objc private func didTapPrevious() {
        webKitView!.goBack()
    }
    
    @objc func logoutAction() {
        userLoggedOut()
        segueToVC(target: SIDs.LoginPageVC.rawValue, sender: self)
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
