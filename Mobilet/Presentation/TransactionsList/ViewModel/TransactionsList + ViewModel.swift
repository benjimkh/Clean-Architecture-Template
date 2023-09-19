//
//  TransactionsList + ViewModel.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation

// MARK: - TransactionsListViewModel

class TransactionsListViewModel {

    // MARK: - Properties

    weak var delegate: TransactionsListViewModelDelegate?
    private let transactionsUseCase: TransactionUseCaseProtocol

    var datasource: [Entities.Responses.Transaction] = []
    var transaction: Entities.Responses.Transaction?
    // MARK: - Initialization

    init(transactionsUseCase: TransactionUseCaseProtocol) {
        self.transactionsUseCase = transactionsUseCase
    }

    // MARK: - Data Fetching

    func fetchTransactions() {
        transactionsUseCase.fetchTransactions { [weak self] result in
            switch result {
            case .success(let transactions):
                self?.datasource = transactions.sorted(by: {$0.date < $1.date})
                TransactionCache.shared.storeTransactions(transactions.sorted(by: {$0.date < $1.date}))
                self?.delegate?.transactionsDidUpdate()
            case .failure(let error):
                self?.delegate?.transactionsFetchFailed(with: error)
            }
        }
    }
    func fetchTransactionDetails(id: String) {
        transactionsUseCase.fetchTransactionDetail(for: id) { [weak self] result in
            switch result {
            case .success(let transaction):
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


