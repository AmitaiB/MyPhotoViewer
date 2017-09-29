//
//  PhotoCell.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/20/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
	var imageView: UIImageView
	var photo: PhotoData? {
		didSet {
			setPhoto(photo)
		}
	}
	
	override init(frame: CGRect) {
		imageView = UIImageView()
		
		super.init(frame: frame)
		
		contentView.addSubview(imageView)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		imageView.frame = contentView.bounds
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setPhoto(_ photoData: PhotoData?) {
		guard let photo = photoData else { return }
		
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
