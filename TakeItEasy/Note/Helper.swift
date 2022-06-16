//
//  Helper.swift
//  TakeItEasy
//
//  Created by Mihir Ghosh on 6/15/22.
//

import Foundation
import UIKit
import CoreData

class Helper{
    
    static var helper = Helper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //MARK: -
    
    func addNote(noteValue: String, titleValue: String){
        let note = NSEntityDescription.insertNewObject(forEntityName: "NoteBook", into: context!) as! NoteBook
        
        note.createdAt = Date()
        
        
        note.title = titleValue
        note.desc = noteValue
        do{
            try context?.save()
            print("Note and title saved")
        }
        catch{
            print("error!")
        }
    }
    
    func getNote() -> [NoteBook]{
        var note = [NoteBook]()
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteBook")
        do{
            note = try context?.fetch(fetchRequest) as! [NoteBook]
        }
        catch{
            print("cannot fetch data")
        }
        return note
    }
    
    func editNote(titleValue: String, cngtitle: String , noteValue: String){
        var eNote = NoteBook()
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteBook")
        fetchRequest.predicate = NSPredicate(format: "title == %@", titleValue)
        do{
            let nte = try context?.fetch(fetchRequest)
            if(nte?.count != 0){
                eNote = nte?.first as! NoteBook
                eNote.title = cngtitle  //changes title value for entity
                eNote.desc = noteValue  //changes description value for entity
                try context?.save()
                print("note edited")
            }
        }
        catch{
            print("error in edit")
        }
    }
    
    func deleteNote(noteTitle: String){
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteBook")
        fetchRequest.predicate = NSPredicate(format: "title == %@", noteTitle)
        do{
            let note = try context?.fetch(fetchRequest)
            context?.delete(note?.first as! NoteBook)
            try context?.save()
            print("data deleted")
        }
        catch{
            print("error is delete")
        }
    }
}
