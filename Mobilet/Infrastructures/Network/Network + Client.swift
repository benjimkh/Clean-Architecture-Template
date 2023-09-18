//
//  Network + Client.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/17/23.
//

import Foundation

// MARK: - API Client Protocol

protocol NetworkingClientProtocol {
    func request(_ endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void)
}

// MARK: - API Client Implementation

class NetworkingClient: NetworkingClientProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Send an HTTP request using URLSession.
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    ///   - completion: A closure that will be called with the result of the request.
    func request(_ endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = endpoint.urlRequest else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
