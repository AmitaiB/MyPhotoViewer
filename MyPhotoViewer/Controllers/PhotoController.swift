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
	static func image(forPhoto photoData: PhotoData, size: PhotoSize = .full, completion: ImageHandler) throws
	{
		
	}
}
