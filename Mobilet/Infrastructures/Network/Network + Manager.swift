//
//  Network + Manager.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/17/23.
//

import Foundation

// MARK: - Network Managing Protocol

protocol NetworkManaging {
    func request(_ endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void)
}

// MARK: - NetworkManager Implementation

class NetworkManager: NetworkManaging {
    let networkClient: NetworkingClient
    
    init(networkClient: NetworkingClient = NetworkingClient()) {
        self.networkClient = networkClient
    }
    
    /// Send a network request.
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    ///   - completion: A closure that will be called with the result of the request.
    func request(_ endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        networkClient.request(endpoint) { result in
            // Forward the result from the API client to the caller.
            completion(result)
        }
    }
}
