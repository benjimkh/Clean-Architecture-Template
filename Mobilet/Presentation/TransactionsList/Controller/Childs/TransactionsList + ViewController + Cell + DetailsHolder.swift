//
//  TransactionsList + ViewController + Cell + DetailsHolder.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/19/23.
//

import Foundation
import UIKit

extension TransactionsListViewController.Cell {
    
    class DetailsHolder: UIView {
        private lazy var activityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView(style: .gray)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.hidesWhenStopped = true
            indicator.backgroundColor = .lightGray
            indicator.style = .whiteLarge
            return indicator
        }()

        private lazy var bankLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = ""
            label.font = UIFont.systemFont(ofSize: 10)

            return label
        }()
        private lazy var cvvLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "CVV2: ***"
            label.font = UIFont.systemFont(ofSize: 8)
            label.textAlignment = .right

            return label
        }()

        private lazy var bankLogoImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false

            imageView.layer.borderColor = UIColor.black.cgColor
            imageView.layer.borderWidth = 0.5
            imageView.layer.cornerRadius = 12
            imageView.clipsToBounds = true
            imageView.backgroundColor = .lightGray

            return imageView
        }()
        
        private lazy var userAvatarImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false

            imageView.backgroundColor = .lightGray
            imageView.layer.borderColor = UIColor.black.cgColor
            imageView.layer.borderWidth = 0.5

            imageView.layer.cornerRadius = 12
            imageView.clipsToBounds = true
            return imageView
        }()
        
        private lazy var userNameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 10)
            label.text = ""
            label.textAlignment = .center

            return label
        }()
        private lazy var bankCardNumber: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false

            label.text = "****-****-****-****"
            label.textAlignment = .center
            return label
        }()

        init() {
            super.init(frame: .zero)
            self.backgroundColor = .lightGray.withAlphaComponent(0.2)
            self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
            self.layer.borderWidth = 1.0
            self.clipsToBounds = true
            self.layer.cornerRadius = 16
            setupUI()
            activityIndicator.startAnimating()

        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func hideActivityIndicator() {
            activityIndicator.stopAnimating()
        }

        private func setupUI() {
            addSubview(bankLabel)
            addSubview(bankCardNumber)
            addSubview(bankLogoImageView)
            addSubview(userAvatarImageView)
            addSubview(userNameLabel)
            addSubview(cvvLabel)

            
            NSLayoutConstraint.activate([
                bankLogoImageView.heightAnchor.constraint(equalToConstant: 24),
                bankLogoImageView.widthAnchor.constraint(equalToConstant: 24),
                bankLogoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
                bankLogoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
                bankCardNumber.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
                bankCardNumber.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),

                bankLabel.leadingAnchor.constraint(equalTo: self.bankLogoImageView.trailingAnchor, constant: 5),
                bankLabel.trailingAnchor.constraint(equalTo: self.userAvatarImageView.leadingAnchor, constant: -5),
                bankLabel.centerYAnchor.constraint(equalTo: self.bankLogoImageView.centerYAnchor, constant: 0),

                userAvatarImageView.heightAnchor.constraint(equalToConstant: 24),
                userAvatarImageView.widthAnchor.constraint(equalToConstant: 24),
                userAvatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
                userAvatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),

                userNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
                userNameLabel.topAnchor.constraint(equalTo: self.bankCardNumber.bottomAnchor, constant: 10),

                cvvLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
                cvvLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),

            ])
            addSubview(activityIndicator)
            NSLayoutConstraint.activate([
                activityIndicator.topAnchor.constraint(equalTo: self.topAnchor),
                activityIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                activityIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                activityIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])

        }
        
        func configure(with transaction: Entities.Responses.Transaction) {

            bankLabel.text = transaction.bank?.name
            if let bank = transaction.bank, let logoUrl = bank.logo, let url = URL(string: logoUrl)  {
                ImageDownloader.downloadImage(from: url) { image in
                    self.bankLogoImageView.image = image
                }

                
            }
            if let person = transaction.person, let avatarUrl = person.avatar, let url = URL(string: avatarUrl)  {
                ImageDownloader.downloadImage(from: url) { image in
                    self.userAvatarImageView.image = image
                }

                
            }
            //            userAvatarImageView.image = UIImage(named: transaction.userAvatarName)
            userNameLabel.text = transaction.person?.name
        }
    }
}
