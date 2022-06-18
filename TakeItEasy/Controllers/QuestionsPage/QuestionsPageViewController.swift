//
//  QuestionsPageViewController.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/9/22.
//

import UIKit

class QuestionsPageViewController: UIViewController {
    
    @IBOutlet weak var questoinCollection: UICollectionView!
    var quiz : Quiz?
    let scoreKeeperObj = ScoreKeeper()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    static var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialize()
        //        test()
    }
    
    func initialize() {
        titleLabel.text = quiz?.name
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitQuiz(_ sender: Any) {
        
        var flag = false
        
        do {
            try validateQuestions(quiz: quiz!)
            flag = true
        } catch QuestionsErrors.notAllQuestionsAnswered {
            errorLabel.text = QuestionsConstants.notAllQuestionsAnswered.rawValue
            return
        } catch {
            errorLabel.text = QuestionsConstants.unknownError.rawValue
            return
        }
        
        if (flag) {
            let result = scoreKeeperObj.formatToString(submittedQuiz: quiz!)
            QuizPageViewController.msg = result
            QuizPageViewController.alertTitle = result
            
            let score = scoreKeeperObj.percentageScore()
            if score <= 60 {
                QuizPageViewController.rewardMsg = QuizConstants.scoredLow.rawValue
                QuizPageViewController.alertMsg = QuizConstants.scoredLow.rawValue
            } else if (score <= 80) {
                QuizPageViewController.rewardMsg = QuizConstants.scoredMed.rawValue
                QuizPageViewController.alertMsg = QuizConstants.scoredLow.rawValue
            } else {
                QuizPageViewController.rewardMsg = QuizConstants.scoredHigh.rawValue
                QuizPageViewController.alertMsg = QuizConstants.scoredHigh.rawValue
            }
            
            // save result to database
//            insertResultData(name: quiz!.name, date: getDate(), score: scoreKeeperObj.percentageScore())
            
            QuizPageViewController.toShowResults = true
            
            dismiss(animated: true)
//            let TabPageVC = storyboard?.instantiateViewController(withIdentifier: "TabPageVC") as! UITabBarController
//            present(TabPageVC, animated: true, completion: nil)
            
        } else {
            errorLabel.text = QuestionsConstants.notAllQuestionsAnswered.rawValue
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

extension QuestionsPageViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (quiz?.details.questions.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = questoinCollection.dequeueReusableCell(withReuseIdentifier: "questionCell", for: indexPath) as! QuestionCollectionViewCell
        let q = quiz?.details.questions[indexPath.row]
        
        cell.answerLabel.text = q!.answer.choice
        cell.question = q
        return cell
    }
    
}

