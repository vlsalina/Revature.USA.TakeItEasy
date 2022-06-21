//
//  QuizConstants.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/11/22.
//

import Foundation

enum QuizKeys : Int {
    case QUIZ1 = 0
    case QUIZ2 = 1
    case QUIZ3 = 2
    case QUIZ4 = 3
}

enum QuizConstants : String {
    case notAllQuestionsAnswered = "Please answer all questions"
    case welcomeMsg = "Welcome to the Quiz page!"
    case rewardMsg = "Are you an iOS guru? Test your knowledge here! Take the Swift, Xcode, Storyboard, or Collections quizzes and earn rewards."
    case scoredLow = "Spend more time studying concepts and making projects. The road to becoming a guru is filled with challenges."
    case scoredMed = "Great job! You almost got a perfect. A bit more effort and you can become a guru."
    case scoredHigh = "Congradulations! You are a certified guru! Now go out there and make the next big thing."
}
