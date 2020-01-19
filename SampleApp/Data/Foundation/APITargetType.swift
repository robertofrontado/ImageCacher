//
//  APITargetType.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import Foundation

protocol APITargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: APIRequestMethod { get }
    var parametersEncoding: ParametersEncodingType { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}
