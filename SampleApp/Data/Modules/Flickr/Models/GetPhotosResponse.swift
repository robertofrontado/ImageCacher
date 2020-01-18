//
//  GetPhotosResponse.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

struct GetPhotosResponse: Codable {
    let paginatedItems: PaginatedItems<Photo>
    let stat: String
    
    enum CodingKeys: String, CodingKey {
        case paginatedItems = "photos"
        case stat
    }
}
