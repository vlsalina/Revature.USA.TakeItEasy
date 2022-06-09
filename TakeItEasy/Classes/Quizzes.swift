//
//  Quizzes.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/9/22.
//

import Foundation
import UIKit

class Quizzes {
    
    var q1 : Quiz
    var q2 : Quiz
    var q3 : Quiz
    var q4 : Quiz
    
    init(q1: Quiz, q2: Quiz, q3: Quiz, q4: Quiz) {
        self.q1 = q1
        self.q2 = q2
        self.q3 = q3
        self.q4 = q4
    }
    
    static func FetchQuizzes() -> [Quiz] {
        
        return [
            Quiz(name: "quiz1", questions: [
                Question(question: "???", choices: Choices(answers: ["a", "b", "c", "d"]), correctAnswer: "a"),
                Question(question: "???", choices: Choices(answers: ["a", "b", "c", "d"]), correctAnswer: "a"),
                Question(question: "???", choices: Choices(answers: ["a", "b", "c", "d"]), correctAnswer: "a"),
                Question(question: "???", choices: Choices(answers: ["a", "b", "c", "d"]), correctAnswer: "a"),
            ], image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
            
        ]
    }
}

struct Quiz {
    var name : String
    var image : UIImage
    var questions : [Question]
    
    init(name: String, questions: [Question], image: UIImage) {
        self.name = name
        self.questions = questions
        self.image = image
    }
}

struct Question {
    var question : String
    var choices : Choices
    var correctAnswer : String
    init(question: String, choices: Choices, correctAnswer: String) {
        self.question = question
        self.choices = choices
        self.correctAnswer = correctAnswer
    }
}

struct Choices {
    var answers : [String]
    
    init(answers: [String]) {
        self.answers = answers
    }
}


