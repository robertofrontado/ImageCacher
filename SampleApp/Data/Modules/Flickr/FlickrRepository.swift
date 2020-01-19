//
//  FlickrRepository.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import Foundation

class FlickrRepository: BaseRepository<FlickrAPI> {
    
    func getPhotos(search: String = "", page: Int = 1, completion: @escaping (Result<PaginatedItems<Photo>, Error>) -> Void) {
        request(target: .getPhotos(search: search, page: page, pageSize: 90)) { (data, response, error) in
            guard let data = data else {
                let error = error ?? NSError(domain: "Error during request", code: 0, userInfo: nil)
                return completion(.failure(error))
            }
            
            do {
                let getPhotosResponse = try JSONDecoder().decode(GetPhotosResponse.self, from: data)
                completion(.success(getPhotosResponse.paginatedItems))
            } catch let error {
                return completion(.failure(error))
            }
        }
    }

}
