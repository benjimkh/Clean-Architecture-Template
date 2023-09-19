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
