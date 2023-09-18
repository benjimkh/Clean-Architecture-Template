//
//  AppCoordinator.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation
import UIKit


protocol Coordinator: AnyObject {
    func start()
}

class AppCoordinator: Coordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let repository = TransactionRepository(networkManager: NetworkManager())
        let usecase = TransactionListUseCase(transactionRepository: repository)

        let transactionsViewModel = TransactionsListViewModel(transactionsUseCase: usecase)

        let transactionsViewController = TransactionsListViewController(viewModel: transactionsViewModel)

        let navigationController = UINavigationController(rootViewController: transactionsViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func showTransactionDetails(for transaction: Entities.Responses.Transaction) {
       
    }
}
