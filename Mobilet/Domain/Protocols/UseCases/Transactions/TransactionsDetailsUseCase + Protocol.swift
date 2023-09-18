//
//  TransactionsDetailsUseCase + Protocol.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/18/23.
//

import Foundation

/// A protocol representing the use case for fetching a Details of transactions.
protocol TransactionDetailsUseCaseProtocol {
    
    /// Fetch a Details of transactions.
    ///
    /// - Parameter completion: A closure that receives a result containing an transactions or an error.
    func fetchTransactionDetail(for transactionID: String, completion: @escaping (Result<Entities.Responses.Transaction, Error>) -> Void)
}
