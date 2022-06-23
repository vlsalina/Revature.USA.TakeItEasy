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
    var bookApiKey = "No Key" //var for storing api key after it is grabbed from local environment
    //variables for book data used in collection
    var generalBookData = BookData()
    var technologyBookData = BookData()
    var recipeBookData = BookData()
    //variables for book data used in search bar and table view
    var allBooks = BookData()
    var searchResults = BookData()
    var bookAPIStatus = true
    //variables for local books
    var localGeneralBooks = ["The Time Machine"]
    var localTechnologyBooks = ["How To Code in Python 3"]
    var localRecipeBooks = ["Smart School Time Recipes"]

    enum BookCollection{
        //Custom type for handling the different update cases of the collections
        case general
        case technology
        case recipes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getKey() //get the api key from environment variables
        //get the bookshelve data for each bookshelve using the google books api and update BookData() variables
        getGeneralBooks()
        getTechnologyBooks()
        getRecipeBooks()
        configureNavbar()
    }

    func configureNavbar() {
        let userid = userDefaults.string(forKey: "currentUserName")
        self.navigationItem.title = userid
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutAction))
    }

    @objc func logoutAction() {
        userLoggedOut()
        segueToVC(target: SIDs.LoginPageVC.rawValue, sender: self)
    }

    func getKey(){
        //key is stored using xcodes local environment variables
        if let key = ProcessInfo.processInfo.environment["GoogleBooksApi"] {
            bookApiKey = key
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
        return searchBarCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if an item is selected pass the data and load the next screen
        if bookAPIStatus{
            goToOpenedBookViewControllerWithAPI(bookTitle : searchResults.titles[indexPath.item], bookId: searchResults.ids[indexPath.item], bookPreviewUrl: searchResults.previewUrls[indexPath.item])
        }
        else{
            goToOpenedBookViewControllerWithLocal(bookTitle: searchResults.titles[indexPath.item])
        }
    }

    func searchWithAPIBooks(ind : Int){
        searchResults.imageUrls.append(allBooks.imageUrls[ind])
        searchResults.ids.append(allBooks.ids[ind])
        searchResults.previewUrls.append(allBooks.previewUrls[ind])
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
                if bookAPIStatus{
                    searchWithAPIBooks(ind: i)
                }
            }
        }
        searchBarTableView.reloadData() //reload collection view to show updated result
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return row size based on book data titles array size for each collection
        //restoration identifiers are set in main storyboard
        switch collectionView.restorationIdentifier{
        case "GeneralCollectionView":
            if bookAPIStatus{
                return generalBookData.titles.count
            }
            else{
                return localGeneralBooks.count
            }
        case "TechnologyCollectionView":
            if bookAPIStatus{
                return technologyBookData.titles.count
            }
            else{
                return localTechnologyBooks.count
            }
        case "RecipesCollectionView":
            if bookAPIStatus{
                return recipeBookData.titles.count
            }
            else{
                return localRecipeBooks.count
            }
        default:
            return 0
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
            if bookAPIStatus{
                goToOpenedBookViewControllerWithAPI(bookTitle : generalBookData.titles[indexPath.item], bookId: generalBookData.ids[indexPath.item], bookPreviewUrl: generalBookData.previewUrls[indexPath.item])
            }
            else{
                goToOpenedBookViewControllerWithLocal(bookTitle: localGeneralBooks[indexPath.item])
            }
        case "TechnologyCollectionView":
            if bookAPIStatus{
                goToOpenedBookViewControllerWithAPI(bookTitle : technologyBookData.titles[indexPath.item], bookId: technologyBookData.ids[indexPath.item], bookPreviewUrl: generalBookData.previewUrls[indexPath.item])
            }
            else{
                goToOpenedBookViewControllerWithLocal(bookTitle: localTechnologyBooks[indexPath.item])
            }
        case "RecipesCollectionView":
            if bookAPIStatus{
                goToOpenedBookViewControllerWithAPI(bookTitle : recipeBookData.titles[indexPath.item], bookId: recipeBookData.ids[indexPath.item], bookPreviewUrl: generalBookData.previewUrls[indexPath.item])
            }
            else{
                goToOpenedBookViewControllerWithLocal(bookTitle: localRecipeBooks[indexPath.item])
            }
        default:
            print("no item")
        }
    }

    func goToOpenedBookViewControllerWithLocal(bookTitle : String){
        let storyObject = UIStoryboard(name: "Main", bundle: nil)
        let openedBookViewController = storyObject.instantiateViewController(withIdentifier: "OpenedBook") as! OpenedBooksViewController
        openedBookViewController.bookTitle = bookTitle
        openedBookViewController.bookAPIStatus = false
        self.navigationController?.pushViewController(openedBookViewController, animated: true) //push view controller on to navigation bar and go to it
    }

    func goToOpenedBookViewControllerWithAPI(bookTitle : String, bookId : String, bookPreviewUrl : String){
        //create an instance of the opened book screen and pass the data
        let storyObject = UIStoryboard(name: "Main", bundle: nil)
        let openedBookViewController = storyObject.instantiateViewController(withIdentifier: "OpenedBook") as! OpenedBooksViewController
        openedBookViewController.previewUrlString = bookPreviewUrl
        openedBookViewController.bookTitle = bookTitle
        openedBookViewController.bookID = bookId
        openedBookViewController.bookAPIStatus = true
        self.navigationController?.pushViewController(openedBookViewController, animated: true) //push view controller on to navigation bar and go to it
    }

    func setupGeneralCell(_ generalCell : GeneralBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        //add book title and image to cell for general book
        if bookAPIStatus{
            generalCell.bookLabel.text = generalBookData.titles[indexPath.item]
            loadURLImage(urlString: generalBookData.imageUrls[indexPath.item], bookCell : generalCell, update : BookCollection.general) //setup image using a url
        }
        else{
            generalCell.bookLabel.text = localGeneralBooks[indexPath.row]
            generalCell.bookImage.image = UIImage(named: localGeneralBooks[indexPath.row])
        }
        generalCell.backgroundColor = .systemGray //set background color for all cells in this collection
        return setCornerRadiusForCell(generalCell)
    }

    func setupTechnologyCell(_ technologyCell : TechnologyBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        //add book title and image to cell for technology book
        if bookAPIStatus{
            technologyCell.bookLabel.text = technologyBookData.titles[indexPath.item]
            loadURLImage(urlString: technologyBookData.imageUrls[indexPath.item], bookCell : technologyCell, update : BookCollection.technology)
        }
        else{
            technologyCell.bookLabel.text = localTechnologyBooks[indexPath.row]
            technologyCell.bookImage.image = UIImage(named: localTechnologyBooks[indexPath.row])
        }
        technologyCell.backgroundColor = .systemGray2
        return setCornerRadiusForCell(technologyCell)
    }

    func setupRecipeCell(_ recipeCell : RecipeBooksCollectionViewCell, _ indexPath : IndexPath) -> UICollectionViewCell{
        //add book title and image to cell for recipe book
        if bookAPIStatus{
            recipeCell.bookLabel.text = recipeBookData.titles[indexPath.item]
            loadURLImage(urlString: recipeBookData.imageUrls[indexPath.item], bookCell : recipeCell, update : BookCollection.recipes)
        }
        else{
            recipeCell.bookLabel.text = localRecipeBooks[indexPath.row]
            recipeCell.bookImage.image = UIImage(named: localRecipeBooks[indexPath.row])
        }
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
        let update = BookCollection.general//set the current collection update to general
        getBooks(bookData: generalBookData, update: update, bookShelveID: "1001")
    }

    func getTechnologyBooks(){
        //get the technology books data using googlebooks api
        //bookshelve id corresponds to public bookshelve that was created on google books
        let update = BookCollection.technology //set the current collection update to technology
        getBooks(bookData: technologyBookData, update: update, bookShelveID: "1002")
    }

    func getRecipeBooks(){
        //get the recipe books data using googlebooks api
        //bookshelve id corresponds to public bookshelve that was created on google books
        let update = BookCollection.recipes //set the current collection update to recipes
        getBooks(bookData: recipeBookData, update: update, bookShelveID: "1003")
    }

    func getBooks(bookData : BookData, update : BookCollection, bookShelveID : String){
        //setup url and book data property for datatask and decoding
        bookData.resetData()
        let urlRequest = URL(string: "https://www.googleapis.com/books/v1/users/103230950640890725814/bookshelves/" + bookShelveID + "/volumes?fields=items(volumeInfo(title,imageLinks,previewLink),id)&key=" + bookApiKey)
        if urlRequest == nil{
            allBooks.titles = self.localGeneralBooks + self.localTechnologyBooks + self.localRecipeBooks
            bookAPIStatus = false
            generalCollectionView.reloadData()
            technologyCollectionView.reloadData()
            recipesCollectionView.reloadData()
            return
        }
        getbookData(urlRequest: urlRequest!, bookData: bookData, update: update)
    }

    func updateCollectionFromDatatask(update: BookCollection){
        //in order to update ui elements from datatask, dispatch queue.main.async must be used
        switch update {
        case .general:
            DispatchQueue.main.async {
                self.generalCollectionView.reloadData() //update general collection view
            }
        case .technology:
            DispatchQueue.main.async {
                self.technologyCollectionView.reloadData()//update technology collection view
            }
        case .recipes:
            DispatchQueue.main.async {
                self.recipesCollectionView.reloadData()// update recipe collection view
            }
        }
    }

    func updateAllBooks(bookData : BookData){
        allBooks.titles += bookData.titles
        allBooks.imageUrls += bookData.imageUrls
        allBooks.ids += bookData.ids
        allBooks.previewUrls += bookData.previewUrls
    }

    func updateCurrentBookData(books: Books, bookData : BookData){
        //add books if expected fields are not nil
        for book in books.items!{ //get all the data for each item and store in book data property
            if book.volumeInfo!.title != nil && book.volumeInfo!.imageLinks!.thumbnail != nil && book.id != nil && book.volumeInfo!.previewLink != nil{
                bookData.titles.append(book.volumeInfo!.title!) //add book title
                bookData.imageUrls.append(book.volumeInfo!.imageLinks!.thumbnail!) //if there is an image, add the url
                bookData.ids.append(book.id!) //add book id
                bookData.previewUrls.append(book.volumeInfo!.previewLink!)//add preview links
            }
        }
    }

    func getbookData(urlRequest : URL, bookData : BookData, update : BookCollection){
        //get data for each bookshelve from url, store in corresponding book data property, and update corresponding collection view
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
            //if there is no error and data is not nil, start decoding json data
            if error == nil && data != nil{
                let decoder = JSONDecoder()
                do{
                    let decodedBooksData = try decoder.decode(Books.self, from: data!) //decode json data using structures defined in BookDataTypes file
                    if decodedBooksData.items != nil{ //if there are items (books) in bookshelve
                        self.bookAPIStatus = true
                        self.updateCurrentBookData(books: decodedBooksData, bookData: bookData) //add decoded book data to a BookData object
                        self.updateAllBooks(bookData: bookData) //need to keep track of all books for search bar functionality
                    }
                    else{
                        self.bookAPIStatus = false
                    }
                }
                catch{
                    print("error decoding json data")//json decoder threw an error
                    self.bookAPIStatus = false
                }
                
            }
            else{
                self.bookAPIStatus = false
            }
            if !self.bookAPIStatus{
                self.allBooks.titles = self.localGeneralBooks + self.localTechnologyBooks + self.localRecipeBooks
            }
            self.updateCollectionFromDatatask(update: update)//need to update the corresponing collection view based on enum value
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

    func updateCollectionCellImage(data : Data ,bookCell : UICollectionViewCell, update: BookCollection){
        //down cast UICollectionViewCell and update ui from datatask using DispatchQueue.main.async
        switch update{
        case .general:
            let generalCollectionViewCell = bookCell as! GeneralBooksCollectionViewCell
            DispatchQueue.main.async {
                generalCollectionViewCell.bookImage.image = UIImage(data: data)
            }
        case .technology:
            let technologyCollectionViewCell = bookCell as! TechnologyBooksCollectionViewCell
            DispatchQueue.main.async {
                technologyCollectionViewCell.bookImage.image = UIImage(data: data)
            }
        case .recipes:
            let recipeCollectionViewCell = bookCell as! RecipeBooksCollectionViewCell
            DispatchQueue.main.async {
                recipeCollectionViewCell.bookImage.image = UIImage(data: data)
            }
        }
    }

    func loadURLImage(urlString : String, bookCell : UICollectionViewCell, update: BookCollection){
        //to add image from url to cell a data task is used
        //if json data didn't contain url thumbnail data, don't load image
        if urlString == ""{
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
                self.updateCollectionCellImage(data: data!, bookCell: bookCell, update: update)
            }
            else{
                print("error loading web image")
            }
        })
        dataTask.resume()
    }

    
}
