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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialize()
        
    }
    
    func initialize() {
        titleLabel.text = quiz?.name
    }
    
    @IBAction func submitQuiz(_ sender: Any) {
        
        do {
            try validateQuestions(quiz: quiz!)
        } catch QuestionsErrors.notAllQuestionsAnswered {
            errorLabel.text = QuestionsConstants.notAllQuestionsAnswered.rawValue
            return
        } catch {
            errorLabel.text = QuestionsConstants.unknownError.rawValue
            return
        }
        
        let result = scoreKeeperObj.formatToString(submittedQuiz: quiz!)
        QuizPageViewController.msg = result
        
        let TabPageVC = storyboard?.instantiateViewController(withIdentifier: "TabPageVC") as! UITabBarController
        present(TabPageVC, animated: true, completion: nil)
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
        
        
        cell.question = quiz?.details.questions[indexPath.row]
        return cell
    }
    
}

