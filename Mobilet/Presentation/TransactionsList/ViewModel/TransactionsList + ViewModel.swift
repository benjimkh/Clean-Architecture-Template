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
    private let transactionsUseCase: TransactionListUseCaseProtocol

    var datasource: [Entities.Responses.Transaction] = []

    // MARK: - Initialization

    init(transactionsUseCase: TransactionListUseCaseProtocol) {
        self.transactionsUseCase = transactionsUseCase
    }

    // MARK: - Data Fetching

    func fetchTransactions() {
        transactionsUseCase.fetchTransactions { [weak self] result in
            switch result {
            case .success(let transactions):
                self?.datasource = transactions
                self?.delegate?.transactionsDidUpdate()
            case .failure(let error):
                self?.delegate?.transactionsFetchFailed(with: error)
            }
        }
    }
}

// MARK: - TransactionsUseCase

