//
//  NoteBook+CoreDataProperties.swift
//  TakeItEasy
//
//  Created by Mihir Ghosh on 6/15/22.
//
//

import Foundation
import CoreData


extension NoteBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteBook> {
        return NSFetchRequest<NoteBook>(entityName: "NoteBook")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var desc: String?
    @NSManaged public var title: String?

}

extension NoteBook : Identifiable {

}
