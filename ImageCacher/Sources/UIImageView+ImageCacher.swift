//
//  UIImageView+ImageCacher.swift
//  ImageCacher
//
//  Created by Roberto Frontado on 17/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func imgc_loadImage(from url: URL, completion: ((UIImage?) -> Void)? = nil) {
        let storage = Storage.shared
        
        storage.load(key: url.absoluteString) { result in
            switch result {
            case .success(let image):
                imgc_setImage(image: image, completion: completion)
            case .failure:
                let fetcher = NetworkFetcher(urlSession: .shared)
                fetcher.fetch(from: url) { result in
                    switch result {
                    case .success(let data):
                        guard let image = UIImage(data: data) else {
                            completion?(nil)
                            return
                        }
                        storage.save(key: url.absoluteString, image: image)
                        self.imgc_setImage(image: image, completion: completion)
                    case .failure(let error):
                        print("ImageCacher error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func imgc_setImage(image: UIImage, completion: ((UIImage?) -> Void)? = nil) {
        DispatchQueue.main.async {
            self.image = image
            completion?(image)
        }
    }
    
    private func addActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        activityIndicator.startAnimating()
        return activityIndicator
    }
}
