//
//  Helpers.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/8/22.
//

import Foundation
import UIKit

let userDefaults = UserDefaults.standard

// validate login credentials
internal func validateLoginCredentials(userid: String, password: String) throws {
    
    guard (!userid.isEmpty) else {
        throw LoginErrors.invalidLoginCredentials
    }
    
    guard (!password.isEmpty) else {
        throw LoginErrors.invalidLoginCredentials
    }
    
}

// validate signup credentials
func validateSignUpCredentials(userid: String, email: String, password: String, confirmPassword: String, mobileNo: String) throws {
    
    guard (!userid.isEmpty) else {
        throw SignupErrors.invalidUserId
    }
    
    guard (!email.isEmpty) else {
        throw SignupErrors.invalidEmail
    }
    
    guard (!password.isEmpty) else {
        throw SignupErrors.invalidPassword
    }
    
    guard (!confirmPassword.isEmpty) else {
        throw SignupErrors.invalidConfirmPassword
    }
    
    guard (!mobileNo.isEmpty) else {
        throw SignupErrors.invalidMobileNo
    }
    
    guard (password == confirmPassword) else {
        throw SignupErrors.passwordsDoNotMatch
    }
    
}




