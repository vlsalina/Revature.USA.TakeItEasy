//
//  SignupPageViewController.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/8/22.
//

import UIKit

class SignupPageViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var mobileNoField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var useridField: UITextField!
    @IBOutlet weak var box1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialize()
    }
    
    func initialize() {
        errorLabel.text = ""
    }
    
    @IBAction func signup(_ sender: Any) {
        var status = false
        
        // error handling
        do {
            try validateSignUpCredentials(userid: useridField.text!, password: passwordField.text!, confirmPassword: confirmPasswordField.text!)
            status = true
        } catch LoginErrors.invalidLoginCredentials {
            
            errorLabel.text = LoginConstants.invalidLoginCredentails.rawValue
        } catch LoginErrors.passwordsDoNotMatch {
            errorLabel.text = LoginConstants.passwordsDoNotMatch.rawValue
        } catch {
            errorLabel.text = SignupConstants.unknownSignUpError.rawValue
        }
        
        // MARK: - add user to database code here
        if (status) {
            let existingUser = DBHelperClass.dbHelper.userExists(userid: useridField.text!)
            if (existingUser) {
                errorLabel.text = SignupConstants.duplicateEntry.rawValue
                return
            } else {
                errorLabel.text = SignupConstants.registered.rawValue
                
                // IMPORTANT: - NEED TO HANDLE DUPLICATE ENTRY ERROR
                DBHelperClass.dbHelper.addUser(userid: useridField.text!, password: passwordField.text!)
                print("user successfully signed up")
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
