//
//  PaginatedItems.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

struct PaginatedItems<T>: Codable, Equatable where T: Codable & Equatable {
    
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
    
    static func == (lhs: PaginatedItems<T>, rhs: PaginatedItems<T>) -> Bool {
        return lhs.page == rhs.page
            && lhs.pageSize == rhs.pageSize
            && lhs.numPages == rhs.numPages
            && lhs.data == rhs.data
    }
}
