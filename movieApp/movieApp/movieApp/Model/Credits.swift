//
//  Credits.swift
//  movieApp
//
//  Created by Dimas Pagam on 15/11/22.
//

import Foundation

// MARK: - ActorCreditElement
struct ActorCreditElement: Codable {
    var embedded: Embedded

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

// MARK: - Embedded
struct Embedded: Codable {
    var show: Show
}
