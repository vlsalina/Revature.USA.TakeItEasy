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
    
    var quizzes = Quizzes.FetchQuizzes()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        quizCollection.dataSource = self
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

extension QuizPageViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = quizCollection.dequeueReusableCell(withReuseIdentifier: "quizCell", for: indexPath) as! QuizCollectionViewCell
        
        cell.quiz = quizzes[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}

