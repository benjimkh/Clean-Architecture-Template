//
//  ImageDownloader.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/19/23.
//

import Foundation
import UIKit

/// The `ImageDownloader` class provides a convenient way to download an image from a given URL
/// using a URLSession data task.
class ImageDownloader {
    /// Downloads an image from the specified URL and invokes the completion handler with the result.
    ///
    /// - Parameters:
    ///   - url: The URL from which to download the image.
    ///   - completion: A closure that receives the downloaded UIImage or nil if an error occurs.
    static func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                // If data was received and successfully converted to an image, invoke the completion handler
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                // If there was an error or the data couldn't be converted to an image, invoke the completion handler with nil
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
