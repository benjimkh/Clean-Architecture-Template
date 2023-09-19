//
//  TransactionsList + ViewController + Cell + Comformance.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/19/23.
//

import Foundation

extension TransactionsListViewController.Cell : TransactionsListViewModelDelegate {
    func transactionsDidUpdate() {
        DispatchQueue.main.async {
            self.expand()

        }
    }
    
    func transactionsFetchFailed(with error: Error) {
        if (error as NSError).code == -1009 {
            self.transactionListViewModel?.transaction = TransactionCache.shared.retrieveTransactions().first(where: {$0.id == self.transaction?.id})
            DispatchQueue.main.async {
                self.expand()

            }

        }
    }
    
    func expand() {
        self.detailsView.configure(with: (self.transactionListViewModel?.transaction)!)
        self.detailsView.hideActivityIndicator()
    }
}
