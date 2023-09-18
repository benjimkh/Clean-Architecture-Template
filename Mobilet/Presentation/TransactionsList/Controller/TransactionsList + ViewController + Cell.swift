//
//  TransactionsList + ViewController + Cell.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation
import UIKit

extension  TransactionsListViewController {
    
    class Cell: UITableViewCell {

        // MARK: - Lazy UI Components

        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            return label
        }()

        private lazy var amountLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()

        // MARK: - Initialization

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - UI Setup

        private func setupUI() {
            contentView.addSubview(titleLabel)
            contentView.addSubview(amountLabel)

            // Add constraints to layout the UI elements
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

                amountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                amountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                amountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            ])
        }

        // MARK: - Cell Configuration

        func configure(with transaction: Entities.Responses.Transaction) {
            titleLabel.text = transaction.status
            amountLabel.text = "$\(transaction.amount)"
        }
    }
    
}
