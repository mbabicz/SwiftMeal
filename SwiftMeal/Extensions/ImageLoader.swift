//
//  ImageLoader.swift
//  ShoppingApp
//
//  Created by kz on 21/11/2022.
//

import SwiftUI
import UIKit

class ImageLoader: ObservableObject {
@Published var image: UIImage?
private static let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(with url: URL) {
        if let imageFromCache = ImageLoader.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = imageFromCache
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                ImageLoader.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
