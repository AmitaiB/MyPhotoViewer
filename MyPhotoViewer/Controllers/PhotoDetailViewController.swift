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
	var imageView: UIImageView?

	override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = UIColor(named: .clouds)
		setupImageView()
		setupTapToDismiss()
	}
	
	
	fileprivate func setupImageView() {
		let fullscreensWidth = UIScreen.main.bounds.size.width
		let offScreen = CGRect(x: 0, y: UIScreen.main.bounds.minY, width: fullscreensWidth, height: fullscreensWidth)
		imageView = UIImageView(frame: offScreen)
		
		if let imageView = imageView, let photo = photo {
			view.addSubview(imageView)
			do {
				try PhotoImageFetcher.image(forPhoto: photo,
				                            size: .full,
				                            completion: { imageView.image = $0 })
			} catch {
				print(error.localizedDescription)
			}
		}
	}
	
	fileprivate func setupTapToDismiss() {
		let tapToDismiss = UITapGestureRecognizer(target: self, action: .dismissDetailView)
		view.addGestureRecognizer(tapToDismiss)
	}
	
	@objc fileprivate func dismissDetailView() {
		presentingViewController?.dismiss(animated: true, completion: nil)
	}
}

// MARK: cleanliness code
fileprivate extension Selector {
	static let dismissDetailView = #selector(PhotoDetailViewController.dismissDetailView)
}

