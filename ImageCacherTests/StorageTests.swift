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
    
    override func setUp() {
        storage = Storage()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
