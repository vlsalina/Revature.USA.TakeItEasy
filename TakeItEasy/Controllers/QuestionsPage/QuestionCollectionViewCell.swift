//
//  QuestionCollectionViewCell.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/9/22.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var question : Question! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let question = question {
            questionLabel.text = question.question
            buttonA.setTitle(question.choices[0].choice, for: .normal)
            buttonB.setTitle(question.choices[1].choice, for: .normal)
            buttonC.setTitle(question.choices[2].choice, for: .normal)
            buttonD.setTitle(question.choices[3].choice, for: .normal)
            
            imageView.image = question.image
            imageView.layer.cornerRadius = 15
        }
    }
    
    @IBAction func chooseA(_ sender: Any) {
        question.chooseAction(a: question.choices[0])
        answerLabel.text = question.answer.choice
    }
    @IBAction func chooseB(_ sender: Any) {
        question.chooseAction(a: question.choices[1])
        answerLabel.text = question.answer.choice
    }
    @IBAction func chooseC(_ sender: Any) {
        question.chooseAction(a: question.choices[2])
        answerLabel.text = question.answer.choice
    }
    @IBAction func chooseD(_ sender: Any) {
        question.chooseAction(a: question.choices[3])
        answerLabel.text = question.answer.choice
    }
    
    
}
