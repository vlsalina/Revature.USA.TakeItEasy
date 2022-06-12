//
//  QuizData.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/11/22.
//

import Foundation
import UIKit

let quizData = [
    QuizSQLClass(id: QuizKeys.QUIZ1.rawValue, name: "SWIFT", image: "pexels-gradienta-6985132"),
    QuizSQLClass(id: QuizKeys.QUIZ2.rawValue, name: "XCODE", image: "pexels-gradienta-6985260"),
    QuizSQLClass(id: QuizKeys.QUIZ3.rawValue, name: "STORYBOARD", image: "pexels-gradienta-6985047"),
    QuizSQLClass(id: QuizKeys.QUIZ4.rawValue, name: "COLLECTIONS", image: "pexels-gradienta-6985267")
]

//let questions = [
//
//    // Quiz 1 questions
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ1.rawValue, qqkey: QuizQuestionKeys.Q1.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ1.rawValue, qqkey: QuizQuestionKeys.Q2.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ1.rawValue, qqkey: QuizQuestionKeys.Q3.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ1.rawValue, qqkey: QuizQuestionKeys.Q4.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ1.rawValue, qqkey: QuizQuestionKeys.Q5.rawValue),
//
//
//    // Quiz 2 questions
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ2.rawValue, qqkey: QuizQuestionKeys.Q1.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ2.rawValue, qqkey: QuizQuestionKeys.Q2.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ2.rawValue, qqkey: QuizQuestionKeys.Q3.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ2.rawValue, qqkey: QuizQuestionKeys.Q4.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ2.rawValue, qqkey: QuizQuestionKeys.Q5.rawValue),
//
//
//
//
//    // Quiz 3 questions
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ3.rawValue, qqkey: QuizQuestionKeys.Q1.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ3.rawValue, qqkey: QuizQuestionKeys.Q2.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ3.rawValue, qqkey: QuizQuestionKeys.Q3.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ3.rawValue, qqkey: QuizQuestionKeys.Q4.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ3.rawValue, qqkey: QuizQuestionKeys.Q5.rawValue),
//
//
//
//
//    // Quiz 4 questions
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ4.rawValue, qqkey: QuizQuestionKeys.Q1.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ4.rawValue, qqkey: QuizQuestionKeys.Q2.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ4.rawValue, qqkey: QuizQuestionKeys.Q3.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ4.rawValue, qqkey: QuizQuestionKeys.Q4.rawValue),
//    Question2(question: "QUESTION", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, correctAnswer: QuizChoices.A.rawValue, qkey: QuizKeys.QUIZ4.rawValue, qqkey: QuizQuestionKeys.Q5.rawValue),
//]
//
//
//
//let choices = [
//    // For Quiz1, Quesiton1
//    Choice2(choice: "CHOICE", qkey: QuizKeys.QUIZ1.rawValue, qqkey: QuizQuestionKeys.Q1.rawValue, ckey: QuizChoices.A.rawValue)
//    Choice2(choice: "CHOICE", qkey: QuizKeys.QUIZ1.rawValue, qqkey: QuizQuestionKeys.Q1.rawValue, ckey: QuizChoices.A.rawValue)
//    Choice2(choice: "CHOICE", qkey: QuizKeys.QUIZ1.rawValue, qqkey: QuizQuestionKeys.Q1.rawValue, ckey: QuizChoices.A.rawValue)
//    Choice2(choice: "CHOICE", qkey: QuizKeys.QUIZ1.rawValue, qqkey: QuizQuestionKeys.Q1.rawValue, ckey: QuizChoices.A.rawValue)
//]




