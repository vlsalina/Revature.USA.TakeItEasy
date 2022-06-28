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
    case invalidEmailFormat
    case invalidPassword
    case invalidPasswordFormat
    case invalidConfirmPassword
    case invalidConfirmPasswordFormat
    case passwordsDoNotMatch
    case invalidMobileNo
    case duplicateEntry
}

enum SignupConstants : String {
    case invalidUserId = "Invalid username"
    case invalidEmail = "Invalid email"
    case invalidEmailFormat = "Please provide valid email format"
    case invalidPassword = "Invalid password"
    case invalidPasswordFormat = "Password must have at least 1 uppercase, 1 lowercase, and 1 number"
    case invalidConfirmPassword = "Invalid confirm password"
    case passwordsDoNotMatch = "Passwords do not match"
    case invalidMobileNo = "Invalid mobile number"
    case registered = "Congrats! You're all signed up!"
    case duplicateEntry = "User already exists"
    case unknownSignUpError = "Unknown sign up error"
}

