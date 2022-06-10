//
//  Quizzes.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/9/22.
//

import Foundation
import UIKit

class Quiz {
    
    
    var name : String
    var image : UIImage
    var details : Details
    
    init(name: String, image: UIImage, details: Details) {
        self.name = name
        self.image = image
        self.details = details
    }
    
    static func FetchQuizzes() -> [Quiz] {
        return [
            Quiz(name: "Quiz", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, details: Details(correctAnswer: "a", questions: [
                Question(question: "a"),
                Question(question: "b"),
                Question(question: "c"),
                Question(question: "d"),
            ])),
            Quiz(name: "Quiz", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, details: Details(correctAnswer: "a", questions: [
                Question(question: "a"),
                Question(question: "b"),
                Question(question: "c"),
                Question(question: "d"),
            ])),
            Quiz(name: "Quiz", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, details: Details(correctAnswer: "a", questions: [
                Question(question: "a"),
                Question(question: "b"),
                Question(question: "c"),
                Question(question: "d"),
            ])),
            Quiz(name: "Quiz", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, details: Details(correctAnswer: "a", questions: [
                Question(question: "a"),
                Question(question: "b"),
                Question(question: "c"),
                Question(question: "d"),
            ])),
            
        ]
        
    }
    
}

class Details {
    var correctAnswer : String
    var questions : [Question]
    
    init(correctAnswer: String, questions: [Question]) {
        self.correctAnswer = correctAnswer
        self.questions = questions
    }
}

class Question {
    var question : String
    
    init(question: String) {
        self.question = question
    }
}




