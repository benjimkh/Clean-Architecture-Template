//
//  TransactionsList + Repository.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation

class TransactionRepository: TransactionRepositoryProtocol {
    
    private let networkManager: NetworkManager

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

    
    func fetchTransactionDetail(for transactionID: String, completion: @escaping (Result<Entities.Responses.Transaction, Error>) -> Void) {
        
    }
    

}
