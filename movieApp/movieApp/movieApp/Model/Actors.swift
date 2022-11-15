//
//  Actors.swift
//  movieApp
//
//  Created by Dimas Pagam on 14/11/22.
//

import Foundation

// MARK: - Person
struct PersonList: Codable {
    var score: Double
    var person: Person
}

// MARK: - PersonClass
struct Person: Codable {
    var id: Int
    var url: String
    var name: String
    var country: Country?
    var birthday: String?
    var gender: String?
    var image: Image?
}

// MARK: - Country
struct Country: Codable {
    var name, code, timezone: String
}


