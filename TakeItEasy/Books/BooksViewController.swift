//
//  BooksViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/7/22.
//

import UIKit

class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var generalText = ["Basic Operators", "Closures", "Collection Types", "Control Flow"]
    var technologyText = ["Enumerations", "Error Handling", "Extensions", "Functions", "Inheritance"]
    var recipeText = ["Initialization", "Methods", "Nested Types", "Optional Chaining", "Properties", "Structures and Classes"]
    var generalImages = ["Basic Operators", "Closures", "Collection Types", "Control Flow"]
    var technologyImages = ["Enumerations", "Error Handling", "Extensions", "Functions", "Inheritance"]
    var recipeImages = ["Initialization", "Methods", "Nested Types", "Optional Chaining", "Properties", "Structures and Classes"]
    
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
            let generalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCell", for: indexPath) as! GeneralBooksCollectionViewCell
            return setupGeneralCell(generalCell, indexPath)
        case "TechnologyCollectionView":
            let technologyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TechnologyCell", for: indexPath) as! TechnologyBooksCollectionViewCell
            return setupTechnologyCell(technologyCell, indexPath)
        case "RecipesCollectionView":
            let recipeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as! RecipeBooksCollectionViewCell
            return setupRecipeCell(recipeCell, indexPath)
        default:
            let generalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralCell", for: indexPath) as! GeneralBooksCollectionViewCell
            return generalCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier{
        case "GeneralCollectionView":
            print(generalText[indexPath.item])
            goToOpenedBookViewController(generalText[indexPath.item])
        case "TechnologyCollectionView":
            print(technologyText[indexPath.item])
            goToOpenedBookViewController(technologyText[indexPath.item])
        case "RecipesCollectionView":
            print(recipeText[indexPath.item])
            goToOpenedBookViewController(recipeText[indexPath.item])
        default:
           print("no item")
        }
    }
    
    func goToOpenedBookViewController(_ bookTitle : String){
        let storyObject = UIStoryboard(name: "Main", bundle: nil)
        let openedBookViewController = storyObject.instantiateViewController(withIdentifier: "OpenedBook") as! OpenedBookViewController
        openedBookViewController.bookFileName = bookTitle
        self.navigationController?.pushViewController(openedBookViewController, animated: true)    }
    
    func setupGeneralCell(_ generalCell : GeneralBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        generalCell.bookLabel.text = generalText[indexPath.row]
        generalCell.bookImage.image = UIImage(named: generalImages[indexPath.row])
        generalCell.backgroundColor = .systemGray
        return setCornerRadiusForCell(generalCell)
    }

    func setupTechnologyCell(_ technologyCell : TechnologyBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        technologyCell.bookLabel.text = technologyText[indexPath.row]
        technologyCell.bookImage.image = UIImage(named: technologyImages[indexPath.row])
        technologyCell.backgroundColor = .systemGray2
        return setCornerRadiusForCell(technologyCell)
    }
    
    func setupRecipeCell(_ recipeCell : RecipeBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        recipeCell.bookLabel.text = recipeText[indexPath.row]
        recipeCell.bookImage.image = UIImage(named: recipeImages[indexPath.row])
        recipeCell.backgroundColor = .systemGray4
        return setCornerRadiusForCell(recipeCell)
    }
    
    func setCornerRadiusForCell(_ collectionViewCell : UICollectionViewCell) -> UICollectionViewCell{
        collectionViewCell.layer.cornerRadius = 10
        collectionViewCell.layer.masksToBounds = true
        return collectionViewCell
    }
    
}
