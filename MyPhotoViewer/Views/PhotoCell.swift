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
	var photo: PhotoData? {
		didSet {
			setPhoto(photo)
		}
	}
	
	func setPhoto(_ photo: PhotoData?) {
		guard let photo = photo else { return }
		
		do {
			try PhotoImageFetcher.image(forPhoto: photo, size: .thumbnail) { self.imageView.image = $0 }
		} catch {
			print(error.localizedDescription)
		}
	}

	override func prepareForReuse() {
		photo = nil
		imageView.image = Asset.placeholderIcon.image
	}
}
