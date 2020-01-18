//
//  UIImageView+ImageCacher.swift
//  ImageCacher
//
//  Created by Roberto Frontado on 17/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

// Declare a global var to produce a unique address as the associated object handle
private var AssociatedObjectHandle: UInt8 = 0

extension UIImageView {
    
    private var imageCacher: ImageCacher? {
        get {
            // Create and associate an instance of networkFetcher to this imageView if it doesn't exist
            // https://stackoverflow.com/questions/24133058/is-there-a-way-to-set-associated-objects-in-swift
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? ImageCacher
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public func imgc_loadImage(from url: URL, completion: ((UIImage?) -> Void)? = nil) {
        cancelLoadImage()
        
        imageCacher = ImageCacher(url: url)
        imageCacher?.loadImage(completion: { [weak self] image in
            guard let `self` = self, let image = image else { return }
            
            self.imgc_setImage(image: image, completion: completion)
        })
    }
    
    func imgc_setImage(image: UIImage, completion: ((UIImage?) -> Void)? = nil) {
        DispatchQueue.main.async {
            self.image = image
            completion?(image)
        }
    }
    
    func cancelLoadImage() {
        guard imageCacher != nil else { return }
        
        imageCacher?.cancel()
        imageCacher = nil
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
