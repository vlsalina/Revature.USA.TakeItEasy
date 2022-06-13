//
//  BookDataTypes.swift
//  TakeItEasy
//
//  Created by admin on 6/12/22.
//

import Foundation

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
