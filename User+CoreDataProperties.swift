//
//  User+CoreDataProperties.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/16/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var userid: String?
    @NSManaged public var email: String?
    @NSManaged public var mobile: String?

}

extension User : Identifiable {

}
