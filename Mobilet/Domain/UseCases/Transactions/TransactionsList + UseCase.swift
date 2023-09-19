//
//  TransactionsListUseCase.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation

/// A default implementation of the `TransactionListUseCase` protocol.
class TransactionListUseCase: TransactionUseCaseProtocol {
    
    private let transactionRepository: TransactionRepositoryProtocol
    
    /// Initializes the use case with a transaction repository.
    ///
    /// - Parameter transactionRepository: A repository for fetching transaction data.
    init(transactionRepository: TransactionRepositoryProtocol) {
        self.transactionRepository = transactionRepository
    }
    
    /// Fetch a list of transactions.
    ///
    /// - Parameter completion: A closure that receives a result containing an array of transactions or an error.
    func fetchTransactions(completion: @escaping (Result<[Entities.Responses.Transaction], Error>) -> Void) {
        transactionRepository.fetchTransactions(completion: completion)
    }
    func fetchTransactionDetail(for transactionID: String, completion: @escaping (Result<Entities.Responses.Transaction, Error>) -> Void) {
        transactionRepository.fetchTransactionDetail(for: transactionID, completion: completion)

    }

}
