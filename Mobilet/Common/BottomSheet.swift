//
//  BottomSheet.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/19/23.
//

import Foundation
import UIKit

protocol BottomSheetDelegate: AnyObject {
    func showBottomSheet()
    func dismissBottomSheet()
}

class BottomSheetView: UIView {
    weak var delegate: BottomSheetDelegate?
    
    private var heightConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 12.0
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(panGesture)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = true
    }

    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)

        switch recognizer.state {
        case .changed:
            let newY = max(0, frame.origin.y + translation.y)
            frame.origin.y = newY
            recognizer.setTranslation(.zero, in: self)

        case .ended:
            // Optional: Implement snapping behavior or dismissal logic here
            break
        default:
            break
        }
    }
    
    func setHeight(_ height: CGFloat) {
        heightConstraint.constant = height
        delegate?.showBottomSheet()
        UIView.animate(withDuration: 0.3) {
            self.superview?.layoutIfNeeded()
        }
    }
}
