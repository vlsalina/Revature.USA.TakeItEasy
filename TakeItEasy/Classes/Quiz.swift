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
                Question(question: "XCode was developed by...", choices: [
                    Choice(choice: "Amazon"),
                    Choice(choice: "Apple"),
                    Choice(choice: "Microsoft"),
                    Choice(choice: "Google"),
                ], correctAnswer: Choice(choice: "Apple"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "XCode is an ____", choices: [
                    Choice(choice: "protocol"),
                    Choice(choice: "class"),
                    Choice(choice: "dictionary"),
                    Choice(choice: "IDE"),
                ], correctAnswer: Choice(choice: "IDE"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "XCode is available on what platform?", choices: [
                    Choice(choice: "Linux"),
                    Choice(choice: "Windows"),
                    Choice(choice: "Mac"),
                    Choice(choice: "Nintento"),
                ], correctAnswer: Choice(choice: "Mac"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "What is an enum?", choices: [
                    Choice(choice: "user-defined type"),
                    Choice(choice: "class"),
                    Choice(choice: "protocol"),
                    Choice(choice: "function"),
                ], correctAnswer: Choice(choice: "user-defined type"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "What is MVC?", choices: [
                    Choice(choice: "Macdonalds"),
                    Choice(choice: "Model View Controller"),
                    Choice(choice: "Mechanism"),
                    Choice(choice: "Mechwarrior"),
                ], correctAnswer: Choice(choice: "Model View Controller"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
            ])
            ),
            
            // Quiz
            Quiz(name: "Storyboard", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, details: Details(questions: [
                Question(question: "What UI component is used for buttons?", choices: [
                    Choice(choice: "UILabel"),
                    Choice(choice: "UIViewController"),
                    Choice(choice: "UIButton"),
                    Choice(choice: "UIImage"),
                ], correctAnswer: Choice(choice: "UIButton"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "What UI component is used for images?", choices: [
                    Choice(choice: "UITabBarController"),
                    Choice(choice: "UILabel"),
                    Choice(choice: "UIView"),
                    Choice(choice: "UIImageView"),
                ], correctAnswer: Choice(choice: "UIImageView"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "What UI component is used for labels?", choices: [
                    Choice(choice: "UITextField"),
                    Choice(choice: "UILabel"),
                    Choice(choice: "UISwitch"),
                    Choice(choice: "UIButton"),
                ], correctAnswer: Choice(choice: "UILabel"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "What UI component is used for navigation?", choices: [
                    Choice(choice: "UITextView"),
                    Choice(choice: "UITextField"),
                    Choice(choice: "UIImageView"),
                    Choice(choice: "UINavigationBar"),
                ], correctAnswer: Choice(choice: "UINavigationBar"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "Which UI component is used for Remember Me functionality?", choices: [
                    Choice(choice: "UIImageLabel"),
                    Choice(choice: "UISwitch"),
                    Choice(choice: "UIView"),
                    Choice(choice: "UIViewController"),
                ], correctAnswer: Choice(choice: "UISwitch"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
            ])
            ),
            
            
            // Quiz
            Quiz(name: "Collections", image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!, details: Details(questions: [
                Question(question: "A dictionary contains...", choices: [
                    Choice(choice: "key-value pairs"),
                    Choice(choice: "Ints"),
                    Choice(choice: "Strings"),
                    Choice(choice: "nil"),
                ], correctAnswer: Choice(choice: "key-value pairs"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "A Set contains elements which are ____", choices: [
                    Choice(choice: "mutable"),
                    Choice(choice: "the same"),
                    Choice(choice: "unique"),
                    Choice(choice: "immutatable"),
                ], correctAnswer: Choice(choice: "unique"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "Which type of statement would you use to cycle through a collection?", choices: [
                    Choice(choice: "if-else"),
                    Choice(choice: "class"),
                    Choice(choice: "control flow"),
                    Choice(choice: "for-in"),
                ], correctAnswer: Choice(choice: "for-in"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "Array elements must be the same ____ type", choices: [
                    Choice(choice: "class"),
                    Choice(choice: "different"),
                    Choice(choice: "protocol"),
                    Choice(choice: "same"),
                ], correctAnswer: Choice(choice: "same"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
                Question(question: "Which of the following is the correct syntax for declaring an Int array?", choices: [
                    Choice(choice: "var ra = [Strings]()"),
                    Choice(choice: "var ra = [Dog]()"),
                    Choice(choice: "var ra = [Float]()"),
                    Choice(choice: "var ra = [Int]()"),
                ], correctAnswer: Choice(choice: "var ra = [Int]()"), image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
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




