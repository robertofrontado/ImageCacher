//
//  PhotosInitializer.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

struct PhotosInitializer {

    static func create() -> PhotosViewController {
        let flickrRepository = FlickrRepository(apiTarget: FlickrAPI.self)
        let photosViewModel = PhotosViewModel(flickrRepository: flickrRepository)
        return PhotosViewController(viewModel: photosViewModel)
    }
    
}
