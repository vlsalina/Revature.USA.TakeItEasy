//
//  BooksViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/7/22.
//

import UIKit

class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var generalText = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    var technologyText = ["a", "b", "c", "d", "e", "f"]
    var recipeText = ["10", "20", "30", "40", "50"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.restorationIdentifier{
        case "GeneralCollectionView":
            return generalText.count
        case "TechnologyCollectionView":
            return technologyText.count
        case "RecipesCollectionView":
            return recipeText.count
        default:
            return generalText.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.restorationIdentifier{
        case "GeneralCollectionView":
            var generalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCell", for: indexPath) as! GeneralBooksCollectionViewCell
            generalCell = setupGeneralCell(generalCell, indexPath)
            return generalCell
            
        case "TechnologyCollectionView":
            var technologyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TechnologyCell", for: indexPath) as! TechnologyBooksCollectionViewCell
            technologyCell = setupTechnologyCell(technologyCell, indexPath)
            return technologyCell
            
        case "RecipesCollectionView":
            var recipeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeBooksCollectionViewCell
            recipeCell = setupRecipeCell(recipeCell, indexPath)
            return recipeCell
            
        default:
            let generalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCell", for: indexPath) as! GeneralBooksCollectionViewCell
            return generalCell
        }
    }
    
    func setupGeneralCell(_ generalCell : GeneralBooksCollectionViewCell, _ indexPath : IndexPath) -> GeneralBooksCollectionViewCell{
        generalCell.bookLabel.text = generalText[indexPath.row]
        generalCell.backgroundColor = .systemGray
        generalCell.layer.cornerRadius = 10
        generalCell.layer.masksToBounds = true
        return generalCell
    }

    func setupTechnologyCell(_ technologyCell : TechnologyBooksCollectionViewCell, _ indexPath : IndexPath) -> TechnologyBooksCollectionViewCell{
        technologyCell.bookLabel.text = technologyText[indexPath.row]
        technologyCell.backgroundColor = .systemGray2
        technologyCell.layer.cornerRadius = 10
        technologyCell.layer.masksToBounds = true
        return technologyCell
    }
    
    func setupRecipeCell(_ recipeCell : RecipeBooksCollectionViewCell, _ indexPath : IndexPath) -> RecipeBooksCollectionViewCell{
        recipeCell.bookLabel.text = recipeText[indexPath.row]
        recipeCell.backgroundColor = .systemGray4
        recipeCell.layer.cornerRadius = 10
        recipeCell.layer.masksToBounds = true
        return recipeCell
    }
    
}
