//
//  URLSessionProtocol.swift
//  SampleApp
//
//  Created by Roberto Frontado on 19/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
