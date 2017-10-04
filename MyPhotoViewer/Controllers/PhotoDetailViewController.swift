//
//  PhotoDetailViewController.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/23/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit

let kTossingThreshold: CGFloat = 1000
let kTossingVelicotyPadding: CGFloat = 35

class PhotoDetailViewController: UIViewController {
	var photo: PhotoData?
	var imageView = UIImageView(image: Asset.placeholderIcon.image)
	var captionView = UITextView()
	
	private var imageInset: CGFloat = 5.0
	
	private var animator: UIDynamicAnimator?
	
	private var originalBounds = CGRect.zero
	private var originalCenter = CGPoint.zero
	
	private var attachmentBehavior: UIAttachmentBehavior!
	private var pushBehavior: UIPushBehavior!
	private var itemBehavior: UIDynamicItemBehavior!
	
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = UIColor(named: .clouds).withAlphaComponent(0.4)
		setupImageView()
		setImage()
		setupTapToDismiss()
		setupSwipeToTossView()
		setupCaptionView()
	
		animator = UIDynamicAnimator(referenceView: view)
		animator?.delegate = self
	}
	
	func setupSwipeToTossView() {
		let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleAttachmentGesture(sender:)))
		view.addGestureRecognizer(panRecognizer)
		
		originalBounds = imageView.bounds
		originalCenter = view.center
	}
	
	
	@objc func handleAttachmentGesture(sender: UIPanGestureRecognizer) {
		let location = sender.location(in: view)
		let boxLocation = sender.location(in: imageView)
		
		switch sender.state {
		case .began:
			print("\nYour touch start position is \(location)")
			print("Start location in image is \(boxLocation)")
			
			let centerOffset = UIOffset(horizontal: boxLocation.x - imageView.bounds.midX,
			                            vertical: boxLocation.y - imageView.bounds.midY)
			attachmentBehavior = UIAttachmentBehavior(item: imageView,
			                                          offsetFromCenter: centerOffset,
			                                          attachedToAnchor: location)
			animator?.removeAllBehaviors()
			animator?.addBehavior(attachmentBehavior)
			
		case .ended:
			print("\nYour touch end position is \(location)")
			print("End location in image is \(boxLocation)")
			
			handleEnd(of: sender)
			
		default:
			attachmentBehavior.anchorPoint = sender.location(in: view)
		}
	}
	
	
	private func handleEnd(of sender: UIPanGestureRecognizer) {
		let velocity = sender.velocity(in: view)
		let dx = velocity.x, dy = velocity.y
		let magnitude = sqrt((dx * dx) + (dy * dy))
		
		if magnitude > kTossingThreshold {
			// push behavior
			let aPushBehavior = UIPushBehavior(items: [imageView], mode: .instantaneous)
			aPushBehavior.pushDirection = CGVector(dx: dx / 10, dy: dy / 10)
			aPushBehavior.magnitude = magnitude / kTossingVelicotyPadding
			
			pushBehavior = aPushBehavior
			animator?.addBehavior(pushBehavior)
			
			// item behvior
			let angle = Int(arc4random_uniform(20)) - 10
			itemBehavior = UIDynamicItemBehavior(items: [imageView])
			itemBehavior.friction = 0.2
			itemBehavior.allowsRotation = true
			itemBehavior.addAngularVelocity(CGFloat(angle), for: imageView)
			
			animator?.addBehavior(itemBehavior)
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
				self.resetDraggedView()
			}
		}
		else {
			resetDraggedView()
		}
	}
	
	func resetDraggedView() {
		animator?.removeAllBehaviors()
		
		UIView.animate(withDuration: 0.3) {
			self.imageView.bounds = self.originalBounds
			self.imageView.center = self.originalCenter
			self.imageView.transform = CGAffineTransform.identity
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let snapToCenter = UISnapBehavior(item: imageView, snapTo: view.center.offsetBy(dy: -50))
		animator?.addBehavior(snapToCenter)
	}

	
	// MARK: UIImageView (photo)
	
	fileprivate func setupImageView() {
		imageView.frame = offScreenRect.insetBy(dx: imageInset, dy: imageInset)
		imageView.layer.cornerRadius = 3
		imageView.layer.masksToBounds = true
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
		captionView.textAlignment = .center
		captionView.text = photo?.title
		captionView.backgroundColor = Color(named: .pumpkin).withAlphaComponent(0.5)

		captionView.layer.cornerRadius = 5
		captionView.layer.masksToBounds = true
		
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
		                          toItem: imageView, attribute: .leading, multiplier: 1.0, constant: 20.0)
	}
	
	fileprivate var captionViewTrailingConstraint: NSLayoutConstraint {
		return NSLayoutConstraint(item: captionView, attribute: .trailing, relatedBy: .equal,
		                          toItem: imageView, attribute: .trailing, multiplier: 1.0, constant: -20.0)
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
		animator?.removeAllBehaviors()
		
		let snapDownOffscreen = UISnapBehavior(item: imageView, snapTo: view.center.offsetBy(dy: 500))
		animator?.addBehavior(snapDownOffscreen)
		
		presentingViewController?.dismiss(animated: true, completion: nil)
	}
}


// MARK: - UIDynamicAnimatorDelegate

extension PhotoDetailViewController: UIDynamicAnimatorDelegate {
	func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
		UIView.animate(withDuration: 0.01, animations: { self.captionView.alpha = 1 })
	}
	
	func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
		UIView.animate(withDuration: 0.01, animations: { self.captionView.alpha = 0 })
	}
}


fileprivate extension CGPoint {
	func offsetBy(dx: CGFloat = 0, dy: CGFloat = 0) -> CGPoint {
		return CGPoint(x: x + dx, y: y + dy)
	}
}
