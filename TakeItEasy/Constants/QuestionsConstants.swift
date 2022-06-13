//
//  QuestionsConstants.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/11/22.
//

import Foundation

enum QuestionsErrors : Error {
case notAllQuestionsAnswered
}

enum QuestionsConstants : String {
case notAllQuestionsAnswered = "Please answer all questions first"
case unknownError = "Unknown error detected"
}
