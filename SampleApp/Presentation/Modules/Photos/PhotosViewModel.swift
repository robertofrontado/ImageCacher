//
//  PhotosViewModel.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import Foundation

class PhotosViewModel {
    
    internal let flickrRepository: FlickrRepository
    private(set) var paginatedItems: PaginatedItems<Photo>?
    private(set) var currentSearch = ""
    var photos = [Photo]()
    var onPhotosChanged: ((_ newPhotos: [Photo]) -> Void)?
    var isLoading: ((Bool) -> Void)?
    var onError: ((Error) -> Void)?
    
    init(flickrRepository: FlickrRepository) {
        self.flickrRepository = flickrRepository
    }
        
    func fetchPhotos(search: String = "") {
        if search != currentSearch { // New search, clean up old values
            resetValues()
        }

        currentSearch = search
        runOnMainThread { self.isLoading?(true) }
        let nextPage = (paginatedItems?.page ?? 0) + 1
        flickrRepository.getPhotos(search: search, page: nextPage) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let paginatedItems):
                self.paginatedItems = paginatedItems
                self.photos.append(contentsOf: paginatedItems.data)
                self.runOnMainThread { self.onPhotosChanged?(paginatedItems.data) }
            case .failure(let error):
                self.runOnMainThread { self.onError?(error) }
            }

            self.runOnMainThread { self.isLoading?(false) }
        }
    }
    
    func resetValues() {
        currentSearch = ""
        paginatedItems = nil
        photos.removeAll()
        onPhotosChanged?([])
    }
    
    // MARK: - Private
    
    private func runOnMainThread(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }
}
