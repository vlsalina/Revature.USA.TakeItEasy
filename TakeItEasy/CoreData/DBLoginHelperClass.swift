//
//  DBHelperClass.swift
//  CoreDataDemo
//
//  Created by Vincent Salinas on 5/31/22.
//

import Foundation
import UIKit
import CoreData

class DBHelperClass {
    
    static var dbHelper = DBHelperClass()
    static var flag : Bool = false
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func addUser(userid: String, password: String, email: String, mobile: String) {
        
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        
        user.userid = userid
        user.password = password
        user.email = email
        user.mobile = mobile
        
        do {
            try context?.save()
            print("data saved successfully")
        } catch {
            print("data save unsuccessful")
            print(error.localizedDescription)
        }
    }
    
    func getUser(userid: String) throws -> User {
        var user = User()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "userid == %@", userid)
        
        fetchRequest.fetchLimit = 1
        let request = try context?.fetch(fetchRequest) as! [User]
        if (request.count != 0) {
            user = request.first!
            DBHelperClass.flag = true
        } else {
            DBHelperClass.flag = false
            throw LoginErrors.userNotFound
        }
        
        return user
        
    }
    
    
    func userExists(userid: String) -> Bool {
        
        var status = false
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "userid == %@", userid)
        
        fetchRequest.fetchLimit = 1
        do {
            let request = try context?.fetch(fetchRequest) as! [User]
            if (request.count != 0) {
                //                user = request.first!
                status = true
            } else {
                print("No student found")
            }
        } catch {
            print("Error detected")
        }
        
        return status
        
    }
    
    func deleteUser(userid: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "userid == %@", userid)
        do {
            let user = try context?.fetch(fetchRequest)
            context?.delete(user?.first as! User)
            try context?.save()
            print("Delete successful")
        } catch {
            print("Error detected")
        }
    }
    
}

