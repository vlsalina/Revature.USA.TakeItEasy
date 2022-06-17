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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavbar()
    }
    
    func configureNavbar() {
        let userid = userDefaults.string(forKey: "currentUserName")
        self.navigationItem.title = userid
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutAction))
    }
    
    @objc func logoutAction() {
        userLoggedOut()
        dismiss(animated: true)
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
