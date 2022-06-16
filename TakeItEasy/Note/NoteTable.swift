//
//  NoteTable.swift
//  TakeItEasy
//
//  Created by Mihir Ghosh on 6/15/22.
//

import UIKit

class NoteTable: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //[NoteBook] is just the like gift box that is not opened
    var notes = [NoteBook]()
    var filter : [NoteBook] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        //this is like the gift box opened and u know whats inside
        notes = Helper.helper.getNote()
        filter = notes

        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        notes = Helper.helper.getNote()
        self.tableView.reloadData()
        print("view will appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        //super.viewDidAppear(animated)
        notes = Helper.helper.getNote()
        self.tableView.reloadData()
        print("view did appear")
    }
    
    @IBAction func addRow(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let notePage = storyBoard.instantiateViewController(withIdentifier: "notePage") as! NotePage
        //Helper.helper.addNote(noteValue: "", titleValue: "")
        //self.present(notePage, animated: true, completion: nil)
        navigationController?.pushViewController(notePage, animated: true)
        
    }
    

}
extension NoteTable : UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteCell
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        
        cell.noteTitle.text = notes[indexPath.row].title
        cell.noteDesc.text = notes[indexPath.row].desc
        
        cell.timeLabel.text = dateFormatter.string(from: notes[indexPath.row].createdAt!)
        cell.timeLabel.textColor = UIColor.systemGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let notePage = storyBoard.instantiateViewController(withIdentifier: "notePage") as! NotePage
        
        notePage.originalTitle = notes[indexPath.row].title!
        notePage.originalDesc = notes[indexPath.row].desc!
        
        // Works only with navigation controller
        self.navigationController?.pushViewController(notePage, animated: true)
        //present(notePage, animated: true, completion: nil)
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == ""){
            notes = filter
        }
        else{
            notes = filter.filter({
                //$0 means current index in filter similar to saying (for index in filter)
                //filter is a higher ordered function where the for loop is built in
                $0.title!.lowercased().contains(searchBar.text!.lowercased())
            })
        }
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        guard editingStyle == .delete
        else { return }
        let noteToDelete = notes.remove(at: indexPath.row)
        //personToDelete is NoteBook
        Helper.helper.context!.delete(noteToDelete)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        do{
            try Helper.helper.context!.save()
        }
        catch{}
    }
    
    
}

