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
	var animator: UIDynamicAnimator?
	
	override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = UIColor(named: .clouds).withAlphaComponent(0.9)
		setupImageView()
		setImage()
		setupTapToDismiss()
		setupCaptionView()
	
		animator = UIDynamicAnimator(referenceView: view)
		animator?.delegate = self
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let snapToCenter = UISnapBehavior(item: imageView, snapTo: view.center)
		animator?.addBehavior(snapToCenter)
	}

	
	// MARK: UIImageView (photo)
	
	fileprivate func setupImageView() {
		imageView.frame = offScreenRect
		view.addSubview(imageView)
	}
	
	fileprivate func setImage() {
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

	fileprivate var offScreenRect: CGRect {
		let fullscreenWidth = UIScreen.main.bounds.size.width
		let offscreenY = abs(UIScreen.main.bounds.maxY) * -2
		return CGRect(x: 0, y: offscreenY, width: fullscreenWidth, height: fullscreenWidth)
	}
	
	
	// MARK: UITextView (title/caption)
	fileprivate func setupCaptionView() {
		view.addSubview(captionView)
		captionView.textContainer.lineBreakMode = .byWordWrapping
		captionView.textAlignment = .justified
		captionView.text = photo?.title
		
		setupCaptionViewConstraints()
		captionView.alpha = 0
	}
	
	fileprivate func setupCaptionViewConstraints() {
		captionView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([captionViewLeadingConstraint,
		                             captionViewTrailingConstraint,
		                             captionViewHeightConstraint,
		                             imageCaptionBoundaryConstraint])
	}
	
	fileprivate var captionViewLeadingConstraint: NSLayoutConstraint {
		return NSLayoutConstraint(item: captionView, attribute: .leading, relatedBy: .equal,
		                          toItem: imageView, attribute: .leading, multiplier: 1.0, constant: 0.0)
	}
	
	fileprivate var captionViewTrailingConstraint: NSLayoutConstraint {
		return NSLayoutConstraint(item: captionView, attribute: .trailing, relatedBy: .equal,
		                          toItem: imageView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
	}
	
	fileprivate var captionViewHeightConstraint: NSLayoutConstraint {
		return NSLayoutConstraint(item: captionView, attribute: .height, relatedBy: .equal,
		                          toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 26)
	}
	
	fileprivate var imageCaptionBoundaryConstraint: NSLayoutConstraint {
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


// MARK: - UIDynamicAnimatorDelegate

extension PhotoDetailViewController: UIDynamicAnimatorDelegate {
	func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
		UIView.animate(withDuration: 0.1, animations: { self.captionView.alpha = 1 })
	}
	
	func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
		UIView.animate(withDuration: 0.1, animations: { self.captionView.alpha = 0 })
	}
}

