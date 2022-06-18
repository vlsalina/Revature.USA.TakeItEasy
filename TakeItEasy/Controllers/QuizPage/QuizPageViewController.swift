//
//  QuizPageViewController.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/9/22.
//

import UIKit

class QuizPageViewController: UIViewController {
    
    @IBOutlet weak var messageBox: UITextView!
    @IBOutlet weak var rewardBox: UITextView!
    @IBOutlet weak var quizCollection: UICollectionView!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var navbarItem: UINavigationItem!
    
    var quizzes = Quiz.FetchQuizzes()
    var database : [QuizSQLClass]?
    
    static var msg = QuizConstants.welcomeMsg.rawValue
    static var rewardMsg = QuizConstants.rewardMsg.rawValue
    static var toShowResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        quizCollection.dataSource = self
        quizCollection.delegate = self
        
        initialize()
        initializeSQLite()
        connectData()
        configureNavbar()
        showResults()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showResults()
    }
    
    func initialize() {
        messageBox.text = QuizPageViewController.msg
        rewardBox.text = QuizPageViewController.rewardMsg
        quizCollection.layer.cornerRadius = 15
    }
    
    func connectData() {
        database = SQLiteObject.sqlObj.getData()
    }
    
    func showResults() {
        if QuizPageViewController.toShowResults {
            showAlert()
            QuizPageViewController.toShowResults = false
        }
    }
    
    func resetMsgs() {
        QuizPageViewController.msg = QuizConstants.welcomeMsg.rawValue
        QuizPageViewController.rewardMsg = QuizConstants.rewardMsg.rawValue
    }
    
    func configureNavbar() {
        let userid = userDefaults.string(forKey: "currentUserName")
        self.navigationItem.title = userid
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Results", style: .done, target: self, action: #selector(toResultsPage))
    }
    
    @objc func logoutAction() {
        resetMsgs()
        userLoggedOut()
        dismiss(animated: true)
    }
    
    @objc func toResultsPage() {
        segueToVC(target: "ResultsPageNC", sender: self)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

extension QuizPageViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return database!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = quizCollection.dequeueReusableCell(withReuseIdentifier: "quizCell", for: indexPath) as! QuizCollectionViewCell
        
        cell.quiz = database![indexPath.row]
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked")
        let questionsVC = storyboard?.instantiateViewController(withIdentifier: "QuestionsPageVC") as! QuestionsPageViewController
        questionsVC.quiz = quizzes[indexPath.row]
        present(questionsVC, animated: true, completion: nil)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}

extension QuizPageViewController {
    func showAlert() {
        let alert = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
}

