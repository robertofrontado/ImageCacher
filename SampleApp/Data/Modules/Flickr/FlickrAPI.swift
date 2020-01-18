//
//  FlickrAPI.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import Foundation

enum FlickrAPI {
    case getPhotos(search: String, page: Int)
}

extension FlickrAPI: APITargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.flickr.com/services/rest")!
    }
    
    var path: String {
        return ""
    }
    
    var method: APIRequestMethod {
        switch self {
        case .getPhotos:
            return .get
        }
    }
    
    var parametersEncoding: ParametersEncodingType {
        switch self {
        case .getPhotos:
            return .urlEncoding
        }
    }
    
    var parameters: [String: Any]? {
        var parameters: [String : Any] = [
            "api_key": "3e7cc266ae2b0e0d78e279ce8e361736",
            "format": "json",
            "nojsoncallback": true,
            "safe_search": true
        ]
        
        switch self {
        case .getPhotos(let search, let page):
            parameters["method"] = search.isEmpty ? "flickr.photos.getRecent" : "flickr.photos.search"
            parameters["text"] = search
            parameters["page"] = page
        }
        return parameters
    }
    
    var headers: [String: String]? {
        return nil
    }
}


