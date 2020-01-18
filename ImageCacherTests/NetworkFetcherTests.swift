//
//  NetworkFetcherTests.swift
//  ImageCacherTests
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import XCTest
@testable import ImageCacher

class NetworkFetcherTests: XCTestCase {

    var networkFetcher: NetworkFetcher!
    
    override func setUp() {
        networkFetcher = NetworkFetcher(urlSession: .shared)
    }
    
    func testShouldSucceedWhenFetchingData() {
        let url = URL(string: "https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png")!
        let fetchExcpectation = expectation(description: "Could not fetch file from url: \(url)")
        
        networkFetcher.fetch(from: url) {
            switch $0 {
            case .success:
                fetchExcpectation.fulfill()
            case .failure:
                break
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testShouldFailWhenFetchingData() {
        let url = URL(string: "https://")! // Nothing to fetch
        let fetchErrorExpectation = expectation(description: "Was able to fetch file from url: \(url)")
        
        networkFetcher.fetch(from: url) {
            switch $0 {
            case .success:
                break
            case .failure:
                fetchErrorExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}

