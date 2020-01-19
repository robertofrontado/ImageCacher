//
//  Fetcher.swift
//  ImageCacher
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import Foundation

protocol Fetcher {
    func fetch(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
    func cancel()
}
