//
//  Storage.swift
//  ImageCacher
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit

enum StorageError: Error {
    case fileNotFound
}

protocol Storage {
    func save(key: String, image: UIImage)
    func load(key: String, completion: @escaping (Result<UIImage, StorageError>) -> Void)
    func removeAll()
    func remove(key: String)
}
