//
//  DebouncerTests.swift
//  SampleAppTests
//
//  Created by Roberto Frontado on 19/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import XCTest
@testable import SampleApp

class DebouncerTests: XCTestCase {

    var debouncer: Debouncer!
    
    override func setUp() {
        debouncer = Debouncer(interval: 1)
    }
    
    func testDebounce() {
        var array = [Int]()
        let expectedArray = [3, 5]
        
        let threeWasAddedExpectation = expectation(description: "3 was not added")
        debouncer.debounce { array.append(1) }
        debouncer.debounce { array.append(2) }
        debouncer.debounce {
            array.append(3)
            threeWasAddedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        let fiveWasAddedExpectation = expectation(description: "5 was not added")
        debouncer.debounce { array.append(4) }
        debouncer.debounce {
            array.append(5)
            fiveWasAddedExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertEqual(array, expectedArray)
    }
}
