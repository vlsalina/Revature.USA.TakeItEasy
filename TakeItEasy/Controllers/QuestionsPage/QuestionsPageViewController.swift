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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func submitQuiz(_ sender: Any) {
        let result = scoreKeeperObj.formatToString(submittedQuiz: quiz!)
        QuizPageGlobals.result = result
        
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

