//
//  ResultsPageViewController.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/13/22.
//

import UIKit

class ResultsPageViewController: UIViewController {
    
    @IBOutlet weak var resultsTable: UITableView!
    
    var results = SQLiteObject.sqlObj.getResultsData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        resultsTable.dataSource = self
        configureNavbar()
    }
    
    func configureNavbar() {
        let userid = userDefaults.string(forKey: "currentUserName")
        self.navigationItem.title = userid
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Quiz", style: .done, target: self, action: #selector(toResultsPage))
    }
    
    @objc func logoutAction() {
        userLoggedOut()
        dismiss(animated: true)
    }
    
    @objc func toResultsPage() {
        dismiss(animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ResultsPageViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTable.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultsTableViewCell
        
        let i = indexPath.row
        
        cell.indexLabel.text = String(i)
        cell.quizLabel.text = results[i].name
        cell.dateLabel.text = results[i].date
        cell.scoreLabel.text = String(results[i].score)
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
