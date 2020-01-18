//
//  NetworkFetcher.swift
//  ImageCacher
//
//  Created by Roberto Frontado on 15/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//
import Foundation

class NetworkFetcher {

    let urlSession: URLSession
    var task: URLSessionTask?
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func fetch(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        task = urlSession.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                let domain = "Error fetching url: \(url.absoluteString)"
                let genericError = NSError(domain: domain, code: -101, userInfo: nil)
                return completion(.failure(error ?? genericError))
            }
            
            completion(.success(data))
        }
        
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
        task = nil
    }
}
