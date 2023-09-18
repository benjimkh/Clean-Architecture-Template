//
//  TransactionsDetails + UseCase.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation

/// A default implementation of the `TransactionDetailUseCase` protocol.
class TransactionDetailUseCase: TransactionDetailsUseCaseProtocol {
    private let transactionRepository: TransactionRepositoryProtocol
    
    /// Initializes the use case with a transaction repository.
    ///
    /// - Parameter transactionRepository: A repository for fetching transaction data.
    init(transactionRepository: TransactionRepositoryProtocol) {
        self.transactionRepository = transactionRepository
    }
    
    /// Fetch detailed information about a specific transaction.
    ///
    /// - Parameters:
    ///   - transactionID: The unique identifier of the transaction.
    ///   - completion: A closure that receives a result containing transaction details or an error.
    func fetchTransactionDetail(for transactionID: String, completion: @escaping (Result<Entities.Responses.Transaction, Error>) -> Void) {
        transactionRepository.fetchTransactionDetail(for: transactionID, completion: completion)
    }
}
