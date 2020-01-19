//
//  FlickrRepositoryTests.swift
//  SampleAppTests
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import XCTest
@testable import SampleApp

class FlickrRepositoryTests: XCTestCase {

    var repository: FlickrRepository!
    var stubURLSession: StubURLSession!
    
    override func setUp() {
        stubURLSession = StubURLSession()
        repository = FlickrRepository(apiTarget: FlickrAPI.self, urlSession: stubURLSession)
    }

    func testShouldReturnSuccessWhenFetchPhotosSucceed() {
        let mockGetPhotosResponse = Mocks.getGETPhotosResponse()
        let data = try! JSONEncoder().encode(mockGetPhotosResponse)
        stubURLSession.next = .success(data)
        let successExpectation = expectation(description: "GetPhotos failed")
        
        repository.getPhotos {
            switch $0 {
            case .success(let paginatedItems):
                XCTAssertEqual(paginatedItems, mockGetPhotosResponse.paginatedItems)
                
                successExpectation.fulfill()
            case .failure:
                break
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testShouldReturnFailureWhenFetchPhotosFails() {
        stubURLSession.next = .failure(NSError(domain: "Not found", code: 404, userInfo: nil))
        let failureExpectation = expectation(description: "GetPhotos succeeded")
        
        repository.getPhotos {
            switch $0 {
            case .success:
                break
            case .failure:
                failureExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testShouldReturnFailureWhenFetchPhotosCanNotParseTheResponse() {
        let mockPhoto = Mocks.photo
        let data = try! JSONEncoder().encode(mockPhoto)
        stubURLSession.next = .success(data)
        let parseExpectation = expectation(description: "GetPhotos couldn't parse the URLResponse")
        
        repository.getPhotos {
            switch $0 {
            case .success:
                break
            case .failure:
                parseExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
