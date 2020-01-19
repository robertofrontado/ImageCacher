//
//  PhotosViewModelTests.swift
//  SampleAppTests
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import XCTest
@testable import SampleApp

class PhotosViewModelTests: XCTestCase {

    var viewModel: PhotosViewModel!
    var mockFlickrRepository: MockFlickrRepository!
    
    override func setUp() {
        mockFlickrRepository = MockFlickrRepository()
        viewModel = PhotosViewModel(flickrRepository: mockFlickrRepository)
    }
    
    func testShouldNotifyOnPhotosChangedWhenFetchPhotosSucceed() {
        let onPhotoChangedExpectation = expectation(description: "onPhotoChanged was not called")
        viewModel.onPhotosChanged = { _ in onPhotoChangedExpectation.fulfill() }
        
        viewModel.fetchPhotos()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testShouldNotifyOnErrorWhenFetchPhotosFails() {
        mockFlickrRepository.error = NSError(domain: "Error", code: 0, userInfo: nil)
        let onErrorExpectation = expectation(description: "onError was not called")
        viewModel.onError = { _ in onErrorExpectation.fulfill() }
        
        viewModel.fetchPhotos()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testShouldFetchFirstPageWhenUsingDifferentSearch() {
        viewModel.fetchPhotos()
        XCTAssertEqual(viewModel.paginatedItems?.page, 1)
        
        viewModel.fetchPhotos(search: "other")
        XCTAssertEqual(viewModel.paginatedItems?.page, 1)
    }
    
    func testShouldFetchNextPageWhenUsingTheSameSearch() {
        let search = "search"
        
        viewModel.fetchPhotos(search: search)
        XCTAssertEqual(viewModel.paginatedItems?.page, 1)
        XCTAssertEqual(viewModel.currentSearch, search)
        
        viewModel.fetchPhotos(search: search)
        XCTAssertEqual(viewModel.paginatedItems?.page, 2)
        XCTAssertEqual(viewModel.currentSearch, search)
        
        viewModel.fetchPhotos(search: search)
        XCTAssertEqual(viewModel.paginatedItems?.page, 3)
        XCTAssertEqual(viewModel.currentSearch, search)
    }
    
    func testShouldResetValuesCorrectly() {
        let search = "hey"
        viewModel.fetchPhotos(search: search)
        
        XCTAssertEqual(viewModel.currentSearch, search)
        XCTAssertNotNil(viewModel.paginatedItems)
        
        viewModel.resetValues()
        
        XCTAssertEqual(viewModel.currentSearch, "")
        XCTAssertNil(viewModel.paginatedItems)
    }

}
