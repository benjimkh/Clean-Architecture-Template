//
//  TransactionsList + Repository.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation

/// The `TransactionRepository` class is responsible for fetching transaction data from the API.
///
/// It conforms to the `TransactionRepositoryProtocol` and utilizes a `NetworkManager` to make
/// network requests and decode JSON responses into `Entities.Responses.Transaction` objects.
class TransactionRepository: TransactionRepositoryProtocol {
    
    /// The network manager responsible for making API requests.
    private let networkManager: NetworkManager

    /// Initializes the repository with the provided network manager.
    ///
    /// - Parameter networkManager: The network manager used for making API requests.
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    /// Fetch a list of transactions from the API.
    ///
    /// - Parameter completion: A closure that receives a result containing an array of transactions or an error.
    func fetchTransactions(completion: @escaping (Result<[Entities.Responses.Transaction], Error>) -> Void) {
        // Define the API endpoint for transaction listing
        let endpoint = TransactionListEndpoint.init()

        // Use the network manager to make a request to the API
        networkManager.request(endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    // Decode the JSON data into an array of Transaction objects
                    let transactions = try JSONDecoder().decode([Entities.Responses.Transaction].self, from: data)
                    completion(.success(transactions))
                } catch {
                    // Handle decoding errors
                    completion(.failure(error))
                }
            case .failure(let error):
                // Handle network request errors
                completion(.failure(error))
            }
        }
    }

    /// Fetch transaction details for a specific transaction by its ID from the API.
    ///
    /// - Parameters:
    ///   - transactionID: The ID of the transaction to fetch details for.
    ///   - completion: A closure that receives a result containing a transaction or an error.
    func fetchTransactionDetail(for transactionID: String, completion: @escaping (Result<Entities.Responses.Transaction, Error>) -> Void) {
        let endpoint = TransactionDetailsEndpoint(id: transactionID)

        // Use the network manager to make a request to the API
        networkManager.request(endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    // Decode the JSON data into a Transaction object
                    let transaction = try JSONDecoder().decode(Entities.Responses.Transaction.self, from: data)
                    completion(.success(transaction))
                } catch {
                    // Handle decoding errors
                    completion(.failure(error))
                }
            case .failure(let error):
                // Handle network request errors
                completion(.failure(error))
            }
        }
    }
}

