//
//  BooksViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/7/22.
//

import UIKit

class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var generalText = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    var technologyText = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"]
    var recipesText = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.restorationIdentifier{
        case "GeneralCollectionView":
            let generalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCell", for: indexPath) as! GeneralBooksCollectionViewCell
            generalCell.bookLabel.text = generalText[indexPath.row]
            generalCell.backgroundColor = .systemGray
            generalCell.layer.cornerRadius = 10
            generalCell.layer.masksToBounds = true
            print(1)
            return generalCell
            
        case "TechnologyCollectionView":
            let technologyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TechnologyCell", for: indexPath) as! TechnologyBooksCollectionViewCell
            technologyCell.bookLabel.text = technologyText[indexPath.row]
            technologyCell.backgroundColor = .systemGray2
            technologyCell.layer.cornerRadius = 10
            technologyCell.layer.masksToBounds = true
            print(1)
            return technologyCell
            
        case "RecipesCollectionView":
            let recipeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipesCollectionViewCell
            recipeCell.bookLabel.text = recipesText[indexPath.row]
            recipeCell.backgroundColor = .systemGray4
            recipeCell.layer.cornerRadius = 10
            recipeCell.layer.masksToBounds = true
            print(1)
            return recipeCell
            
        default:
            let generalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCell", for: indexPath) as! GeneralBooksCollectionViewCell
            generalCell.bookLabel.text = generalText[indexPath.row]
            generalCell.backgroundColor = .systemGray6
            generalCell.layer.cornerRadius = 10
            generalCell.layer.masksToBounds = true
            return generalCell
        }
    }
    
    

    
}
