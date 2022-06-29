//
//  ImageLoader.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import UIKit

 var imageCache = NSCache<NSString, UIImage>()

struct ImageLoader {
    static func fetchImage(url: String, compliton: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .default).async {
            let cachedKey =  NSString(string: url)
            if let cachedImage = imageCache.object(forKey: cachedKey) {
                DispatchQueue.main.async {
                    compliton(cachedImage)
                }
                return
            }
            guard let url = URL(string: url) else {return}
            URLSession.shared.dataTask(with: url) { data, respones, error in
                if error != nil {
                    compliton(nil)
                    return
                }
                guard let imageData = data else {return}
                guard let image = UIImage(data: imageData) else {return}
                imageCache.setObject(image, forKey: cachedKey)
                DispatchQueue.main.async {
                    compliton(image)
                }
            }.resume()
        }
    }
}
