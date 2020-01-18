//
//  DiskStorageTests.swift
//  ImageCacherTests
//
//  Created by Roberto Frontado on 17/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import XCTest
@testable import ImageCacher

class DiskStorageTests: XCTestCase {
    
    var storage: DiskStorage!
    let key = "image.png"
    let image = UIImage(named: "grumpy-cat",
                        in: Bundle(for: DiskStorageTests.self),
                        compatibleWith: nil)!
    
    override func setUp() {
        storage = DiskStorage(fileManager: .default)
    }

    override func tearDown() {
        storage.removeAll()
    }
    
    func testShouldReturnErrorWhenLoadFails() {
        let fileNotFoundExpectation = expectation(description: "File found with key: \(key)")
        storage.load(key: key) {
            switch $0 {
            case .success:
                break
            case .failure:
                fileNotFoundExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testShouldReturnImageWhenLoadSucceed() {
        let fileFoundExpectation = expectation(description: "File not found with key: \(key)")
        storage.save(key: key, image: image)
        storage.load(key: key) {
            switch $0 {
            case .success:
                fileFoundExpectation.fulfill()
            case .failure:
                break
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testShouldRemoveFileGivenTheKey() {
        // Save a file and check that it exists
        storage.save(key: key, image: image)
        XCTAssertTrue(fileExist(key: key))
        
        // Remove that file and check that it no longer exists
        storage.remove(key: key)
        XCTAssertFalse(fileExist(key: key))
    }
    
    func testShouldRemoveAllFiles() {
        let key1 = "image1.png"
        let key2 = "image2.png"
        let key3 = "image3.png"
        
        storage.save(key: key1, image: image)
        storage.save(key: key2, image: image)
        storage.save(key: key3, image: image)
        XCTAssertTrue(fileExist(key: key1))
        XCTAssertTrue(fileExist(key: key2))
        XCTAssertTrue(fileExist(key: key3))
        
        storage.removeAll()
        XCTAssertFalse(fileExist(key: key1))
        XCTAssertFalse(fileExist(key: key2))
        XCTAssertFalse(fileExist(key: key3))
    }
    
    // MARK: - Helpers

    private func fileExist(key: String) -> Bool {
        var fileExists = false
        let loadExpectation = expectation(description: "Could not load file with key \(key)")
        
        storage.load(key: key) {
            switch $0 {
            case .success:
                fileExists = true
            case .failure:
                break
            }
            loadExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        return fileExists
    }
}
