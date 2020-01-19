//
//  StubURLSession.swift
//  SampleAppTests
//
//  Created by Roberto Frontado on 19/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import Foundation
@testable import SampleApp

class StubURLSession: URLSessionProtocol {
    
    var next: Result<Data, NSError>?

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if let next = next, let url = request.url {
            let urlResponse = getURLResponse(for: url, with: next)
            switch next {
            case .success(let data):
                completionHandler(data, urlResponse, nil)
            case .failure(let error):
                completionHandler(nil, urlResponse, error)
            }
        }
        next = nil
        return URLSession.shared.dataTask(with: request)
    }
    
    private func getURLResponse(for url: URL, with result: Result<Data, NSError>) -> URLResponse? {
        let statusCode: Int
        switch result {
        case .success:
            statusCode = 200
        case .failure(let error):
            statusCode = error.code
        }
        return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
}
