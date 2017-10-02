//
//  ImageFetcherAsyncTests.swift
//  MyPhotoViewerTests
//
//  Created by Amitai Blickstein on 10/1/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import XCTest
@testable import MyPhotoViewer


class ImageFetcherAsyncTests: XCTestCase {
	var imageFetcherUnderTest: PhotoImageFetcher!
	let photoModel = PhotoData(albumId: 1,
	                           id: 1,
	                           title: "accusamus beatae ad facilis cum similique qui sunt",
	                           url: URL(string: "http://placehold.it/600/92c952")!,
	                           thumbnailUrl: URL(string: "http://placehold.it/150/92c952")!)
	
    override func setUp() {
        super.setUp()
		
		imageFetcherUnderTest = PhotoImageFetcher()
    }
    
    override func tearDown() {
		imageFetcherUnderTest = nil
		
        super.tearDown()
    }
    
	func testFetcherInitialization() {
		XCTAssertNotNil(imageFetcherUnderTest)
	}
	
	func testFetchingImageAsync() {
		var imageForCacheRetrievalTest: UIImage?
		
		// given
		let promise = expectation(description: "Image fetched from remote server.")
		
		do {
			try PhotoImageFetcher.image(forPhoto: photoModel) { image in
				XCTAssertNotNil(image)
				imageForCacheRetrievalTest = image
				promise.fulfill()
			}
		}
		catch {
			XCTFail("Did not retrieve image from server, with error:\n\(error.localizedDescription)")
		}
	
		waitForExpectations(timeout: 3, handler: nil)
		
		
		let retreivedImage = try? PhotoImageFetcher.retrieveImage(forPhoto: photoModel, ofSize: .full)
		XCTAssertNotNil(retreivedImage)
		XCTAssertEqual(imageForCacheRetrievalTest, retreivedImage!)
	}
	
	
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
