//
//  LoginPageViewController.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/8/22.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var box1: UIView!
    @IBOutlet weak var useridField: UITextField! {
        didSet {
            let placeholderText = NSAttributedString(string: "Username",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            useridField.attributedPlaceholder = placeholderText
        }
    }
    @IBOutlet weak var passwordField: UITextField! {
        didSet {
            let placeholderText = NSAttributedString(string: "Password",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            passwordField.attributedPlaceholder = placeholderText
        }
        
    }
    @IBOutlet weak var rememberMe: UISwitch!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialize()
    }
    
    func initialize() {
        if (userDefaults.bool(forKey: "remember")) {
            let useridDefault = userDefaults.string(forKey: LoginConstants.userDefaultEmailKey.rawValue)
            let passDefault = RememberMeHelper.get(userid: useridDefault!)
            
            if (useridDefault != nil) {
                useridField.text = useridDefault
                passwordField.text = passDefault
                rememberMe.isOn = true
            }
        } else {
            useridField.text = ""
            passwordField.text = ""
            rememberMe.isOn = false
        }
        roundedCorners(&box1)
        
        addBorderColor(&useridField)
        addBorderColor(&passwordField)
    }
    
    
    @IBAction func login(_ sender: Any) {
        
        // error handling for login credentials
        do {
            try validateLoginCredentials(userid: useridField.text!, password: passwordField.text!)
        } catch LoginErrors.invalidLoginCredentials {
            errorLabel.text = LoginConstants.invalidLoginCredentails.rawValue
            return
        } catch {
            errorLabel.text = LoginConstants.unknownLoginError.rawValue
            return
        }
        
        // MARK: - implement code to check user against users database
        var existingUser = User()
        
        do {
            existingUser = try DBHelperClass.dbHelper.getUser(userid: useridField.text!)
        } catch LoginErrors.userNotFound {
            errorLabel.text = LoginConstants.noUserFound.rawValue
        } catch {
            errorLabel.text = LoginConstants.unknownLoginError.rawValue
        }
        
        if (DBHelperClass.flag) {
            if (useridField.text == existingUser.userid && passwordField.text == existingUser.password) {
                // remember user
                if (rememberMe.isOn) {
                    userDefaults.set(rememberMe.isOn, forKey: "remember")
                    RememberMeHelper.save(userid: useridField.text!, password: passwordField.text!)
                } else {
                    userDefaults.set(false, forKey: "remember")
                }
                
                // save current user details
                userLoggedIn(existingUser: existingUser)
                
                errorLabel.text = ""
                self.performSegue(withIdentifier: "TabSegue1", sender: self)
                
                
            } else {
                errorLabel.text = LoginConstants.invalidLoginCredentails.rawValue
            }
        }
        
        
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

