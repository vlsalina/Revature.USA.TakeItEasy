//
//  SignupConstants.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/8/22.
//

import Foundation

enum SignupErrors : Error {
   case duplicateEntry
   case invalidEmail
   case invalidMobileNo
}

enum SignupConstants : String {
    case registered = "Congrats! You're all signed up!"
    case invalidEmail = "Invalid email"
    case invalidMobileNo = "Invalid mobile number"
    case duplicateEntry = "User already exists"
    case unknownSignUpError = "Unknown sign up error"
}

