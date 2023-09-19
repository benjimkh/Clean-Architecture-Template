//
//  TransactionsListController.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation
import UIKit

// MARK: - TransactionsListViewController

class TransactionsListViewController: UIViewController {

    // MARK: - Properties

    let viewModel: TransactionsListViewModel
    let bottomSheetView = BottomSheetView()

    // MARK: - UI Components (Example: You can customize as needed)

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        tableView.register(TransactionsListViewController.Cell.self, forCellReuseIdentifier: "TransactionsListViewController.Cell")

        return tableView
    }()

    // MARK: - Initialization

    init(viewModel: TransactionsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.fetchTransactions()
    }


}


