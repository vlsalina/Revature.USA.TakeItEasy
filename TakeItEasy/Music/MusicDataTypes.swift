//
//  MusicDataTypes.swift
//  TakeItEasy
//
//  Created by Matt Caulder on 6/14/22.
//

import Foundation

struct Tracks : Codable{
    var data : [MusicData]?
}

struct MusicData : Codable{
    var title : String?
    var preview : String?
    var artist : Artist?
    var album : Album?
}

struct Artist : Codable{
    var name : String?
}

struct Album : Codable{
    var title : String?
    var cover_medium : String?
}

class Playlist{
    var songTitles : [String] = []
    var albumTitles : [String] = []
    var artistNames : [String] = []
    var mp3URLs : [String] = []
    var coverURLs : [String] = []
    
    func resetData(){
        songTitles = []
        albumTitles = []
        artistNames = []
        mp3URLs = []
        coverURLs = []
    }
}
