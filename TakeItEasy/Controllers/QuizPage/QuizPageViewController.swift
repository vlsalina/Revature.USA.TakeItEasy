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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        quizCollection.dataSource = self
        quizCollection.delegate = self
        
        initialize()
        initializeDB()
    }
    
    func initialize() {
        if scoreMessage != nil {
            messageBox.text = scoreMessage
        } else {
            messageBox.text = "Welcome to the Quiz Page!"
        }
    }
    
    func initializeDB() {
        SQLHelper.sqlObj.createDB()
        SQLHelper.sqlObj.createTable()
        SQLHelper.sqlObj.insertAllData(quizData: quizData)
        showData()
    }
    
    func showData() {
        var result = SQLHelper.sqlObj.viewData()
        for q in result {
            print("\(q.name)")
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
        return quizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = quizCollection.dequeueReusableCell(withReuseIdentifier: "quizCell", for: indexPath) as! QuizCollectionViewCell
        
        cell.quiz = quizzes[indexPath.row]
        
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

