//
//  Bank.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation
extension Entities.Responses {
    struct Bank: Codable {
        let name: String         // Name of the bank
        let logo: String?         // URL to the bank's logo
    }
}
extension Entities.Responses.Bank: Equatable {
    static func == (lhs: Entities.Responses.Bank, rhs: Entities.Responses.Bank) -> Bool {
        return lhs.name == rhs.name &&
            lhs.logo == rhs.logo
    }
}
