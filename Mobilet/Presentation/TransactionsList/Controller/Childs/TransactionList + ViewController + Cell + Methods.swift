//
//  TransactionList + ViewController + Cell + Methods.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/19/23.
//

import Foundation
import UIKit


extension TransactionsListViewController.Cell {
    
    func setupUI() {
        contentView.addSubview(viewHolder)

        viewHolder.addSubview(colorIndicatorView)
        viewHolder.addSubview(statusLabel)
        viewHolder.addSubview(amountLabel)
        viewHolder.addSubview(iconImageView)
        viewHolder.addSubview(descriptionLabel)
        viewHolder.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            viewHolder.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            viewHolder.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            viewHolder.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            viewHolder.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            colorIndicatorView.topAnchor.constraint(equalTo: viewHolder.topAnchor),
            colorIndicatorView.trailingAnchor.constraint(equalTo: viewHolder.trailingAnchor),
            colorIndicatorView.widthAnchor.constraint(equalToConstant: 50),
            colorIndicatorView.bottomAnchor.constraint(equalTo: viewHolder.bottomAnchor),
            
            statusLabel.leadingAnchor.constraint(equalTo: colorIndicatorView.leadingAnchor, constant: 0),
            statusLabel.trailingAnchor.constraint(equalTo: colorIndicatorView.trailingAnchor, constant: 0),
            statusLabel.topAnchor.constraint(equalTo: colorIndicatorView.topAnchor, constant: 0),
            statusLabel.bottomAnchor.constraint(equalTo: colorIndicatorView.bottomAnchor, constant: 0),
            //
            dateLabel.leadingAnchor.constraint(equalTo: viewHolder.leadingAnchor, constant: 10),
            dateLabel.topAnchor.constraint(equalTo: viewHolder.topAnchor, constant: 10),
            dateLabel.bottomAnchor.constraint(equalTo: viewHolder.bottomAnchor, constant: -10),
            dateLabel.widthAnchor.constraint(equalToConstant: 50),
            
            amountLabel.topAnchor.constraint(equalTo: viewHolder.topAnchor, constant: 10),
            amountLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 20),
            amountLabel.trailingAnchor.constraint(equalTo: colorIndicatorView.leadingAnchor, constant: -40),
            
            iconImageView.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor, constant: 0),
            iconImageView.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 5),
            iconImageView.widthAnchor.constraint(equalToConstant: 25),
            iconImageView.heightAnchor.constraint(equalToConstant: 25),

            descriptionLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: colorIndicatorView.leadingAnchor, constant: -10),

        ])
        adddDetailsView()
    }

    // MARK: - Cell Configuration

    func configure(with transaction: Entities.Responses.Transaction) {
        self.transaction = transaction
        self.isExpanded = transaction._isExpanded ?? false
        self.detailsView.isHidden = (transaction._isExpanded ?? false) ? false : true
        if isExpanded {
            guard let _transaction = self.transactionListViewModel?.transaction else { return }
            self.detailsView.configure(with: _transaction)
        }

        colorIndicatorView.backgroundColor = transaction.status == "SUCCESS" ? .systemGreen.withAlphaComponent(0.5) : .red.withAlphaComponent(0.5)
        statusLabel.text = transaction.status == "SUCCESS" ? "Success" : "Failed"
        
        amountLabel.textColor = transaction.isWithdraw == true ? .systemRed.withAlphaComponent(0.8) : .systemGreen.withAlphaComponent(0.8)
        if #available(iOS 13.0, *) {
            amountLabel.text = "$\(transaction.amount)"

            iconImageView.image = transaction.isWithdraw == true ? UIImage(systemName: "minus.circle") : UIImage(systemName: "plus.circle")
            iconImageView.tintColor = transaction.isWithdraw == true ? .systemRed.withAlphaComponent(0.8) : .systemGreen.withAlphaComponent(0.8)
        } else {
            amountLabel.text = transaction.isWithdraw == true ? ("-" + "$\(transaction.amount)") : ("+" + "$\(transaction.amount)")
            
        }
        descriptionLabel.text = transaction.userDescription ?? "-"
        manipulateDateUI(date: transaction.date)
    }
    
    func manipulateDateUI(date: String, toHijri: Bool = false) {
        var formattedDate: String?
        if toHijri {
             formattedDate = date.formattedHijriDate(inputFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", outputFormat: "dd\nMMM\nyyyy")
        } else {
             formattedDate = date.formattedDate(inputFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", outputFormat: "dd\nMMM\nyyyy")
        }
        
        guard let formattedDate else { return }
           let attributedString = NSMutableAttributedString(string: formattedDate)
           
           // Define different fonts for each part
           let components = formattedDate.components(separatedBy: "\n")
           
           if components.count == 3 {
               let dayRange = (formattedDate as NSString).range(of: components[0])
               let monthRange = (formattedDate as NSString).range(of: components[1])
               let yearRange = (formattedDate as NSString).range(of: components[2])
               
               let dayFont = UIFont.boldSystemFont(ofSize: 24)
               let monthFont = UIFont.boldSystemFont(ofSize: 15)
               let yearFont = UIFont.systemFont(ofSize: 10)
               
               attributedString.addAttribute(.font, value: dayFont, range: dayRange)
               attributedString.addAttribute(.font, value: monthFont, range: monthRange)
               attributedString.addAttribute(.font, value: yearFont, range: yearRange)
               
               dateLabel.attributedText = attributedString
           } else {
               dateLabel.text = "Invalid date format"
           }
       


    }
    func adddDetailsView() {
        self.viewHolder.addSubview(detailsView)
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        detailsView.heightAnchor.constraint(equalTo: self.viewHolder.widthAnchor, multiplier: 0.40).isActive = true
        detailsView.leadingAnchor.constraint(equalTo: self.dateLabel.trailingAnchor, constant: 20).isActive = true
        detailsView.trailingAnchor.constraint(equalTo: self.colorIndicatorView.leadingAnchor, constant: -20).isActive = true
        detailsView.bottomAnchor.constraint(equalTo: self.viewHolder.bottomAnchor, constant: -20).isActive = true

    }
    func tapOnTransaction() {
        
            guard let _transaction = self.transaction else { return }

            self.isExpanded.toggle()
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.transactionListViewModel?.delegate = self

                // Update the height constraint based on the cell's state
                if self.isExpanded {
//                    self.detailsView = DetailsHolder()
//                    self.adddDetailsView()
//                    self.holderHC.constant = self.frame.width * 0.7
                    self.detailsView.isHidden = false
                    self.transactionListViewModel?.fetchTransactionDetails(id: _transaction.id)
                    
                } else {
                    self.detailsView.isHidden = true
//                    self.detailsView = nil
//                    self.holderHC.constant = 100 // Shrink the holder view
                }
                
                // Notify the layout system to update
                self.layoutIfNeeded()
                
                self.delegate?.didTapOnTransaction(id: _transaction.id)
            })
        
    }
}
