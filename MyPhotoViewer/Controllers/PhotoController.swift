//
//  PhotoController.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/20/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit

enum PhotoSize: String { case full, thumbnail }
typealias ImageHandler = (UIImage) -> ()

class PhotoController {
	static func image(forPhoto photoData: PhotoData, size: PhotoSize = .full, completion: @escaping ImageHandler) throws
	{
		do {
				try fetchImage(forPhoto: photoData, ofSize: size, completion: completion)
			}
	}
		
	/// Attempts to fetch the image from the url.
	private static func fetchImage(forPhoto photoData: PhotoData, ofSize size: PhotoSize, completion: @escaping ImageHandler) throws {
		let urlOfImage = imageURL(of: photoData, in: size)
		
		let handler = { (location: URL?, response: URLResponse?, error: Error?) in
			do {
				if let error = error { throw NetworkError.responseFailed(reason: "Received error: ↴\n\(error.localizedDescription)") }
				guard let location = location else { throw NetworkError.responseFailed(reason: "Cannot locate data.") }
				if let image =  UIImage(data: imageData) {
					DispatchQueue.main.async {
						completion(image)
					}
				}
				
			}
			catch {
				print(error.localizedDescription)
			}
		
		let session = URLSession.shared
		let request = URLRequest(url: urlOfImage)
		let task = session.downloadTask(with: request, completionHandler: handler)
		
		task.resume()
	}
	}
	
}
