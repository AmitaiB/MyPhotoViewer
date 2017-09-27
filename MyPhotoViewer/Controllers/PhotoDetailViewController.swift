//
//  PhotoDetailViewController.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/23/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
	var photo: PhotoData?
	var imageView = UIImageView(image: Asset.placeholderIcon.image)
	var captionView = UITextView()
	
	override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = UIColor(named: .clouds)
		view.addSubview(imageView)
		setupImageView()
		
		view.addSubview(captionView)
		setupCaptionView()
		
		setupTapToDismiss()
	}

	var offscreenRect: CGRect {
		let fullscreenWidth = UIScreen.main.bounds.size.width
		let squareSize = CGSize(width: fullscreenWidth,
		                        height: fullscreenWidth)
		let offscreenY = UIScreen.main.bounds.minY * 1.5
		let offscreenPoint = CGPoint(x: 0, y: offscreenY)
		let offscreenRect = CGRect(origin: offscreenPoint, size: squareSize)
		
		return offscreenRect
	}
	
	fileprivate func setupImageView() {
		imageView.frame = offscreenRect
		
		if let photo = photo {
			do {
				try PhotoImageFetcher.image(forPhoto: photo,
				                            size: .full,
				                            completion: { self.imageView.image = $0 })
			} catch {
				print(error.localizedDescription)
			}
		}
	}

	fileprivate func setupCaptionView() {
		setupCaptionTextView()
		setupCaptionViewConstraints()
	}
	
	fileprivate func setupCaptionTextView() {
		captionView.textContainer.lineBreakMode = .byWordWrapping
		captionView.textAlignment = .justified
		
		if let photo = photo {
			captionView.text = photo.title
		}
	}
	
	fileprivate func setupCaptionViewConstraints() {
		captionView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([captionViewLeadingConstraint,
		                             captionViewTrailingConstraint,
		                             captionViewHeightConstraint,
		                             imageCaptionBoundaryConstraint])
	}
	
	var captionViewLeadingConstraint: NSLayoutConstraint {
		return NSLayoutConstraint(item: captionView, attribute: .leading, relatedBy: .equal,
		                          toItem: imageView, attribute: .leading, multiplier: 1.0, constant: 0.0)
	}
	
	var captionViewTrailingConstraint: NSLayoutConstraint {
		return NSLayoutConstraint(item: captionView, attribute: .trailing, relatedBy: .equal,
		                          toItem: imageView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
	}
	
	var captionViewHeightConstraint: NSLayoutConstraint {
		return NSLayoutConstraint(item: captionView, attribute: .height, relatedBy: .equal,
		                          toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 26)
	}
	
	var imageCaptionBoundaryConstraint: NSLayoutConstraint {
		return NSLayoutConstraint(item: captionView, attribute: .top, relatedBy: .equal,
		                          toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 8.0)
	}

	
	fileprivate func setupTapToDismiss() {
		let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissDetailView))
		view.addGestureRecognizer(tapToDismiss)
	}
	
	@objc fileprivate func dismissDetailView() {
		presentingViewController?.dismiss(animated: true, completion: nil)
	}
}

