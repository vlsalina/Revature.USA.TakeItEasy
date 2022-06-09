//
//  User+CoreDataProperties.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/8/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userid: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
