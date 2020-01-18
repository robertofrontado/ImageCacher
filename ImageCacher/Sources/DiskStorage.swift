//
//  DiskStorage.swift
//  ImageCacher
//
//  Created by Roberto Frontado on 15/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import Foundation
import UIKit

class DiskStorage: Storage {
    
    static let shared = DiskStorage(fileManager: .default)
    
    let STORAGE_PATH = "com.frontado.ImageCacher"
    private let fileManager: FileManager
    let directoryURL: URL
    
    lazy var dispatchQueue : DispatchQueue = {
        return DispatchQueue(label: "com.frontado.ImageCacher.serial.queue", attributes: [])
    }()
    
    init(fileManager: FileManager) {
        self.fileManager = fileManager
        
        let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        directoryURL = url.appendingPathComponent(STORAGE_PATH, isDirectory: true)
        
        createDirectory()
    }
    
    func createDirectory() {
        do {
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Failed to create directory at: \(directoryURL.path)")
        }
    }
    
    func save(key: String, image: UIImage) {
        guard
            let pngRepresentation = image.pngData(),
            let path = path(forKey: key)
            else { return }
        
        dispatchQueue.async {
            do {
                try pngRepresentation.write(to: path, options: .atomicWrite)
            } catch let error {
                print("Saving file resulted in error: \(error)")
            }
        }
    }
    
    func load(key: String, completion: @escaping (Result<UIImage, StorageError>) -> Void) {
        dispatchQueue.async {
            guard
                let filePath = self.path(forKey: key),
                let fileData = self.fileManager.contents(atPath: filePath.path),
                let image = UIImage(data: fileData)
                else {
                    return completion(.failure(.fileNotFound))
            }
            
            completion(.success(image))
        }
    }
    
    func removeAll() {
        dispatchQueue.async {
            do {
                let filePaths = try self.fileManager.contentsOfDirectory(at: self.directoryURL,
                                                                         includingPropertiesForKeys: nil,
                                                                         options: .skipsHiddenFiles)
                filePaths.forEach { filePath in
                    do {
                        try self.fileManager.removeItem(at: filePath)
                    } catch let error {
                        print("Could not remove file at path \(filePath) with error: \(error)")
                    }
                }
            } catch let error {
                print("Could not find files in \(self.directoryURL.path) with error: \(error)")
            }
        }
    }
    
    func remove(key: String) {
        dispatchQueue.async {
            guard let filePath = self.path(forKey: key) else {
                print("Could not find file with key: \(key)")
                return
            }
            
            do {
                try self.fileManager.removeItem(at: filePath)
            } catch let error {
                print("Could not remove file at path \(filePath) with error: \(error)")
            }
        }
    }
    
    private func path(forKey key: String) -> URL? {
        let filename = key.convertToValidFileName()
        return directoryURL.appendingPathComponent(filename)
    }
    
}

extension String {
    func convertToValidFileName() -> String {
        let string = replacingOccurrences(of: ".png", with: "")
        let invalidFileNameCharactersRegex = "[^a-zA-Z0-9_]+"
        let fullRange = string.startIndex..<string.endIndex
        let validName = string.replacingOccurrences(of: invalidFileNameCharactersRegex,
                                                    with: "-",
                                                    options: .regularExpression,
                                                    range: fullRange)
        return validName + ".png"
    }
}
