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
    
    var scoreMessage : String?
    
    var quizzes = Quiz.FetchQuizzes()
    var database = SQLiteObject.sqlObj.getData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        quizCollection.dataSource = self
        quizCollection.delegate = self
        
        initialize()
        initializeSQLite()
    }
    
    func initialize() {
        if scoreMessage != nil {
            messageBox.text = scoreMessage
        } else {
            messageBox.text = "Welcome to the Quiz Page!"
        }
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
        return database.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = quizCollection.dequeueReusableCell(withReuseIdentifier: "quizCell", for: indexPath) as! QuizCollectionViewCell
        
        cell.quiz = database[indexPath.row]
        
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

