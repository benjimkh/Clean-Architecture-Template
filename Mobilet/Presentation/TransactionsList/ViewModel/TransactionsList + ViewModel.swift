//
//  TransactionsList + ViewModel.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation
// MARK: - TransactionsListViewModel

/// The TransactionsListViewModel class manages the presentation and retrieval of transaction data
/// for a user interface. It conforms to the TransactionsListViewModelDelegate protocol to notify
/// its delegate of data updates and fetch failures.
class TransactionsListViewModel {

    // MARK: - Properties

    /// A weak reference to the delegate responsible for receiving updates from this view model.
    weak var delegate: TransactionsListViewModelDelegate?

    /// The use case responsible for handling transaction-related operations.
    private let transactionsUseCase: TransactionUseCaseProtocol

    /// The data source containing a list of transactions.
    var datasource: [Entities.Responses.Transaction] = []

    /// The currently selected transaction.
    var transaction: Entities.Responses.Transaction?

    // MARK: - Initialization

    /// Initializes the view model with the provided transactions use case.
    ///
    /// - Parameter transactionsUseCase: The use case responsible for transaction-related operations.
    init(transactionsUseCase: TransactionUseCaseProtocol) {
        self.transactionsUseCase = transactionsUseCase
    }

    // MARK: - Data Fetching

    /// Fetches a list of transactions from the data source and updates the view model accordingly.
    func fetchTransactions() {
        transactionsUseCase.fetchTransactions { [weak self] result in
            switch result {
            case .success(let transactions):
                // Sort and store transactions in the data source and cache.
                self?.datasource = transactions.sorted(by: {$0.date < $1.date})
                TransactionCache.shared.storeTransactions(transactions.sorted(by: {$0.date < $1.date}))
                self?.delegate?.transactionsDidUpdate()
            case .failure(let error):
                self?.delegate?.transactionsFetchFailed(with: error)
            }
        }
    }

    /// Fetches details for a specific transaction by its ID and updates the view model accordingly.
    ///
    /// - Parameter id: The ID of the transaction to fetch.
    func fetchTransactionDetails(id: String) {
        transactionsUseCase.fetchTransactionDetail(for: id) { [weak self] result in
            switch result {
            case .success(let transaction):
                // Update the transaction and cache.
                self?.transaction = transaction
                if let index = TransactionCache.shared.retrieveTransactions().firstIndex(where: {$0.id == transaction.id}) {
                    var temporaryArray = TransactionCache.shared.retrieveTransactions()
                    temporaryArray[index] = transaction
                    TransactionCache.shared.storeTransactions(temporaryArray)
                }
                self?.delegate?.transactionsDidUpdate()
            case .failure(let error):
                self?.delegate?.transactionsFetchFailed(with: error)
            }
        }
    }
}



