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
            Quiz(name: "Quiz", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, details: Details(questions: [
                Question(question: "???", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: "a", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "???", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: "a", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "???", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: "a", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "???", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: "a", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
            ])
            ),
        ]
        
    }
    
}

class Details {
    var questions : [Question]
    
    init(questions: [Question]) {
        self.questions = questions
    }
}

class Question {
    var question : String
    var choices : [Choice]
    var correctAnswer: String
    var image : UIImage
    
    init(question: String, choices: [Choice], correctAnswer: String, image: UIImage) {
        self.question = question
        self.choices = choices
        self.correctAnswer = correctAnswer
        self.image = image
    }
}

class Choice {
    var choice : String
    
    init(choice: String) {
        self.choice = choice
    }
    
}




