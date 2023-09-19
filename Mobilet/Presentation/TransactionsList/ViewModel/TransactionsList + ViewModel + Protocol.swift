//
//  TransactionsList + ViewModel + Protocol.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation

/// A protocol that defines the methods a delegate of the `TransactionsListViewModel` class
/// should implement to receive updates and notifications about transaction data.
///
/// Implement this protocol in your view or controller to respond to data updates and fetch failures.
protocol TransactionsListViewModelDelegate: AnyObject {
    /// Notifies the delegate that the transactions data has been updated.
    func transactionsDidUpdate()

    /// Notifies the delegate that a transaction data fetch operation has failed with the given error.
    ///
    /// - Parameter error: The error that occurred during the fetch operation.
    func transactionsFetchFailed(with error: Error)
}
