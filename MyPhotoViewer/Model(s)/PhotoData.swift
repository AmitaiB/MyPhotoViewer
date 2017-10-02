//
//  Photo.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/20/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

struct PhotoData: Decodable, Equatable {
	let albumId: Int
	let id: Int
	let title: String
	let url: URL
	let thumbnailUrl: URL
	
	var cacheKey: String {
		return "albumId: \(albumId); id: \(id)"
	}
	
	var thumbnailCacheKey: String {
		return "\(cacheKey) - thumbnail"
	}

	static func ==(lhs: PhotoData, rhs: PhotoData) -> Bool {
		return lhs.albumId == rhs.albumId
			&& lhs.id == rhs.id
			&& lhs.title == rhs.title
			&& lhs.url == rhs.url
			&& lhs.thumbnailUrl == rhs.thumbnailUrl
			&& lhs.cacheKey == rhs.cacheKey
			&& lhs.thumbnailCacheKey == rhs.thumbnailCacheKey
	}
}

