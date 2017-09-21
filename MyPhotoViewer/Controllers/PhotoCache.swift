//
//  PhotoCache.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/20/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

/// See https://github.com/hyperoslo/Cache
import Cache

class PhotoCache {
	static func getInstance() -> Storage? {
		let diskConfig = DiskConfig(name: "photosDiskCache")
		let expDate = Date().addingTimeInterval(2 * 3600)
		let memoryConfig = MemoryConfig(expiry: .date(expDate), countLimit: 50, totalCostLimit: 50)
		var cache: Storage?
		do {
			cache = try Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)
		}
		catch {
			print(error.localizedDescription)
		}
		return cache
	}
}
