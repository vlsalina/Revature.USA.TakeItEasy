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
    
    guard (isValidEmail(email)) else {
        throw SignupErrors.invalidEmailFormat
    }
    
    guard (!password.isEmpty) else {
        throw SignupErrors.invalidPassword
    }
    
    guard (isValidPassword(password)) else {
        throw SignupErrors.invalidPasswordFormat
    }
    
    guard (!confirmPassword.isEmpty) else {
        throw SignupErrors.invalidConfirmPassword
    }
    
    guard (isValidPassword(confirmPassword)) else {
        throw SignupErrors.invalidPasswordFormat
    }
    
    guard (!mobileNo.isEmpty) else {
        throw SignupErrors.invalidMobileNo
    }
    
    guard (password == confirmPassword) else {
        throw SignupErrors.passwordsDoNotMatch
    }
    
}

// validate email format
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

// ^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$

// validate password format
func isValidPassword(_ password: String) -> Bool {
    let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6}$"
    
    let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
    return passwordPred.evaluate(with: password)
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

// get target
func getTarget(target: String) -> UIViewController {
    let storyObject = UIStoryboard(name: "Main", bundle: nil)
    let targetVC = storyObject.instantiateViewController(withIdentifier: target)
    return targetVC
}


// round corners
func roundedCorners(_ param: inout UIView) {
    param.layer.cornerRadius = 15
}

func userLoggedIn(existingUser: User) {
    userDefaults.set(existingUser.userid!, forKey: "currentUserName")
//    userDefaults.set(existingUser.email!, forKey: "currentUserEmail")
//    userDefaults.set(existingUser.mobile!, forKey: "currentUserMobile")
}

func userLoggedOut() {
    userDefaults.removeObject(forKey: "currentUserName")
    userDefaults.removeObject(forKey: "currentUserEmail")
    userDefaults.removeObject(forKey: "currentUserMobile")
}

// get hours, minutes, and seconds
func getHoursMinutesSecondsFrom(seconds: Double) -> (hours: Int, minutes: Int, seconds: Int) {
    let secs = Int(seconds)
    let hours = secs / 3600
    let minutes = (secs % 3600) / 60
    let seconds = (secs % 3600) % 60
    return (hours, minutes, seconds)
}

// format time
func formatTimeFor(seconds: Double) -> String {
    let result = getHoursMinutesSecondsFrom(seconds: seconds)
    let hoursString = "\(result.hours)"
    var minutesString = "\(result.minutes)"
    if minutesString.count == 1 {
        minutesString = "0\(result.minutes)"
    }
    var secondsString = "\(result.seconds)"
    if secondsString.count == 1 {
        secondsString = "0\(result.seconds)"
    }
    var time = "\(hoursString):"
    if result.hours >= 1 {
        time.append("\(minutesString):\(secondsString)")
    }
    else {
        time = "\(minutesString):\(secondsString)"
    }
    return time
}


