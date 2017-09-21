//
//  Photo.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/20/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

struct PhotoData: Decodable {
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
}

