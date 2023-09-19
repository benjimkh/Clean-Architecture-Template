//
//  UIView + Extension.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/19/23.
//

import Foundation
import UIKit

private var addTapKey: UInt8 = 0

extension UIView {
    typealias TapAction = () -> Void

    var addTap: TapAction? {
        get {
            return objc_getAssociatedObject(self, &addTapKey) as? TapAction
        }
        set(newValue) {
            objc_setAssociatedObject(self, &addTapKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setupTapGesture()
        }
    }

    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.cancelsTouchesInView = false
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTapGesture() {
        addTap?()
    }
}
