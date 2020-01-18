//
//  MockFetcher.swift
//  ImageCacherTests
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

@testable import ImageCacher

class MockFetcher: Fetcher {
        
    var fetchCalled = false
    var cancelCalled = false
    
    func fetch(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        fetchCalled = true
        completion(.success(Data()))
    }
    
    func cancel() {
        cancelCalled = true
    }
}
