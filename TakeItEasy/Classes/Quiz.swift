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
            // Quiz
            Quiz(name: "Swift", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, details: Details(questions: [
                Question(question: "iOS Swift is a programming language developed by...", choices: [
                    Choice(choice: "Microsoft"),
                    Choice(choice: "Google"),
                    Choice(choice: "Apple"),
                    Choice(choice: "Amazon"),
                ], correctAnswer: Choice(choice: "Apple"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "What is init() in Swift?", choices: [
                    Choice(choice: "an initializer"),
                    Choice(choice: "a protocol"),
                    Choice(choice: "a class"),
                    Choice(choice: "an enum"),
                ], correctAnswer: Choice(choice: "an initializer"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "\"Let\" variables are...", choices: [
                    Choice(choice: "nil"),
                    Choice(choice: "changeable"),
                    Choice(choice: "formable"),
                    Choice(choice: "constant"),
                ], correctAnswer: Choice(choice: "constant"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "Inheritance is a mechanism for ____?", choices: [
                    Choice(choice: "functions"),
                    Choice(choice: "generics"),
                    Choice(choice: "Object Oriented Programming"),
                    Choice(choice: "building in storyboard"),
                ], correctAnswer: Choice(choice: "Object Oriented Programming"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "Objects have state and ____", choices: [
                    Choice(choice: "behaviors"),
                    Choice(choice: "encapsulation"),
                    Choice(choice: "abstraction"),
                    Choice(choice: "polymorphism"),
                ], correctAnswer: Choice(choice: "behaviors"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
            ])
            ),
            
            
            // Quiz
            Quiz(name: "XCode", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, details: Details(questions: [
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
            ])
            ),
            
            // Quiz
            Quiz(name: "Storyboard", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, details: Details(questions: [
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
            ])
            ),
            
            
            // Quiz
            Quiz(name: "Collections", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, details: Details(questions: [
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "a;slfdkjas;lkfdja;sldkfjas;ldfkja;sdlfkja;sdlfkja;sdlkfja;sldfkj", choices: [
                    Choice(choice: "a"),
                    Choice(choice: "b"),
                    Choice(choice: "c"),
                    Choice(choice: "d"),
                ], correctAnswer: Choice(choice: "a"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
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
    var correctAnswer: Choice
    var answer : Choice?
    var image : UIImage
    
    init(question: String, choices: [Choice], correctAnswer: Choice, image: UIImage) {
        self.question = question
        self.choices = choices
        self.correctAnswer = correctAnswer
        self.image = image
    }
    
    func chooseAction(a: Choice) {
        self.answer = a
    }
    
    func displayAnswer() {
        print(answer!.choice as String)
    }
    
}

class Choice {
    var choice : String
    
    init(choice: String) {
        self.choice = choice
    }
    
}




