//
//  TransactionsList + ViewController + Conformance.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation
import UIKit

// MARK: - UITableViewDataSource & UITableViewDelegate

extension TransactionsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue and configure your custom UITableViewCell here
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionsListViewController.Cell", for: indexPath) as! TransactionsListViewController.Cell
        let transaction = viewModel.datasource[indexPath.row]
        cell.configure(with: transaction)
        return cell
    }
}
// MARK: - TransactionsListViewModelDelegate

extension TransactionsListViewController: TransactionsListViewModelDelegate {
    func transactionsDidUpdate() {
        // Update the UI based on the data received from the view model
        DispatchQueue.main.async {
            self.tableView.reloadData()

        }
    }

    func transactionsFetchFailed(with error: Error) {
        // Handle the error, e.g., show an alert
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
