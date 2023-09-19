//
//  AppCoordinator.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation
import UIKit

/// The `AppCoordinator` class acts as the main coordinator for the application, responsible for
/// initializing the app's navigation structure and starting the initial flow.
class AppCoordinator: Coordinator {
    /// The UIWindow where the app's user interface is displayed.
    private let window: UIWindow

    /// Initializes the AppCoordinator with a UIWindow.
    ///
    /// - Parameter window: The UIWindow used for displaying the app's user interface.
    init(window: UIWindow) {
        self.window = window
    }

    /// Starts the initial flow of the application.
    func start() {
        // Create the necessary dependencies, such as repositories, use cases, and view models.
        let repository = TransactionRepository(networkManager: NetworkManager())
        let usecase = TransactionListUseCase(transactionRepository: repository)
        let transactionsViewModel = TransactionsListViewModel(transactionsUseCase: usecase)

        // Create the initial view controller.
        let transactionsViewController = TransactionsListViewController(viewModel: transactionsViewModel)

        // Wrap the view controller in a navigation controller and set it as the root view controller.
        let navigationController = UINavigationController(rootViewController: transactionsViewController)
        window.rootViewController = navigationController

        // Make the window visible.
        window.makeKeyAndVisible()
    }

    /// Shows the details of a specific transaction.
    ///
    /// - Parameter transaction: The transaction for which to display details.
    func showTransactionDetails(for transaction: Entities.Responses.Transaction) {
        /// - TODO: for future :)
    }
}
