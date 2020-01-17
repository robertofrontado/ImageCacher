//
//  StorageTests.swift
//  ImageCacherTests
//
//  Created by Roberto Frontado on 17/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import XCTest
@testable import ImageCacher

class StorageTests: XCTestCase {
    
    var storage: Storage!
    let key = "image.png"
    let image = UIImage(named: "grumpy-cat",
                        in: Bundle(for: StorageTests.self),
                        compatibleWith: nil)!
    
    override func setUp() {
        storage = Storage(fileManager: .default)
    }

    override func tearDown() {
        storage.removeAll()
    }

    func testShouldReturnIfFileExistCorrectly() {
        XCTAssertFalse(storage.fileExist(key: key))
        storage.save(key: key, image: image)
        XCTAssertTrue(storage.fileExist(key: key))
    }
    
    func testShouldReturnErrorWhenLoadFails() {
        let fileNotFoundExpectation = expectation(description: "File found with key: \(key)")
        XCTAssertFalse(storage.fileExist(key: key))
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
        XCTAssertTrue(storage.fileExist(key: key))
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
}
