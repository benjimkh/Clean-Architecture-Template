//
//  Endpoints + Transactions.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/17/23.
//

import Foundation
// MARK: - Transactions Endpoint Classes



struct TransactionListEndpoint: Endpoint {
    let baseURL: URL = URL(string: "https://6500110618c34dee0cd43f59.mockapi.io")!
    let path: String = "/transactions"
    let httpMethod: String = "GET"
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: baseURL.absoluteString + path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
}

struct TransactionDetailsEndpoint: Endpoint {
    let baseURL: URL = URL(string: "https://6500110618c34dee0cd43f59.mockapi.io")!
    var path: String = "/transactionDetails/"
    let httpMethod: String = "GET"
    
    init(id: String) {
        self.path = path + id
    }
    
    var urlRequest: URLRequest? {
        guard let url = URL(string: baseURL.absoluteString + path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
}
