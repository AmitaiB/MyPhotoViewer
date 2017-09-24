//
//  PhotoCell.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/20/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView!
	var photo: PhotoData?
	
	func setPhoto(_ photo: PhotoData) {
		do {
			try PhotoImageFetcher.image(forPhoto: photo, size: .thumbnail) { self.imageView.image = $0 }
		} catch {
			print(error.localizedDescription)
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		imageView.frame = contentView.bounds
	}
}
