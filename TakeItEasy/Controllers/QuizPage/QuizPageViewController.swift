//
//  QuizPageViewController.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/9/22.
//

import UIKit

class QuizPageViewController: UIViewController {
    
    @IBOutlet weak var messageBox: UITextView!
    @IBOutlet weak var quizCollection: UICollectionView!
    
    var quizzes = Quiz.FetchQuizzes()
    var database : [QuizSQLClass]?
    
    static var msg = "Welcome to the Quiz page!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        quizCollection.dataSource = self
        quizCollection.delegate = self
        
        initialize()
        initializeSQLite()
        connectData()
    }
    
    func initialize() {
        messageBox.text = QuizPageViewController.msg
    }
    
    func connectData() {
        database = SQLiteObject.sqlObj.getData()
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

