//
//  TransactionsUseCase.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation

/// A protocol representing the use case for fetching a list of transactions.
protocol TransactionUseCaseProtocol {
    
    /// Fetch a list of transactions.
    ///
    /// - Parameter completion: A closure that receives a result containing an array of transactions or an error.
    func fetchTransactions(completion: @escaping (Result<[Entities.Responses.Transaction], Error>) -> Void)
    /// Fetch a Details of transactions.
    ///
    /// - Parameter completion: A closure that receives a result containing an transactions or an error.
    func fetchTransactionDetail(for transactionID: String, completion: @escaping (Result<Entities.Responses.Transaction, Error>) -> Void)

}

