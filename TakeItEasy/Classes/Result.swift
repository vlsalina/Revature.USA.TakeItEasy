//
//  Result.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/13/22.
//

import Foundation

class Result {
    var name : String
    var date : String
    var score : Int
    
    init(name: String, date: String, score: Int) {
        self.name = name
        self.date = date
        self.score = score
    }
}
