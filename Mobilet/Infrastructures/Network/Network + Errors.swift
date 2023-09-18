//
//  Network + Errors.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/17/23.
//

import Foundation
// MARK: - NetworkError Enumeration

///This enumeration represents common networking-related errors that network layer
///might encounter. 
enum NetworkError: Error {
    case invalidURL
    case noData
    case dataParsingFailed
}
