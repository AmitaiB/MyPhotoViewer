//
//  PresentDetailTransition.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/24/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit

class PresentDetailTransition: NSObject, UIViewControllerAnimatedTransitioning {
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.3
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard let detail = transitionContext.viewController(forKey: .to) else {
			fatalError("Could not get a reference to the detail view controller.") }
		let containerView = transitionContext.containerView
		
		detail.view.alpha = 0.0
		
		var frame = containerView.bounds
		frame.origin.y += 20.0
		frame.size.height -= 20.0
		detail.view.frame = frame
		containerView.addSubview(detail.view)
		
		let detailViewAppear = { detail.view.alpha = 1.0 }
		let notifyContext_TransitionComplete = { (finished: Bool) in transitionContext.completeTransition(true) }
		
		UIView.animate(withDuration: 0.15,
		               animations: detailViewAppear,
		               completion: notifyContext_TransitionComplete)
	}
	
	
}
