//
//  TransactionCache.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/19/23.
//

import Foundation

class TransactionCache {
    static let shared = TransactionCache()

    private let userDefaults = UserDefaults.standard

    // Store transactions in UserDefaults
    func storeTransactions(_ transactions: [Entities.Responses.Transaction]) {
        do {
            let encoder = JSONEncoder()
            let encodedTransactions = try encoder.encode(transactions)
            userDefaults.set(encodedTransactions, forKey: "cachedTransactions")
        } catch {
            print("Error encoding transactions: \(error)")
        }
    }

    // Retrieve transactions from UserDefaults
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


