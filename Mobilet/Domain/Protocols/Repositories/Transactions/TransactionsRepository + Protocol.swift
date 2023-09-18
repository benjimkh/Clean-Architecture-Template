//
//  TransactionsRepositoryProtocol.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation

/// A protocol that defines the interface for fetching transaction data.
protocol TransactionRepositoryProtocol {
    
    /// Fetch a list of transactions.
    ///
    /// - Parameter completion: A closure that receives a result containing an array of transactions or an error.
    func fetchTransactions(completion: @escaping (Result<[Entities.Responses.Transaction], Error>) -> Void)
    
    /// Fetch detailed information about a specific transaction.
    ///
    /// - Parameters:
    ///   - transactionID: The unique identifier of the transaction.
    ///   - completion: A closure that receives a result containing transaction details or an error.
    func fetchTransactionDetail(for transactionID: String, completion: @escaping (Result<Entities.Responses.Transaction, Error>) -> Void)
}
