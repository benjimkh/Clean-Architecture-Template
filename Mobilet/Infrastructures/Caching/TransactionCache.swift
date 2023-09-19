//
//  TransactionCache.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/19/23.
//

import Foundation

/// The `TransactionCache` class provides a simple caching mechanism for storing and retrieving
/// transactions using UserDefaults.
class TransactionCache {
    /// Shared singleton instance of the `TransactionCache`.
    static let shared = TransactionCache()

    /// UserDefaults instance used for storage.
    private let userDefaults = UserDefaults.standard

    /// Stores an array of transactions in UserDefaults.
    ///
    /// - Parameter transactions: The array of transactions to be stored.
    func storeTransactions(_ transactions: [Entities.Responses.Transaction]) {
        do {
            let encoder = JSONEncoder()
            let encodedTransactions = try encoder.encode(transactions)
            userDefaults.set(encodedTransactions, forKey: "cachedTransactions")
        } catch {
            print("Error encoding transactions: \(error)")
        }
    }

    /// Retrieves an array of transactions from UserDefaults.
    ///
    /// - Returns: An array of transactions if found, or an empty array if not found or if there's an error.
    func retrieveTransactions() -> [Entities.Responses.Transaction] {
        if let encodedTransactions = userDefaults.data(forKey: "cachedTransactions") {
            do {
                let decoder = JSONDecoder()
                let transactions = try decoder.decode([Entities.Responses.Transaction].self, from: encodedTransactions)
                return transactions
            } catch {
                print("Error decoding transactions: \(error)")
            }
        }
        return []
    }
}



