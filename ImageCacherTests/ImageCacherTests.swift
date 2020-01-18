//
//  ImageCacherTests.swift
//  ImageCacherTests
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import XCTest
@testable import ImageCacher

class ImageCacherTests: XCTestCase {

    let url = URL(string: "https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png")!
    var mockStorage: MockStorage!
    var mockFetcher: MockFetcher!
    var imageCacher: ImageCacher!
    
    override func setUp() {
        mockStorage = MockStorage()
        mockFetcher = MockFetcher()
        imageCacher = ImageCacher(url: url, fetcher: mockFetcher, storage: mockStorage)
    }
    
    func testShouldCallLoadFromStorageWhenTheFileIsAlreadyCached() {
        mockStorage.isFileAlreadyCached = true
        
        let fileAlreadyCachedExpectation = expectation(description: "File was not already cached")
        imageCacher.loadImage { image in
            XCTAssertTrue(self.mockStorage.loadCalled)
            XCTAssertFalse(self.mockFetcher.fetchCalled)
            
            fileAlreadyCachedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testShouldCallFetchFromFetcherWhenTheFileIsNotAlreadyCached() {
        mockStorage.isFileAlreadyCached = false
        
        let fileNotAlreadyCachedExpectation = expectation(description: "File was already cached")
        imageCacher.loadImage { image in
            XCTAssertTrue(self.mockStorage.loadCalled)
            XCTAssertTrue(self.mockFetcher.fetchCalled)
            
            fileNotAlreadyCachedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testShouldCancelFetcherWhenCancelIsCalled() {
        XCTAssertFalse(imageCacher.isCancelled)
        
        imageCacher.cancel()
        
        XCTAssertTrue(mockFetcher.cancelCalled)
        XCTAssertTrue(imageCacher.isCancelled)
    }
}
