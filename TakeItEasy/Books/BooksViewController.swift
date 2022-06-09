//
//  BooksViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/8/22.
//

import UIKit

class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBarTableView: UITableView!
    var generalTitles = ["Basic Operators", "Closures", "Collection Types", "Control Flow"]
    var technologyTitles = ["Enumerations", "Error Handling", "Extensions", "Functions", "Inheritance"]
    var recipeTitles = ["Initialization", "Methods", "Nested Types", "Optional Chaining", "Properties", "Structures and Classes"]
    var generalImages = ["Basic Operators", "Closures", "Collection Types", "Control Flow"]
    var technologyImages = ["Enumerations", "Error Handling", "Extensions", "Functions", "Inheritance"]
    var recipeImages = ["Initialization", "Methods", "Nested Types", "Optional Chaining", "Properties", "Structures and Classes"]
    var allTitles : [String] = []
    var searchResults : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allTitles = generalTitles + technologyTitles + recipeTitles
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchBarCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchBarTableViewCell
        searchBarCell.bookTitle.text = searchResults[indexPath.row]
        searchBarCell.bookImage.image = UIImage(named: searchResults[indexPath.row])
        return searchBarCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToOpenedBookViewController(searchResults[indexPath.item])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{ //if search is empty, search results should hold all data
            searchBarTableView.isHidden = true
            searchResults = []
        }
        else{ //filter data using search text and store in search results
            searchBarTableView.isHidden = false
            searchResults = allTitles.filter {(str : String) -> Bool in return str.lowercased().contains(searchText.lowercased())}
        }
        searchBarTableView.reloadData() //reload collection view to show updated result
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.restorationIdentifier{
        case "GeneralCollectionView":
            return generalTitles.count
        case "TechnologyCollectionView":
            return technologyTitles.count
        case "RecipesCollectionView":
            return recipeTitles.count
        default:
            return generalTitles.count
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
            print(generalTitles[indexPath.item])
            goToOpenedBookViewController(generalTitles[indexPath.item])
        case "TechnologyCollectionView":
            print(technologyTitles[indexPath.item])
            goToOpenedBookViewController(technologyTitles[indexPath.item])
        case "RecipesCollectionView":
            print(recipeTitles[indexPath.item])
            goToOpenedBookViewController(recipeTitles[indexPath.item])
        default:
           print("no item")
        }
    }
    
    func goToOpenedBookViewController(_ bookTitle : String){
        let storyObject = UIStoryboard(name: "Main", bundle: nil)
        let openedBookViewController = storyObject.instantiateViewController(withIdentifier: "OpenedBook") as! OpenedBooksViewController
        openedBookViewController.bookFileName = bookTitle
        self.navigationController?.pushViewController(openedBookViewController, animated: true)
    }
    
    func setupGeneralCell(_ generalCell : GeneralBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        generalCell.bookLabel.text = generalTitles[indexPath.row]
        generalCell.bookImage.image = UIImage(named: generalImages[indexPath.row])
        generalCell.backgroundColor = .systemGray
        return setCornerRadiusForCell(generalCell)
    }

    func setupTechnologyCell(_ technologyCell : TechnologyBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        technologyCell.bookLabel.text = technologyTitles[indexPath.row]
        technologyCell.bookImage.image = UIImage(named: technologyImages[indexPath.row])
        technologyCell.backgroundColor = .systemGray2
        return setCornerRadiusForCell(technologyCell)
    }
    
    func setupRecipeCell(_ recipeCell : RecipeBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        recipeCell.bookLabel.text = recipeTitles[indexPath.row]
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
