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

// validate questions submission
func validateQuestions(quiz: Quiz) throws {
    for q in quiz.details.questions {
        if (q.answer.choice == "") {
            throw QuestionsErrors.notAllQuestionsAnswered
        }
    }
}

// get current date in yyyy-mm-dd string format
func getDate() -> String {
    let d = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    let yearString = dateFormatter.string(from: d)
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.month,.day], from: d)
    let dayOfMonth = components.day
    let month = components.month
    
    return "\(yearString)-\(month!)-\(dayOfMonth!)"
}

// segue helper
func segueToVC(target: String, sender: AnyObject) {
    let storyObject = UIStoryboard(name: "Main", bundle: nil)
    let targetVC = storyObject.instantiateViewController(withIdentifier: target)
    sender.present(targetVC, animated: true, completion: nil)
}


// round corners
func roundedCorners(_ param: inout UIView) {
    param.layer.cornerRadius = 15
}



