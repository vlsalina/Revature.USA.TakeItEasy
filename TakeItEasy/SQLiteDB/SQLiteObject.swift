//
//  SQLHelper.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/11/22.
//

import Foundation
import SQLite3

class SQLiteObject {
    static var sqlObj = SQLiteObject()
    
    var Quizzes = [QuizSQLClass]()
    var Results = [Result]()
    
    // pointer to contain address
    var dbpointer : OpaquePointer?
    var dbpointer2 : OpaquePointer?
    
    //var students = [Student]()
    
    // create DB
    func createDB() {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("QuizDB.sqlite") // creates file path for db
        
        if sqlite3_open(filePath.path, &dbpointer) != SQLITE_OK {
            print("cannot open db")
        }
    }
    
    // create table
    let sqlStmt = "create table if not exists quizzes (id integer primary key autoincrement, name text, image text)"
    
    func createTable() {
        if sqlite3_exec(dbpointer, sqlStmt, nil, nil, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in table creation ")
        }
    }
    
    // create results table
    let sqlStmt2 = "create table if not exists results (id integer primary key autoincrement, name text, date text, score int)"
    
    func createResultsTable() {
        if sqlite3_exec(dbpointer2, sqlStmt2, nil, nil, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(dbpointer2)!)
            print("error in results table creation ")
        }
    }
    
    // insert data into quizzes table
    func insertData(name: NSString, image: NSString) {
        var stmt : OpaquePointer?
        let query = "insert into quizzes (name, image) values (?,?)"
        
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in query creation ", err)
        }
        
        if sqlite3_bind_text(stmt, 1, name.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in saving name ", err)
            
        }
        
        if sqlite3_bind_text(stmt, 2, image.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in saving course ", err)
            
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in table creation ", err)
        }
        
        print("data saved ")
    }
    
    // insert data into results table
    func insertResultData(name: NSString, date: NSString, score: NSNumber) {
        var stmt : OpaquePointer?
        let query = "insert into results (name, date, score) values (?,?,?)"
        
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(dbpointer2)!)
            print("error in query creation ", err)
        }
        
        if sqlite3_bind_text(stmt, 1, name.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(dbpointer2)!)
            print("error in saving name ", err)
            
        }
        
        if sqlite3_bind_text(stmt, 2, date.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(dbpointer2)!)
            print("error in saving date ", err)
            
        }
        
        if sqlite3_bind_int(stmt, 3, Int32(truncating: score)) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(dbpointer2)!)
            print("error in saving score ", err)
        }
        
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(dbpointer2)!)
            print("error in results table creation ", err)
        }
        
        print("data saved ")
    }
    
    
    
    func insertAllData(quizData: [QuizSQLClass]) {
        var stmt : OpaquePointer?
        let query = "insert into quizzes (name, image) values (?,?)"
        
        
        
        print("Count: ", quizData.count)
        
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in query creation ", err)
        }
        
        for (index, quiz) in quizData.enumerated() {
            
            // prepare id
            //            let id = Int32(index + 1)
            //            if sqlite3_bind_int(stmt, 0, id) != SQLITE_OK {
            //                let err = String(cString: sqlite3_errmsg(dbpointer)!)
            //                print("error in saving id ", err)
            //
            //            }
            
            // prepare quiz name
            let qName : NSString = quiz.name as NSString
            if sqlite3_bind_text(stmt, 1, qName.utf8String, -1, nil) != SQLITE_OK {
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in saving name ", err)
                
            }
            
            // prepare quiz image
            let qImage : NSString = quiz.image as NSString
            if sqlite3_bind_text(stmt, 2, qImage.utf8String, -1, nil) != SQLITE_OK {
                
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in saving image ", err)
                
            }
            
            if sqlite3_step(stmt) != SQLITE_DONE {
                let err = String(cString: sqlite3_errmsg(dbpointer)!)
                print("error in table creation ", err)
            }
            
            
            print("data saved ")
        }
        
    }
    
    
    func getData() -> [QuizSQLClass] {
        Quizzes.removeAll()
        let query = "select * from quizzes"
        var stmt : OpaquePointer?
        
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(dbpointer)!)
            print("error in table creation ", err)
            return Quizzes
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let image = String(cString: sqlite3_column_text(stmt, 2))
            
            Quizzes.append(QuizSQLClass(id: Int(id), name: name, image: image))
        }
        
        return Quizzes
    }
    
    func getResultsData() -> [Result] {
         Results.removeAll()
        let query = "select * from results"
        var stmt : OpaquePointer?
        
        if sqlite3_prepare(dbpointer2, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(dbpointer2)!)
            print("error in resuts table creation ", err)
            return Results
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            //let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let date = String(cString: sqlite3_column_text(stmt, 2))
            let score = sqlite3_column_int(stmt, 0)
            
            Results.append(Result(name: name, date: date, score: Int(score)))
        }
        
        return Results
       
        
    }
    
    func getOneRecord(id: Int) -> QuizSQLClass {
        let query = "select * from quizzes where id = \(id);"
        var stmt : OpaquePointer?
        var quiz : QuizSQLClass?
        
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK {
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                let id = sqlite3_column_int(stmt, 0)
                let name = String(cString: sqlite3_column_text(stmt, 1))
                let image = String(cString: sqlite3_column_text(stmt, 2))
                
                quiz = QuizSQLClass(id: Int(id), name: name, image: image)
                
            }
            
        } else {
            print("error in query")
            
        }
        
        return quiz!
    }
    
    func updateRecord(id: Int, image: NSString) {
        let query = "update quizzes SET image = '\(image)' where id = ?;"
        var stmt : OpaquePointer?
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_int(stmt, 1, Int32(id))
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("data updated")
            } else {
                print("error in updation")
            }
        } else {
            print("error in query")
        }
        sqlite3_finalize(stmt)
    }
    
    func deleteById(id: Int) {
        let query = "delete from quizzes where id = ?;"
        var stmt : OpaquePointer?
        
        if sqlite3_prepare(dbpointer, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_int(stmt, 1, Int32(id))
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("record deleted successfully")
            }
            else {
                print("can not delete record")
            }
            
        } else {
            print("problem in query")
        }
        
    }
    
}
