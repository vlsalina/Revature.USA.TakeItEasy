//
//  QuizCollectionViewCell.swift
//  TakeItEasy
//
//  Created by Vincent Salinas on 6/9/22.
//

import UIKit

class QuizCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var quiz : QuizSQLClass! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let quiz = quiz {
            imageView.image = UIImage(named: quiz.image)
            label.text = quiz.name
        } else {
            imageView.image = nil
            label.text = nil
        }
        
        // need to round corners
    }

    
}

