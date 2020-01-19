//
//  ImageViewExtensionTests.swift
//  ImageCacherTests
//
//  Created by Roberto Frontado on 19/01/2020.
//  Copyright © 2020 Roberto Frontado. All rights reserved.
//

import XCTest
@testable import ImageCacher

class ImageViewExtensionTests: XCTestCase {
    
    var imageView: UIImageView!
    
    override func setUp() {
        imageView = UIImageView()
    }
    
    func testShouldAssociateImageCacherCorrectly() {
        XCTAssertNil(imageView.imageCacher)
        
        imageView.imageCacher = ImageCacher(url: Mocks.url)
        XCTAssertNotNil(imageView.imageCacher)
        
        imageView.imageCacher = nil
        XCTAssertNil(imageView.imageCacher)
    }
    
    func testShouldAddActivityIndicator() {
        XCTAssertTrue(imageView.subviews.isEmpty)
        
        imageView.addActivityIndicator()
        XCTAssertFalse(imageView.subviews.isEmpty)
    }
    
    func testShouldRemoveActivityIndicator() {
        imageView.addActivityIndicator()
        XCTAssertFalse(imageView.subviews.isEmpty)
        
        imageView.removeActivityIndicatior()
        XCTAssertTrue(imageView.subviews.isEmpty)
    }
    
    func testShouldCancelLoadImage() {
        let imageCacher = ImageCacher(url: Mocks.url)
        imageView.imageCacher = imageCacher
        XCTAssertNotNil(imageView.imageCacher)
        
        imageView.cancelLoadImage()
        XCTAssertTrue(imageCacher.isCancelled)
        XCTAssertNil(imageView.imageCacher)
    }
    
    func testShouldSetImage() {
        let mockImage = Mocks.image
        imageView.image = nil
        
        let setImageExpectation = expectation(description: "Couldn't set image correctly")
        imageView.imgc_setImage(image: mockImage) { image in
            XCTAssertEqual(image, mockImage)
            XCTAssertEqual(self.imageView.image, mockImage)
            setImageExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testShouldLoadImage() {
        imageView.image = Mocks.image
        
        let loadImageExpectation = expectation(description: "Couldn't load image correctly")
        imageView.imgc_loadImage(from: Mocks.url) { image in
            XCTAssertEqual(self.imageView.image, image)
            loadImageExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testShouldSetImagePlaceholderWhenLoadImageFails() {
        let url = URL(string: "https://")! // Nothing to fetch
        let imagePlaceholder = Mocks.image
        
        let loadImageExpectation = expectation(description: "Couldn't set image placeholder correctly")
        imageView.imgc_loadImage(from: url, placeholder: imagePlaceholder) { image in
            XCTAssertEqual(image, imagePlaceholder)
            XCTAssertEqual(self.imageView.image, imagePlaceholder)
            loadImageExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
