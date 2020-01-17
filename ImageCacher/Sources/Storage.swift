//
//  Storage.swift
//  ImageCacher
//
//  Created by Roberto Frontado on 15/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import Foundation
import UIKit

enum StorageError: Error {
    case fileNotFound
}

class Storage {
    
    static let shared = Storage(fileManager: .default)
    
    let STORAGE_PATH = "com.frontado.ImageCacher"
    private let fileManager: FileManager
    let directoryURL: URL
    
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
        
        do {
            try pngRepresentation.write(to: path, options: .atomicWrite)
        } catch let error {
            print("Saving file resulted in error: \(error)")
        }
    }
    
    func load(key: String, completion: (Result<UIImage, StorageError>) -> Void) {
        guard
            let filePath = path(forKey: key),
            let fileData = fileManager.contents(atPath: filePath.path),
            let image = UIImage(data: fileData)
            else {
                print("File not found with key: \(key)")
                return completion(.failure(.fileNotFound))
        }
        
        completion(.success(image))
    }
    
    func removeAll() {
        do {
            let filePaths = try fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            filePaths.forEach { filePath in
                do {
                    try fileManager.removeItem(at: filePath)
                } catch let error {
                    print("Could not remove file at path \(filePath) with error: \(error)")
                }
            }
        } catch let error {
            print("Could not find files in \(directoryURL.path) with error: \(error)")
        }
    }
    
    func remove(key: String) {
        guard let filePath = path(forKey: key) else {
            print("Could not find file with key: \(key)")
            return
        }
        
        do {
            try fileManager.removeItem(at: filePath)
        } catch let error {
            print("Could not remove file at path \(filePath) with error: \(error)")
        }
    }
    
    func fileExist(key: String) -> Bool {
        let filePath = directoryURL.appendingPathComponent(key)
        return fileManager.fileExists(atPath: filePath.path)
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
