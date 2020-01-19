//
//  BaseRepository.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import Foundation

class BaseRepository<T: APITargetType> {

    let apiTarget: T.Type
    let urlSession: URLSessionProtocol
    var currentTask: URLSessionTask?
    
    init(apiTarget: T.Type, urlSession: URLSessionProtocol = URLSession.shared) {
        self.apiTarget = apiTarget
        self.urlSession = urlSession
    }
    
    internal func request(target: T, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let urlRequest = createRequest(target: target)
        currentTask = urlSession.dataTask(with: urlRequest, completionHandler: completion)
        currentTask?.resume()
    }
    
    
    // Needs more work in order to support other ParametersEncodingType
    internal func createRequest(target: T) -> URLRequest {
        var url = target.baseURL.appendingPathComponent(target.path)
        
        // Add query parameters
        if target.parametersEncoding == .urlEncoding,
            let queryParameters = target.parameters,
            !queryParameters.isEmpty {
            
            var urlComponents = URLComponents(string: target.baseURL.absoluteString)
            let queryItems = target.parameters?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            
            urlComponents?.queryItems = queryItems
            if let urlWithQueryItems = urlComponents?.url {
                url = urlWithQueryItems
            }
        }
        
        var urlRequest = URLRequest(url: url)
        
        // Set http method
        urlRequest.httpMethod = target.method.rawValue
        
        return urlRequest
    }
}
