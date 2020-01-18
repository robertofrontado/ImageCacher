//
//  PaginatedItems.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

struct PaginatedItems<T: Codable>: Codable {
    let page: Int
    let pageSize: Int
    let numPages: Int
    let data: [T]
    
    enum CodingKeys: String, CodingKey {
        case page
        case pageSize = "perpage"
        case numPages = "pages"
        case data = "photo"
    }
}
