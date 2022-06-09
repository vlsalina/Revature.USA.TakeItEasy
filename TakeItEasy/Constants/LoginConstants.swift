//
//  LoginErrors.swift
//  FunZoneApp
//
//  Created by Vincent Salinas on 6/1/22.
//

import Foundation

enum LoginErrors : Error {
    case invalidLoginCredentials
    case userNotFound
    case unknown
}

// login constants

enum LoginConstants : String {
    case userDefaultEmailKey = "userdefault-email"
    case invalidLoginCredentails = "Invalid email or password"
    case unknownLoginError = "Unknown login error"
    case noUserFound = "No user found"
}


