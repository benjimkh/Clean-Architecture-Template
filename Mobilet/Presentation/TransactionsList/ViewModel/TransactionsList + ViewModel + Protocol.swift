//
//  TransactionsList + ViewModel + Protocol.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation

protocol TransactionsListViewModelDelegate: AnyObject {
    func transactionsDidUpdate()
    func transactionsFetchFailed(with error: Error)
}
