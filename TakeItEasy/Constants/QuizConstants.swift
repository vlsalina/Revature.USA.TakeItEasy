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

enum QuizChoices : Int {
    case A = 0
    case B = 1
    case C = 2
    case D = 3
}

enum QuizErrors : Error {
    case notAllQuestionsAnswered
}

enum QuizConstants : String {
    case notAllQuestionsAnswered = "Please answer all questions"
}
