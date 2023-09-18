//
//  Endpoints + Transactions.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/17/23.
//

import Foundation

// MARK: - Networking Endpoint
protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: String { get }
    var urlRequest: URLRequest? { get }
}


