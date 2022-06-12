//
//  SQLHelpers.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/11/22.
//

import Foundation

func getData() -> [QuizSQLClass] {
    return SQLiteObject.sqlObj.getData()
}

func viewData() {
    let result = SQLiteObject.sqlObj.getData()
    for q in result {
        print("\(q.id) -- \(q.name)")
    }
}

func getQuiz(id: Int) -> QuizSQLClass {
    return SQLiteObject.sqlObj.getOneRecord(id: id)
}

func deleteOne(id: Int) {
    SQLiteObject.sqlObj.deleteById(id: id)
}

func deleteAllData() {
    let db = getData()
    for (index, quiz) in db.enumerated() {
        SQLiteObject.sqlObj.deleteById(id: (index + 1))
    }
    print("Deleted all records successful")
}

func insertAllData() {
    for (index, x) in quizData.enumerated() {
        SQLiteObject.sqlObj.insertData(name: x.name as NSString, image: x.image as NSString)
    }
}

func initializeSQLite() {
    SQLiteObject.sqlObj.createDB()
    SQLiteObject.sqlObj.createTable()
    
    // insert quiz data if it doesn't already exist in db
    if (!userDefaults.bool(forKey: SQLiteConstants.SQL.rawValue)) {
        insertAllData()
        userDefaults.set(true, forKey: SQLiteConstants.SQL.rawValue)
    }
}




