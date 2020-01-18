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
    let urlSession: URLSession
    var currentTask: URLSessionTask?
    
    init(apiTarget: T.Type, urlSession: URLSession = .shared) {
        self.apiTarget = apiTarget
        self.urlSession = urlSession
    }
    
    // Needs more work in order to support other ParametersEncodingType
    internal func createRequest(target: FlickrAPI) -> URLRequest {
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
