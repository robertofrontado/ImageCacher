//
//  ImageCacher.swift
//  ImageCacher
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

class ImageCacher {

    let url: URL
    let fetcher: Fetcher
    let storage: Storage
    private(set) var isCancelled = false
    
    convenience init(url: URL) {
        self.init(url: url,
                  fetcher: NetworkFetcher(urlSession: .shared),
                  storage: DiskStorage(fileManager: .default))
    }
    
    init(url: URL, fetcher: Fetcher, storage: Storage) {
        self.url = url
        self.fetcher = fetcher
        self.storage = storage
    }
    
    func cancel() {
        isCancelled = true
        fetcher.cancel()
    }
    
    func loadImage(completion: @escaping ((UIImage?) -> Void)) {
        storage.load(key: url.absoluteString) { [weak self] result in
            guard let `self` = self, !self.isCancelled else { return }
            
            switch result {
            case .success(let image):
                completion(image)
            case .failure:
                self.fetchImage(completion: completion)
            }
        }
    }
    
    internal func fetchImage(completion: @escaping (UIImage?) -> Void) {
        fetcher.fetch(from: url) { [weak self] result in
            guard let `self` = self, !self.isCancelled  else { return }
            
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    print("ImageCacher error: unsupported image format form url: \(self.url.absoluteString)")
                    completion(nil)
                    return
                }
                self.storage.save(key: self.url.absoluteString, image: image)
                completion(image)
            case .failure(let error):
                print("ImageCacher error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
