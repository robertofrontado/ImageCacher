//
//  SampleAppSnapshopTests.swift
//  SampleAppSnapshopTests
//
//  Created by Roberto Frontado on 17/09/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import SampleApp

class SampleAppSnapshopTests: XCTestCase {
    
    let photo = Photo(id: "50352303008", owner: "190239670@N04", secret: "3ca6117a2e", server: "65535", farm: 66, title: "Window View", isPublic: 1, isFriend: 1, isFamily: 1)
    var photos: [Photo] { [photo, photo, photo, photo, photo] }
    
    let repository = MockFlickrRepository()
    
    func getViewController() -> PhotosViewController {
        let viewModel = PhotosViewModel(flickrRepository: repository)
        return PhotosViewController(viewModel: viewModel)
    }
    
    func test_PhotosEmptyState() {
        let viewController = getViewController()
        let named = "photos-empty" // "\($0.1)-\(osVersion)"
        verifySnapshots(withName: named, for: viewController)
    }

    func test_PhotosWithData() {
        let viewController = getViewController()
        let named = "photos-data" // "\($0.1)-\(osVersion)"
        repository.next = .success(PaginatedItems(page: 0,
                                                  pageSize: photos.count,
                                                  numPages: 1,
                                                  data: photos))
        viewController.viewModel.fetchPhotos()
        verifySnapshots(withName: named, for: viewController)
    }
    
    final func verifySnapshots(withName name: String, for controller: UIViewController, file: StaticString = #file) {
        return [verifySnapshot(
                matching: controller,
                as: .wait(for: 4.1, on: .image(on: .iPhoneX)),
                named: "\(name)-VERSION",
                file: #file,
                testName: name
            )].compactMap { $0 }.forEach { XCTFail($0) }
    }
    
}

class MockFlickrRepository: FlickrRepository {
    
    var next: Result<PaginatedItems<Photo>, Error>?
    let emptyResult: Result<PaginatedItems<Photo>, Error> = .success(PaginatedItems(page: 0,
                                                                                    pageSize: 0,
                                                                                    numPages: 0,
                                                                                    data: [Photo]()))
    init() {
        super.init(apiTarget: FlickrAPI.self)
    }
    
    override func getPhotos(search: String = "", page: Int = 1, completion: @escaping (Result<PaginatedItems<Photo>, Error>) -> Void) {
        completion(next ?? emptyResult)
        next = nil
    }
}
