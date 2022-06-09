//
//  SignupConstants.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/8/22.
//

import Foundation

enum SignupErrors : Error {
    case invalidUserId
    case invalidEmail
    case invalidPassword
    case invalidConfirmPassword
    case passwordsDoNotMatch
    case invalidMobileNo
    case duplicateEntry
}

enum SignupConstants : String {
    case invalidUserId = "Invalid userid"
    case invalidEmail = "Invalid email"
    case invalidPassword = "Invalid password"
    case invalidConfirmPassword = "Invalid confirm password"
    case passwordsDoNotMatch = "Passwords do not match"
    case invalidMobileNo = "Invalid mobile number"
    case registered = "Congrats! You're all signed up!"
    case duplicateEntry = "User already exists"
    case unknownSignUpError = "Unknown sign up error"
}

