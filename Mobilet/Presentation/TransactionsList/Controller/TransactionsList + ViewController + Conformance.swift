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
        cell.delegate = self
        cell.transactionListViewModel = self.viewModel
        let transaction = viewModel.datasource[indexPath.row]
        cell.configure(with: transaction)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.viewModel.datasource[indexPath.row]._isExpanded ?? false {
            return self.view.frame.width * 0.7
        } else {
           return 150
        }

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
        if (error as NSError).code == -1009 {
            self.viewModel.datasource = TransactionCache.shared.retrieveTransactions()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

/// When a transaction cell is tapped, this method is called to handle the expansion or collapse of
/// transaction details views. It iterates through the view model's data source to determine which
/// cell was tapped and updates its `_isExpanded` property accordingly. It also toggles the visibility
/// of the details view associated with the tapped cell. Finally, it triggers a table view update to
/// reflect the changes in cell heights.
///
/// - Parameter id: The ID of the tapped transaction cell.
extension TransactionsListViewController: cellDellegate {
    func didTapOnTransaction(id: String) {

        for (index, item) in viewModel.datasource.enumerated() {
            if item.id != id {
                viewModel.datasource[index]._isExpanded = false

                // Hide details view of other cells
                (self.tableView.visibleCells as? [TransactionsListViewController.Cell])?[safe: index]?.detailsView.isHidden = true
            } else {
                viewModel.datasource[index]._isExpanded = !(viewModel.datasource[index]._isExpanded ?? false)

                // Toggle details view visibility for the tapped cell
                (self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? TransactionsListViewController.Cell)?.detailsView.isHidden = (viewModel.datasource[index]._isExpanded ?? false) ? false : true

            }
        }

        // Trigger table view updates to adjust cell heights
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}
