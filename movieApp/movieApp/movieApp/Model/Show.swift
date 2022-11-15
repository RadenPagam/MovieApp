//
//  Show.swift
//  movieApp
//
//  Created by Dimas Pagam on 13/11/22.
//

import Foundation





// MARK: - showlist
struct ShowList :Codable {
    var score:Double
    var show: Show
}

// MARK: - Show
struct Show :Codable{
    var id: Int
    var name: String
    var genres: [String]?
    var rating: Rating
    var image: Image?
    var summary: String?
    //var embedded: Embedded
}

// MARK: - Image
struct Image :Codable{
    var medium, original: String
}

//MARK: - rating
struct Rating: Codable {
    var average: Double?
}

