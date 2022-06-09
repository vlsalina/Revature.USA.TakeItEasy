//
//  SignupConstants.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/8/22.
//

import Foundation

enum SignupErrors : Error {
   case duplicateEntry
}

enum SignupConstants : String {
    case registered = "Congrats! You're all signed up!"
    case duplicateEntry = "User already exists"
    case unknownSignUpError = "Unknown sign up error"
}

