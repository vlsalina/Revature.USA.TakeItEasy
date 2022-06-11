//
//  QuizData.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/11/22.
//

import Foundation
import UIKit

class Quiz2 {
    var name : String
    var image : UIImage
    var key : Int
    
    init(name: String, image: UIImage, key: Int) {
        self.name = name
        self.image = image
        self.key = key
    }
}

class Question2 {
    var question : String
    var image : UIImage
    var key : Int
    var correctAnswer : Int
    var usersAnswer : Int?
    
    init(question: String, image: UIImage, correctAnswer: Int, key: Int) {
        self.question = question
        self.image = image
        self.correctAnswer = correctAnswer
        self.key = key
    }
    
    func chooseAction(usersAnswer: Int) {
        self.usersAnswer = usersAnswer
    }
}

class Choice2 {
    var choice: String
    var key: Int
    
    init(choice: String, key: Int) {
        self.choice = choice
        self.key = key
    }
}


