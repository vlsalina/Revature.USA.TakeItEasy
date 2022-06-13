//
//  QuizData.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/11/22.
//

import Foundation
import UIKit

class QuizSQLClass {
    var id : Int
    var name : String
    var image : String
    
    init(id : Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}

//class Question2 {
//    var question : String
//    var image : UIImage
//    var qkey : Int
//    var qqkey : Int
//    var correctAnswer : Int
//    var usersAnswer : Int?
//
//    init(question: String, image: UIImage, correctAnswer: Int, qkey: Int, qqkey: Int) {
//        self.question = question
//        self.image = image
//        self.correctAnswer = correctAnswer
//        self.qkey = qkey
//        self.qqkey = qqkey
//    }
//
//    func chooseAction(usersAnswer: Int) {
//        self.usersAnswer = usersAnswer
//    }
//}
//
//class Choice2 {
//    var choice: String
//    var qkey: Int
//    var qqkey: Int
//    var ckey: Int
//
//    init(choice: String, qkey: Int, qqkey: Int, ckey: Int) {
//        self.choice = choice
//        self.qkey = qkey
//        self.qqkey = qqkey
//        self.ckey = ckey
//    }
//}


