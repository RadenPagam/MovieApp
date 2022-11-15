//
//  Cast.swift
//  movieApp
//
//  Created by Dimas Pagam on 14/11/22.
//

import Foundation


// MARK: - ShowCastElement
struct ShowCastElement: Codable {
    var person: Person
    var character: Character
}

struct Cast: Codable {
    var person: Person
    var character: Character
    var castSelf:Bool
    var voice: Bool

}

struct Character: Codable {
    var id: Int
    var url: String
    var name: String
    var image: Image?
}
