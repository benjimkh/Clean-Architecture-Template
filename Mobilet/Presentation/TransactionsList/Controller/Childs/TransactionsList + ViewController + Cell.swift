//
//  TransactionsList + ViewController + Cell.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpur on 9/18/23.
//

import Foundation
import UIKit

protocol cellDellegate: AnyObject {
    func didTapOnTransaction(id: String)
}
extension TransactionsListViewController {

    class Cell: UITableViewCell {

        // MARK: - Lazy UI Components
        var holderHC: NSLayoutConstraint!
        weak var delegate: cellDellegate?
        lazy var viewHolder: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.borderWidth = 1.0
            view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
            view.layer.cornerRadius = 16
            view.backgroundColor = .white
            view.clipsToBounds = true

            
            view.addTap = {
                self.tapOnTransaction()
            }
            return view
        }()

        lazy var colorIndicatorView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        lazy var amountLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.textAlignment = .right
            return label
        }()
        
        lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        lazy var descriptionLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            
            label.numberOfLines = 2
            label.textColor = .lightGray
            label.textAlignment = .right

            return label
        }()

        lazy var statusLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            
            let rotationAngle = CGFloat.pi / 2
            label.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
            label.textColor = .white
            label.textAlignment = .center

            return label
        }()
        lazy var detailsView: DetailsHolder = {
           let view = DetailsHolder()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isHidden = true
            return view
        }()

        lazy var dateLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            label.textColor = .black
            label.numberOfLines = 0
            label.textAlignment = .center
            label.addTap = {
                guard let _transaction = self.transaction else { return }
                self.isHijri = !self.isHijri
                self.manipulateDateUI(date: _transaction.date, toHijri: self.isHijri)
            }
            
            return label
        }()
        var transaction : Entities.Responses.Transaction?
        var isHijri: Bool = false
        var isExpanded = false // Keep track of the cell's state
//        var detailsView: DetailsHolder?
        var transactionListViewModel: TransactionsListViewModel?
        
        // MARK: - Initialization

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.selectionStyle = .none
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - UI Setup
        override func prepareForReuse() {
            super.prepareForReuse()
            self.isExpanded = false
            self.detailsView.isHidden = true
////            self.detailsView = nil
//            if self.detailsView.isDescendant(of: self.contentView) {
//                self.detailsView.removeFromSuperview()
//                self.layoutIfNeeded()
//                self.layoutSubviews()
//            }
//            if isExpanded {
//                if !self.detailsView.isDescendant(of: self.contentView) {
//                    self.adddDetailsView()
//                }
//            }
        }
    }
}

