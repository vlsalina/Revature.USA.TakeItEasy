//
//  BooksViewController.swift
//  TakeItEasy
//
//  Created by admin on 6/8/22.
//

import UIKit

class BooksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var generalCollectionView: UICollectionView!
    @IBOutlet weak var technologyCollectionView: UICollectionView!
    @IBOutlet weak var recipesCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBarTableView: UITableView!
    var searchBookData = BookData()
    var generalBookData = BookData()
    var technologyBookData = BookData()
    var recipeBookData = BookData()
    var allBooks = BookData()
    var searchResults = BookData()
    
    enum Updates{
        case generalCollection
        case technologyCollection
        case recipesCollection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("need to add API Key to run")
        getGeneralBooks()
        getTechnologyBooks()
        getRecipeBooks()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchBarCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchBarTableViewCell
        searchBarCell.bookTitle.text = searchResults.titles[indexPath.row]
        //searchBarCell.bookImage.image = UIImage(named: searchResults[indexPath.row])
        return searchBarCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToOpenedBookViewController(bookTitle : searchResults.titles[indexPath.item], bookId: searchResults.ids[indexPath.item], bookPreviewUrl: searchResults.previewUrls[indexPath.item])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResults.resetData()
        if searchText.isEmpty{ //if search is empty, search results should hold all data
            searchBarTableView.isHidden = true
            
        }
        else{ //filter data using search text and store in search results
            searchBarTableView.isHidden = false
            let searchResultIndices = allBooks.titles.indices.filter {(i : Int) -> Bool in return allBooks.titles[i].lowercased().contains(searchText.lowercased())}
            for i in searchResultIndices{
                searchResults.titles.append(allBooks.titles[i])
                searchResults.imageUrls.append(allBooks.imageUrls[i])
                searchResults.ids.append(allBooks.ids[i])
                searchResults.previewUrls.append(allBooks.previewUrls[i])
            }
        }
        searchBarTableView.reloadData() //reload collection view to show updated result
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.restorationIdentifier{
        case "GeneralCollectionView":
            return generalBookData.titles.count
        case "TechnologyCollectionView":
            return technologyBookData.titles.count
        case "RecipesCollectionView":
            return recipeBookData.titles.count
        default:
            return generalBookData.titles.count
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
            goToOpenedBookViewController(bookTitle : generalBookData.titles[indexPath.item], bookId: generalBookData.ids[indexPath.item], bookPreviewUrl: generalBookData.previewUrls[indexPath.item])
        case "TechnologyCollectionView":
            goToOpenedBookViewController(bookTitle : technologyBookData.titles[indexPath.item], bookId: technologyBookData.ids[indexPath.item], bookPreviewUrl: generalBookData.previewUrls[indexPath.item])
        case "RecipesCollectionView":
            goToOpenedBookViewController(bookTitle : recipeBookData.titles[indexPath.item], bookId: recipeBookData.ids[indexPath.item], bookPreviewUrl: generalBookData.previewUrls[indexPath.item])
        default:
           print("no item")
        }
    }
    
    func goToOpenedBookViewController(bookTitle : String, bookId : String, bookPreviewUrl : String){
        let storyObject = UIStoryboard(name: "Main", bundle: nil)
        let openedBookViewController = storyObject.instantiateViewController(withIdentifier: "OpenedBook") as! OpenedBooksViewController
        openedBookViewController.previewUrlString = bookPreviewUrl
        openedBookViewController.bookTitle = bookTitle
        openedBookViewController.bookID = bookId
        //present(openedBookViewController, animated: true,  completion: nil)
        self.navigationController?.pushViewController(openedBookViewController, animated: true)
    }
    
    func setupGeneralCell(_ generalCell : GeneralBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        generalCell.bookLabel.text = generalBookData.titles[indexPath.item]
        generalLoadURLImage(urlString: generalBookData.imageUrls[indexPath.item], bookCell : generalCell)
        generalCell.backgroundColor = .systemGray
        return setCornerRadiusForCell(generalCell)
    }

    func setupTechnologyCell(_ technologyCell : TechnologyBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        technologyCell.bookLabel.text = technologyBookData.titles[indexPath.item]
        technologyLoadURLImage(urlString: technologyBookData.imageUrls[indexPath.item], bookCell : technologyCell)
        technologyCell.backgroundColor = .systemGray2
        return setCornerRadiusForCell(technologyCell)
    }
    
    func setupRecipeCell(_ recipeCell : RecipeBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        recipeCell.bookLabel.text = recipeBookData.titles[indexPath.item]
        recipeLoadURLImage(urlString: recipeBookData.imageUrls[indexPath.item], bookCell : recipeCell)
        recipeCell.backgroundColor = .systemGray4
        return setCornerRadiusForCell(recipeCell)
    }
    
    func setCornerRadiusForCell(_ collectionViewCell : UICollectionViewCell) -> UICollectionViewCell{
        collectionViewCell.layer.cornerRadius = 10
        collectionViewCell.layer.masksToBounds = true
        return collectionViewCell
    }
    
    func getbookData(urlRequest : URL, bookData : BookData, update : Updates){
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            print("dataTask")
            if error == nil && data != nil{
                let decoder = JSONDecoder()
                do{
                    print("decoding")
                    let booksData = try decoder.decode(Books.self, from: data!)
                    if booksData.items != nil{
                        for book in booksData.items!{
                            bookData.titles.append(book.volumeInfo!.title!)
                            self.allBooks.titles.append(book.volumeInfo!.title!)
                            if book.volumeInfo!.imageLinks!.thumbnail != nil{
                                bookData.imageUrls.append(book.volumeInfo!.imageLinks!.thumbnail!)
                                self.allBooks.imageUrls.append(book.volumeInfo!.imageLinks!.thumbnail!)
                            }
                            else{
                                bookData.imageUrls.append("img1")
                                self.allBooks.imageUrls.append("img1")
                            }
                            bookData.ids.append(book.id!)
                            self.allBooks.ids.append(book.id!)
                            bookData.previewUrls.append(book.volumeInfo!.previewLink!)
                            self.allBooks.previewUrls.append(book.volumeInfo!.previewLink!)
                        }
                        switch update {
                        case .generalCollection:
                            DispatchQueue.main.async {
                                self.generalCollectionView.reloadData()
                            }
                        case .technologyCollection:
                            DispatchQueue.main.async {
                                self.technologyCollectionView.reloadData()
                            }
                        case .recipesCollection:
                            DispatchQueue.main.async {
                                self.recipesCollectionView.reloadData()
                            }
                        }
                    }
                }
                catch{
                    print("error")
                }
            }
            print("finished dataTask")
        })
        dataTask.resume()
    }
    func getBooks(bookData : BookData, update : Updates, bookShelveID : String){
        bookData.resetData()
        let urlRequest = URL(string: "https://www.googleapis.com/books/v1/users/103230950640890725814/bookshelves/" + bookShelveID + "/volumes?fields=items(volumeInfo(title,imageLinks,previewLink),id)&key=" + BOOK_API_KEY)
        if urlRequest == nil{
            print("url does not exist")
            return
        }
        print("url exists")
        getbookData(urlRequest: urlRequest!, bookData: bookData, update: update)
    }
    
    func getGeneralBooks(){
        let update = Updates.generalCollection
        getBooks(bookData: generalBookData, update: update, bookShelveID: "1001")
    }
    
    func getTechnologyBooks(){
        let update = Updates.technologyCollection
        getBooks(bookData: technologyBookData, update: update, bookShelveID: "1002")
    }
    
    func getRecipeBooks(){
        let update = Updates.recipesCollection
        getBooks(bookData: recipeBookData, update: update, bookShelveID: "1003")
    }
        
    func setupStringWithHttps(urlString : String) -> String{
        var httpsUrlString : String
        if !urlString.contains("https:"){
            httpsUrlString = urlString.replacingOccurrences(of: ":", with: "s:")
        }
        else{
            httpsUrlString = urlString
        }
        return httpsUrlString
    }
    
    func setupImageUrlRequest(urlString : String) -> URL?{
        //urls need to be https or else there will be a security error
        let httpsUrlString = setupStringWithHttps(urlString: urlString)
        //setup url
        let urlRequest = URL(string: httpsUrlString)
        return urlRequest
    }
    
    //
    //need to figure out how to pass different types of book cells to one function
    //
    func generalLoadURLImage(urlString: String, bookCell : GeneralBooksCollectionViewCell){
        //if json data didn't contain url thumbnail data, don't load image
        if urlString == "img1"{
            return
        }
        let urlRequest = setupImageUrlRequest(urlString: urlString)
        if urlRequest == nil{
            return
        }
        //start datatask
        let dataTask = URLSession.shared.dataTask(with: urlRequest!, completionHandler: { data, response, error in
            if error == nil && data != nil{
                DispatchQueue.main.async {
                    bookCell.bookImage.image = UIImage(data: data!)
                }
            }
            else{
                print("error loading web image")
            }
        })
        dataTask.resume()
    }
    
    func technologyLoadURLImage(urlString: String, bookCell : TechnologyBooksCollectionViewCell){
        //if json data didn't contain url thumbnail data, don't load image
        if urlString == "img1"{
            return
        }
        let urlRequest = setupImageUrlRequest(urlString: urlString)
        if urlRequest == nil{
            return
        }
        //start datatask
        let dataTask = URLSession.shared.dataTask(with: urlRequest!, completionHandler: { data, response, error in
            if error == nil && data != nil{
                DispatchQueue.main.async {
                    bookCell.bookImage.image = UIImage(data: data!)
                }
            }
            else{
                print("error loading web image")
            }
        })
        dataTask.resume()
    }
    
    func recipeLoadURLImage(urlString: String, bookCell : RecipeBooksCollectionViewCell){
        //if json data didn't contain url thumbnail data, don't load image
        if urlString == "img1"{
            return
        }
        let urlRequest = setupImageUrlRequest(urlString: urlString)
        if urlRequest == nil{
            return
        }
        //start datatask
        let dataTask = URLSession.shared.dataTask(with: urlRequest!, completionHandler: { data, response, error in
            if error == nil && data != nil{
                DispatchQueue.main.async {
                    bookCell.bookImage.image = UIImage(data: data!)
                }
            }
            else{
                print("error loading web image")
            }
        })
        dataTask.resume()
    }
    
}
