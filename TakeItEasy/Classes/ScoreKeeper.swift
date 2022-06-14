//
//  ScoreKeeper.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/10/22.
//

import Foundation

class ScoreKeeper {
    
    let TOTAL : Double = 5
    var score : Double = 0
    
    func getScore(submittedQuiz: Quiz) -> (Int, Int) {
        print("Quiz submitted")
        getScoreHelper(submittedQuiz: submittedQuiz)
        return (score: Int(score), total: Int(TOTAL))
    }
    
    private func getScoreHelper(submittedQuiz: Quiz) {
        for x in submittedQuiz.details.questions {
            if (x.correctAnswer.choice == x.answer.choice) {
                score = score + 1
            }
        }
    }
    
    func percentageScore() -> Int {
        let result : Double = (score / TOTAL) * 100
        return Int(result)
    }
    
    func formatToString(submittedQuiz: Quiz) -> String {
        getScoreHelper(submittedQuiz: submittedQuiz)
        let toString = "You scored \(Int(score)) out of \(Int(TOTAL))"
        print(toString)
        return toString
    }
    
}
