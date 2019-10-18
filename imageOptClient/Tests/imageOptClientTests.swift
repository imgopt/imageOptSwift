//
//  imageOptClientTests.swift
//  imageOptClient
//
//  Created by BHAVESH on 18/10/19.
//  Copyright © 2019 imageOpt. All rights reserved.
//

import XCTest

class imageOptClientTests: XCTestCase {

    var scale = CGFloat(1)
    var imageURL = ""
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        scale = UIScreen.main.scale
        imageURL = "https://imageopt.net/sjr-rld/q"
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSizeFit() {
        let imageSize = CGSize(width: 400,height: 300)
        let expectedURL = imageURL + String(format: "?w=%.0f&h=%.0f", imageSize.width * scale, imageSize.height * scale)
        let imageOptURL = imageOptClient.constructURL(imageURL: imageURL, imageSize: imageSize, crop: false)
        XCTAssertEqual(imageOptURL?.absoluteString, expectedURL)
    }
    
    func testSizeCrop() {
        let imageSize = CGSize(width: 200,height: 200)
        let expectedURL = imageURL + String(format: "?w=%.0f&h=%.0f&c=true", imageSize.width * scale, imageSize.height * scale)
        let imageOptURL = imageOptClient.constructURL(imageURL: imageURL, imageSize: imageSize, crop: true)
        XCTAssertEqual(imageOptURL?.absoluteString, expectedURL)
    }
    
    func testWidthOnlyFit() {
        let imageSize = CGSize(width: 300,height: 0)
        let expectedURL = imageURL + String(format: "?w=%.0f&h=%.0f", imageSize.width * scale, imageSize.height * scale)
        let imageOptURL = imageOptClient.constructURL(imageURL: imageURL, imageSize: imageSize, crop: false)
        XCTAssertEqual(imageOptURL?.absoluteString, expectedURL)
    }
    
    func testHeightOnlyFit() {
        let imageSize = CGSize(width: 0,height: 600)
        let expectedURL = imageURL + String(format: "?w=%.0f&h=%.0f", imageSize.width * scale, imageSize.height * scale)
        let imageOptURL = imageOptClient.constructURL(imageURL: imageURL, imageSize: imageSize, crop: false)
        XCTAssertEqual(imageOptURL?.absoluteString, expectedURL)
    }
    
    func testZeroSizeFit() {
        let imageSize = CGSize(width: 0,height: 0)
        let imageOptURL = imageOptClient.constructURL(imageURL: imageURL, imageSize: imageSize, crop: false)
        XCTAssertEqual(imageOptURL?.absoluteString, nil)
    }
    
    func testBadURL() {
        let imageSize = CGSize(width: 200,height: 150)
        let badURL = "$%$^%*%^*%^*%&*@34"
        let imageOptURL = imageOptClient.constructURL(imageURL: badURL, imageSize: imageSize, crop: false)
        XCTAssertEqual(imageOptURL?.absoluteString, nil)
    }
    
    func testImageViewFit() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        imageOptClient.constructURL(imageURL: imageURL, imageView: imageView, crop: false, completionHandler: { imageOptURL in
            let expectedURL = self.imageURL + String(format: "?w=%.0f&h=%.0f", imageView.frame.width * self.scale, imageView.frame.height * self.scale)
            XCTAssertEqual(imageOptURL?.absoluteString, expectedURL)
        })
    }
    
    func testImageViewCrop() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 200))
        imageOptClient.constructURL(imageURL: imageURL, imageView: imageView, crop: true, completionHandler: { imageOptURL in
            let expectedURL = self.imageURL + String(format: "?w=%.0f&h=%.0f&c=true", imageView.frame.width * self.scale, imageView.frame.height * self.scale)
            XCTAssertEqual(imageOptURL?.absoluteString, expectedURL)
        })
    }
}
