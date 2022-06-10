//
//  QuestionCollectionViewCell.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/9/22.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var questionBox: UITextView!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var question : Question! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let question = question {
            questionBox.text = question.question
            buttonA.setTitle(question.choices[0].choice, for: .normal)
            buttonB.setTitle(question.choices[1].choice, for: .normal)
            buttonC.setTitle(question.choices[2].choice, for: .normal)
            buttonD.setTitle(question.choices[3].choice, for: .normal)
            imageView.image = question.image
        }
        
    }
    
    @IBAction func chooseA(_ sender: Any) {
        print("Chose A")
        question.chooseAction(a: question.choices[0])
    }
    @IBAction func chooseB(_ sender: Any) {
        print("Chose B")
        question.chooseAction(a: question.choices[1])
    }
    @IBAction func chooseC(_ sender: Any) {
        print("Chose C")
        question.chooseAction(a: question.choices[2])
    }
    @IBAction func chooseD(_ sender: Any) {
        print("Chose D")
        question.chooseAction(a: question.choices[3])
    }
}
