//
//  Array + Extensions.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/19/23.
//

/// An extension on the Array type that provides a safe subscript, allowing you to access
/// elements at a specified index without causing index out-of-bounds errors.
///
/// This extension checks if the provided `index` is within the valid range of array indices.
/// If the index is valid, it returns the element at that index; otherwise, it returns nil,
/// preventing crashes due to out-of-bounds access.
///
/// - Parameter index: The index at which to access the element.
/// - Returns: The element at the specified index or nil if the index is out of bounds.
///
/// Example usage:
/// ```
/// let myArray = [1, 2, 3, 4, 5]
/// let element = myArray[safe: 2] // Result: 3
/// let invalidElement = myArray[safe: 10] // Result: nil
/// ```
import Foundation
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
