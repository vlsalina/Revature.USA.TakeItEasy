//
//  BookDataTypes.swift
//  TakeItEasy
//
//  Created by admin on 6/13/22.
//

import Foundation

//structures for parsing json data using the the decoder method
//example of one item shown below
/*
 
 "items": [
     {
       "id": "Y0pAAQAAIAAJ",
       "volumeInfo": {
         "title": "The Time Machine",
         "imageLinks": {
           "smallThumbnail": "http://books.google.com/books/content?id=Y0pAAQAAIAAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
           "thumbnail": "http://books.google.com/books/content?id=Y0pAAQAAIAAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
         },
         "previewLink": "http://books.google.com/books?id=Y0pAAQAAIAAJ&printsec=frontcover&hl=&source=gbs_api"
       }
     }
   ]
 */

struct Books : Codable{
    var items : [BookItems]?
}

struct BookItems : Codable{
    var volumeInfo : VolumeInfo?
    var id : String?
}

struct VolumeInfo : Codable{
    var title : String?
    var imageLinks : ImageLinks?
    var previewLink : String?
}

struct ImageLinks : Codable{
    var smallThumbnail : String?
    var thumbnail : String?
}

//Class for a single bookshelve data (single collection view or table data) and a method for resetting all of its data

class BookData{
    var titles : [String] = []
    var imageUrls : [String] = []
    var previewUrls : [String] = []
    var ids : [String] = []
    
    func resetData(){
        titles = []
        imageUrls = []
        previewUrls = []
        ids = []
    }
}
