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
    var BOOK_API_KEY = "No Key" //var for storing api key after it is grabbed from local environment
    //variables for book data used in collection
    var generalBookData = BookData()
    var technologyBookData = BookData()
    var recipeBookData = BookData()
    //variables for book data used in search bar and table view
    var allBooks = BookData()
    var searchResults = BookData()
    
    enum Updates{
        //Custom type for handling the different update cases of the collections
        case generalCollection
        case technologyCollection
        case recipesCollection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("need to add API Key to run")
        getKey() //get the api key from environment variables
        //get the bookshelve data for each bookshelve using the google books api and update BookData() variables
        getGeneralBooks()
        getTechnologyBooks()
        getRecipeBooks()
        configureNavbar()
    }
    
    // nav bar
    func configureNavbar() {
        let userid = userDefaults.string(forKey: "currentUserName")
        self.navigationItem.title = userid
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutAction))
    }
    
    @objc func logoutAction() {
        userLoggedOut()
        dismiss(animated: true)
    }
    
    
    func getKey(){
        //key is stored using xcodes local environment variables
        //this ensures the key does not get uploaded to github
        if let key = ProcessInfo.processInfo.environment["GoogleBooksApi"] {
            BOOK_API_KEY = key
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //get the row size from the current search result titles array size
        return searchResults.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //setup each table view cell with the current search results book titles
        let searchBarCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchBarTableViewCell
        searchBarCell.bookTitle.text = searchResults.titles[indexPath.row]
        //searchBarCell.bookImage.image = UIImage(named: searchResults[indexPath.row])
        return searchBarCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if an item is selected pass the data and load the next screen
        goToOpenedBookViewController(bookTitle : searchResults.titles[indexPath.item], bookId: searchResults.ids[indexPath.item], bookPreviewUrl: searchResults.previewUrls[indexPath.item])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //search results table view is hidden when empty
        //when active, the search results table is viewable and the table view is updated
        searchResults.resetData()
        if searchText.isEmpty{ //if search is empty, search results table view should be hidded
            searchBarTableView.isHidden = true
            
        }
        else{ //filter data using search text and store in search results
            searchBarTableView.isHidden = false
            let searchResultIndices = allBooks.titles.indices.filter {(i : Int) -> Bool in return allBooks.titles[i].lowercased().contains(searchText.lowercased())}
            for i in searchResultIndices{
                //update search results book data
                searchResults.titles.append(allBooks.titles[i])
                searchResults.imageUrls.append(allBooks.imageUrls[i])
                searchResults.ids.append(allBooks.ids[i])
                searchResults.previewUrls.append(allBooks.previewUrls[i])
            }
        }
        searchBarTableView.reloadData() //reload collection view to show updated result
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return row size based on book data titles array size for each collection
        //restoration identifiers are set in main storyboard
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
        //setup each cell image and title based for each collection
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
        //if item is selected pass book data and open next screen
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
        //create an instance of the opened book screen and pass the data
        let storyObject = UIStoryboard(name: "Main", bundle: nil)
        let openedBookViewController = storyObject.instantiateViewController(withIdentifier: "OpenedBook") as! OpenedBooksViewController
        openedBookViewController.previewUrlString = bookPreviewUrl
        openedBookViewController.bookTitle = bookTitle
        openedBookViewController.bookID = bookId
        present(openedBookViewController, animated: true,  completion: nil) //open without navigation controller
        //self.navigationController?.pushViewController(openedBookViewController, animated: true) //push view controller on to navigation bar and go to it
    }
    
    func setupGeneralCell(_ generalCell : GeneralBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        //add book title and image to cell for general book
        generalCell.bookLabel.text = generalBookData.titles[indexPath.item]
        generalLoadURLImage(urlString: generalBookData.imageUrls[indexPath.item], bookCell : generalCell) //setup image using a url
        generalCell.backgroundColor = .systemGray //set background color for all cells in this collection
        return setCornerRadiusForCell(generalCell)
    }
    
    func setupTechnologyCell(_ technologyCell : TechnologyBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        //add book title and image to cell for technology book
        technologyCell.bookLabel.text = technologyBookData.titles[indexPath.item]
        technologyLoadURLImage(urlString: technologyBookData.imageUrls[indexPath.item], bookCell : technologyCell)
        technologyCell.backgroundColor = .systemGray2
        return setCornerRadiusForCell(technologyCell)
    }
    
    func setupRecipeCell(_ recipeCell : RecipeBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        //add book title and image to cell for recipe book
        recipeCell.bookLabel.text = recipeBookData.titles[indexPath.item]
        recipeLoadURLImage(urlString: recipeBookData.imageUrls[indexPath.item], bookCell : recipeCell)
        recipeCell.backgroundColor = .systemGray4
        return setCornerRadiusForCell(recipeCell)
    }
    
    func setCornerRadiusForCell(_ collectionViewCell : UICollectionViewCell) -> UICollectionViewCell{
        //make each cell rounded
        collectionViewCell.layer.cornerRadius = 10
        collectionViewCell.layer.masksToBounds = true
        return collectionViewCell
    }
    
    func getGeneralBooks(){
        //get the general books data using googlebooks api
        //bookshelve id corresponds to public bookshelve that was created on google books
        let update = Updates.generalCollection //set the current collection update to general
        getBooks(bookData: generalBookData, update: update, bookShelveID: "1001")
    }
    
    func getTechnologyBooks(){
        //get the technology books data using googlebooks api
        //bookshelve id corresponds to public bookshelve that was created on google books
        let update = Updates.technologyCollection //set the current collection update to technology
        getBooks(bookData: technologyBookData, update: update, bookShelveID: "1002")
    }
    
    func getRecipeBooks(){
        //get the recipe books data using googlebooks api
        //bookshelve id corresponds to public bookshelve that was created on google books
        let update = Updates.recipesCollection //set the current collection update to recipes
        getBooks(bookData: recipeBookData, update: update, bookShelveID: "1003")
    }
    
    func getBooks(bookData : BookData, update : Updates, bookShelveID : String){
        //setup url and book data property for datatask and decoding
        bookData.resetData()
        let urlRequest = URL(string: "https://www.googleapis.com/books/v1/users/103230950640890725814/bookshelves/" + bookShelveID + "/volumes?fields=items(volumeInfo(title,imageLinks,previewLink),id)&key=" + BOOK_API_KEY)
        if urlRequest == nil{
            print("url does not exist")
            return
        }
        print("url exists")
        getbookData(urlRequest: urlRequest!, bookData: bookData, update: update)
    }
    
    func getbookData(urlRequest : URL, bookData : BookData, update : Updates){
        //get data for each bookshelve from url, store in corresponding book data property, and update corresponding collection view
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            print("dataTask")
            //if there is no error and data is not nil, start decoding json data
            if error == nil && data != nil{
                let decoder = JSONDecoder()
                do{
                    print("decoding")
                    let booksData = try decoder.decode(Books.self, from: data!) //decode json data using structures defined in BookDataTypes file
                    if booksData.items != nil{ //if there are items (books) in bookshelve
                        for book in booksData.items!{ //get all the data for each item and store in book data property
                            bookData.titles.append(book.volumeInfo!.title!) //add book title
                            self.allBooks.titles.append(book.volumeInfo!.title!) //need to keep track of all books for search bar functionality
                            if book.volumeInfo!.imageLinks!.thumbnail != nil{ //sometimes there is not an image
                                bookData.imageUrls.append(book.volumeInfo!.imageLinks!.thumbnail!) //if there is an image, add the url
                                self.allBooks.imageUrls.append(book.volumeInfo!.imageLinks!.thumbnail!)
                            }
                            else{
                                bookData.imageUrls.append("img1") //if there was no image, just add a default image title from assests
                                self.allBooks.imageUrls.append("img1")
                            }
                            bookData.ids.append(book.id!) //add book id
                            self.allBooks.ids.append(book.id!)
                            bookData.previewUrls.append(book.volumeInfo!.previewLink!)//add preview links
                            self.allBooks.previewUrls.append(book.volumeInfo!.previewLink!)
                        }
                        switch update {
                            //need to update the corresponing collection view based on enum value
                            //in order to update ui elements from datatask, dispatch queue.main.async must be used
                        case .generalCollection:
                            DispatchQueue.main.async {
                                self.generalCollectionView.reloadData() //update general collection view
                            }
                        case .technologyCollection:
                            DispatchQueue.main.async {
                                self.technologyCollectionView.reloadData()//update technology collection view
                            }
                        case .recipesCollection:
                            DispatchQueue.main.async {
                                self.recipesCollectionView.reloadData()// update recipe collection view
                            }
                        }
                    }
                }
                catch{
                    print("error") //json decoder threw an error
                }
            }
            print("finished dataTask") //end of datatask
        })
        dataTask.resume() //datatask needs to be started using this
    }
    
    func setupStringWithHttps(urlString : String) -> String{
        //urls need to be https or else there will be a security error
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
        //add https if needed and create a url object
        let httpsUrlString = setupStringWithHttps(urlString: urlString)
        //setup url
        let urlRequest = URL(string: httpsUrlString)
        return urlRequest
    }
    
    //
    //need to figure out how to pass different types of book cells to one function
    //
    func generalLoadURLImage(urlString: String, bookCell : GeneralBooksCollectionViewCell){
        //to add image from url to cell a data task is used
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
                //to change ui elements from within datatask, dipatchque.main.async needs to be used
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
        //to add image from url to cell a data task is used
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
                //to change ui elements from within datatask, dipatchque.main.async needs to be used
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
        //to add image from url to cell a data task is used
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
                //to change ui elements from within datatask, dipatchque.main.async needs to be used
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
