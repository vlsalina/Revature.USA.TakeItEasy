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
            buttonA.setTitle(question.choices.answers[0], for: .normal)
            buttonB.setTitle(question.choices.answers[1], for: .normal)
            buttonC.setTitle(question.choices.answers[2], for: .normal)
            buttonD.setTitle(question.choices.answers[3], for: .normal)
            imageView.image = UIImage(named: "harry_potter_wallpaper_digital_design____11_by_sefabaris713_de5yl8r-fullview")
        } else {
            questionBox.text = nil
            buttonA.setTitle(nil, for: .normal)
            buttonB.setTitle(nil, for: .normal)
            buttonC.setTitle(nil, for: .normal)
            buttonD.setTitle(nil, for: .normal)
            imageView.image = nil
        }
        
        // need to round corners
    }
    
    
}
