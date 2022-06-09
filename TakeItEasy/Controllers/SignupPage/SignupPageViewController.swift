//
//  SignupPageViewController.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/8/22.
//

import UIKit

class SignupPageViewController: UIViewController {
    
    @IBOutlet weak var mobileNo: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userid: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getOTP(_ sender: Any) {
        var status = false
        
        // error handling
        do {
            try validateSignUpCredentials(userid: userid.text!, email: email.text!, password: password.text!, confirmPassword: confirmPassword.text!, mobileNo: mobileNo.text!)
            status = true
        }
        catch SignupErrors.invalidUserId {
            errorLabel.text = SignupConstants.invalidUserId.rawValue
        }
        catch SignupErrors.invalidEmail {
            errorLabel.text = SignupConstants.invalidEmail.rawValue
        }
        catch SignupErrors.invalidPassword {
            errorLabel.text = SignupConstants.invalidPassword.rawValue
        }
        catch SignupErrors.invalidConfirmPassword {
            errorLabel.text = SignupConstants.invalidConfirmPassword.rawValue
        }
        catch SignupErrors.invalidMobileNo {
            errorLabel.text = SignupConstants.invalidMobileNo.rawValue
        }
        catch {
            errorLabel.text = SignupConstants.unknownSignUpError.rawValue
        }
        
        // MARK: - add user to database code here
        if (status) {
            let existingUser = DBHelperClass.dbHelper.userExists(userid: userid.text!)
            if (existingUser) {
                errorLabel.text = SignupConstants.duplicateEntry.rawValue
                return
            } else {
                errorLabel.text = SignupConstants.registered.rawValue
                
                // IMPORTANT: - NEED TO HANDLE DUPLICATE ENTRY ERROR
                DBHelperClass.dbHelper.addUser(userid: userid.text!, password: password.text!)
                print("user successfully signed up")
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
    
    
}
