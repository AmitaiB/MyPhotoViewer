//
//  PhotoModelTests.swift
//  MyPhotoViewerTests
//
//  Created by Amitai Blickstein on 10/1/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import XCTest
@testable import MyPhotoViewer


class PhotoModelTests: XCTestCase {
	var photoModelUnderTest: PhotoData!
	
    override func setUp() {
        super.setUp()
		
		photoModelUnderTest = PhotoData(albumId: 1,
		                                id: 1,
		                                title: "accusamus beatae ad facilis cum similique qui sunt",
		                                url: URL(string: "http://placehold.it/600/92c952")!,
		                                thumbnailUrl: URL(string: "http://placehold.it/150/92c952")!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
		
		photoModelUnderTest = nil
    }
	
	
	func testPhotoModelInitialization() {
//		 given
		let anotherPhotoObject = PhotoData(albumId: 1,
		                                   id: 2,
		                                   title: "reprehenderit est deserunt velit ipsam",
		                                   url: URL(string: "http://placehold.it/600/771796")!,
		                                   thumbnailUrl: URL(string: "http://placehold.it/150/771796")!)
//		 when
//		 then
		XCTAssertNotNil(anotherPhotoObject)
	}
	
	func testPhotoEquality() {
		let anotherPhotoObject = PhotoData(albumId: 1,
		                                   id: 2,
		                                   title: "reprehenderit est deserunt velit ipsam",
		                                   url: URL(string: "http://placehold.it/600/771796")!,
		                                   thumbnailUrl: URL(string: "http://placehold.it/150/771796")!)
		
		let shouldBeEqualObject: PhotoData! = PhotoData(albumId: 1,
		                                                id: 1,
		                                                title: "accusamus beatae ad facilis cum similique qui sunt",
		                                                url: URL(string: "http://placehold.it/600/92c952")!,
		                                                thumbnailUrl: URL(string: "http://placehold.it/150/92c952")!)
		//		 when
		//		 then
		XCTAssertNotEqual(photoModelUnderTest, anotherPhotoObject)
		XCTAssertEqual(photoModelUnderTest, shouldBeEqualObject)
	}
	
	func testModelDeserialization() {
//		given
		let decoder = JSONDecoder()
//		when
		
//		then
		let photosArr = try? decoder.decode([PhotoData].self, from: exampleJSONData)
		
		XCTAssertNotNil(photosArr)
		XCTAssertNotNil(photosArr?.first)
		XCTAssertEqual(photosArr?.first!, photoModelUnderTest)
	}
	
	
	var exampleJSONData =
"""
[
	{
		"albumId": 1,
		"id": 1,
		"title": "accusamus beatae ad facilis cum similique qui sunt",
		"url": "http://placehold.it/600/92c952",
		"thumbnailUrl": "http://placehold.it/150/92c952"
	},
	{
		"albumId": 1,
		"id": 2,
		"title": "reprehenderit est deserunt velit ipsam",
		"url": "http://placehold.it/600/771796",
		"thumbnailUrl": "http://placehold.it/150/771796"
	},
	{
		"albumId": 1,
		"id": 3,
		"title": "officia porro iure quia iusto qui ipsa ut modi",
		"url": "http://placehold.it/600/24f355",
		"thumbnailUrl": "http://placehold.it/150/24f355"
	}
]
""".data(using: .utf8)!

}
