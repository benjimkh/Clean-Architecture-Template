//
//  Person.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation

extension Entities.Responses {
    struct Person: Codable {
        let id: String           // Unique identifier for the person
        let name: String         // Name of the person
        let avatar: String?       // URL to the person's avatar or profile picture
    }
}
extension Entities.Responses.Person: Equatable {
    static func == (lhs: Entities.Responses.Person, rhs: Entities.Responses.Person) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.avatar == rhs.avatar

    }
}
