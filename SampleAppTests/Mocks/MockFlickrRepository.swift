//
//  MockFlickrRepository.swift
//  SampleAppTests
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

@testable import SampleApp

class MockFlickrRepository: FlickrRepository {

    var getPhotosCalled = false
    var error: Error?
    
    init() {
        super.init(apiTarget: FlickrAPI.self)
    }
    
    override func getPhotos(search: String = "", page: Int = 1, completion: @escaping (Result<PaginatedItems<Photo>, Error>) -> Void) {
        getPhotosCalled = true
        
        guard let error = error else {
            return completion(.success(Mocks.getPaginatedItems(page: page)))
        }
        
        completion(.failure(error))
    }
}
