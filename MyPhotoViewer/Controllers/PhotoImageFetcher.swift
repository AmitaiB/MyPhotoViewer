//
// PhotoController.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/20/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit
import Cache

enum PhotoSize: String { case full, thumbnail }
typealias ImageHandler = (UIImage) -> ()


class PhotoImageFetcher {
	static let cache = PhotoCache.getInstance()
	
	static func image(forPhoto photoData: PhotoData, size: PhotoSize = .full, completion: @escaping ImageHandler) throws
	{
		do {
			if let image = try retrieveImage(forPhoto: photoData, ofSize: size, from: cache) {
				completion(image)
			}
			else {
				try fetchImage(forPhoto: photoData, ofSize: size, completion: completion)
			}
		}
	}
	
	// MARK: Helper functions
	
	/// Attempts to retreive the image from the cache, returning `nil` if not found.
	private static func retrieveImage(forPhoto photoData: PhotoData, ofSize size: PhotoSize, from cache: Storage?) throws -> Image? {
		guard let theCache = cache else { throw LocalError.cacheFailed }
		
		let imageKey = size == .full ? photoData.cacheKey : photoData.thumbnailCacheKey
		do {
			return try theCache.object(ofType: ImageWrapper.self, forKey: imageKey).image
		}
		catch {
			print(error.localizedDescription)
			return nil
		}
	}
	
	/// Attempts to fetch the image from the url.
	private static func fetchImage(forPhoto photoData: PhotoData, ofSize size: PhotoSize, completion: @escaping ImageHandler) throws {
		let urlOfImage = imageURL(of: photoData, in: size)
		
		let handler = { (location: URL?, response: URLResponse?, error: Error?) in
			do {
				if let error = error { throw NetworkError.responseFailed(reason: "Received error: ↴\n\(error.localizedDescription)") }
				guard let location = location else { throw NetworkError.responseFailed(reason: "Cannot locate data.") }
				
				let imageCacheKey = imageKey(of: photoData, in: size)
				let imageData = try Data(contentsOf: location)
				if let image = UIImage(data: imageData) {
					let wrapper = ImageWrapper(image: image)
					try cache?.setObject(wrapper, forKey: imageCacheKey)
					
					DispatchQueue.main.async {
						completion(image)
					}
				}
				
			}
			catch {
				print(error.localizedDescription)
			}
		}
		
		let session = URLSession.shared
		let request = URLRequest(url: urlOfImage)
		let task = session.downloadTask(with: request, completionHandler: handler)
		
		task.resume()
	}
	
	private static func imageKey(of photoData: PhotoData, in size: PhotoSize) -> String {
		return size == .full ? photoData.cacheKey : photoData.thumbnailCacheKey
	}
	
	private static func imageURL(of photoData: PhotoData, in size: PhotoSize) -> URL {
		return size == .full ? photoData.url : photoData.thumbnailUrl
	}
}

