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
        let avatarURL: URL       // URL to the person's avatar or profile picture
    }
}
