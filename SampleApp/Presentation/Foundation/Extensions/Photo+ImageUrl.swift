//
//  Photo+ImageUrl.swift
//  SampleApp
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

extension Photo {
    
    var imageUrl: String {
        return "http://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
