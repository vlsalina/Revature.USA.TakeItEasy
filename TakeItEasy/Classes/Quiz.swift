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
    var correctAnswer : String
    var choices : [String]
    var image : UIImage
    
    init(name: String, correctAnswer: String, choices: [String], image: UIImage) {
        self.name = name
        self.correctAnswer = correctAnswer
        self.choices = choices
        self.image = image
    }
    
    static func FetchQuizzes() -> [Quiz] {
        return [
            Quiz(name: "Quiz1", correctAnswer: "correct", choices: ["a", "b", "c", "d"], image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
            Quiz(name: "Quiz1", correctAnswer: "correct", choices: ["a", "b", "c", "d"], image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
            Quiz(name: "Quiz1", correctAnswer: "correct", choices: ["a", "b", "c", "d"], image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
            Quiz(name: "Quiz1", correctAnswer: "correct", choices: ["a", "b", "c", "d"], image: UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")!),
        ]
    }
    
    

    
}


