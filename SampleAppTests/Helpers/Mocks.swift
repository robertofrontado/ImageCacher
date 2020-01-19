//
//  MockPaginatedItems.swift
//  SampleAppTests
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

@testable import SampleApp

class Mocks {
    
    static let photo = Photo(id: "1",
                             owner: "owner",
                             secret: "secret",
                             server: "server",
                             farm: 1,
                             title: "title",
                             isPublic: 0,
                             isFriend: 0,
                             isFamily: 0)
    
    static func getPaginatedItems(page: Int = 1) -> PaginatedItems<Photo> {
        return PaginatedItems(page: page,
                              pageSize: 1,
                              numPages: 10,
                              data: [Mocks.photo])
    }
    
    static func getGETPhotosResponse() -> GetPhotosResponse {
        return GetPhotosResponse(paginatedItems: getPaginatedItems(), stat: "ok")
    }
}
