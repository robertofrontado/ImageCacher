//
//  MockStorage.swift
//  ImageCacherTests
//
//  Created by Roberto Frontado on 18/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import UIKit
@testable import ImageCacher

class MockStorage: Storage {
    
    var saveCalled = false
    var loadCalled = false
    var removeAllCalled = false
    var removeCalled = false
    
    var isFileAlreadyCached = false
    
    func save(key: String, image: UIImage) {
        saveCalled = true
    }
    
    func load(key: String, completion: @escaping (Result<UIImage, StorageError>) -> Void) {
        loadCalled = true
        isFileAlreadyCached ? completion(.success(UIImage())) : completion(.failure(.fileNotFound))
    }
    
    func removeAll() {
        removeAllCalled = true
    }
    
    func remove(key: String) {
        removeCalled = true
    }
    
}
