//
//  ResultsPageViewController.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/13/22.
//

import UIKit

class ResultsPageViewController: UIViewController {
    
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var redeemBTN: UIButton!
    
    var results = SQLiteObject.sqlObj.getResultsData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        resultsTable.dataSource = self
        initialize()
        configureNavbar()
    }
    
    func initialize() {
        redeemBTN.setTitle(redeemHelper().1, for: .normal)
    }
    
    func configureNavbar() {
        let userid = userDefaults.string(forKey: "currentUserName")
        self.navigationItem.title = userid
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Quiz", style: .done, target: self, action: #selector(toResultsPage))
    }
    
    @IBAction func redeemAction(_ sender: Any) {
        if (redeemHelper().0 != 0) {
            showAlert()
        }
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

extension ResultsPageViewController {
    func redeemHelper() -> (Int, String) {
        var total = 0
        
        for x in results {
            if (x.name == "Swift" && x.score == 100) { total = total + 100 }
            if (x.name == "XCode" && x.score == 100) { total = total + 100 }
            if (x.name == "Storyboard" && x.score == 100) { total = total + 100 }
            if (x.name == "Collections" && x.score == 100) { total = total + 100 }
        }
        
        if (total == 400) { return (RankConstants.guru.rawValue, ResultsConstants.gold.rawValue)}
        else if (total == 300) { return (RankConstants.senior.rawValue, ResultsConstants.green.rawValue)}
        else if (total == 200) { return (RankConstants.junior.rawValue, ResultsConstants.orange.rawValue)}
        else if (total == 100) { return (RankConstants.entry.rawValue, ResultsConstants.red.rawValue)}
        else { return (RankConstants.lo.rawValue, ResultsConstants.lo.rawValue)}
    }
    
    
    func showAlert() {
        let asd = redeemHelper()
        var msg = ""
        switch (asd.0) {
        case RankConstants.entry.rawValue:
            msg = "Red Star reward redeemed"
        case RankConstants.junior.rawValue:
            msg = "Orange Star reward redeemed"
        case RankConstants.senior.rawValue:
            msg = "Green Star reward redeemed"
        case RankConstants.guru.rawValue:
            msg = "Gold Star reward redeemed"
        default:
            msg = "Keep studying"
        }
        
        let alert = UIAlertController(title: "Congrats!", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
}
