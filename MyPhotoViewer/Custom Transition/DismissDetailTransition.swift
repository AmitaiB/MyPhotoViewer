//
//  PresentDetailTransition.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/24/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit

class DismissDetailTransition: NSObject, UIViewControllerAnimatedTransitioning {
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.3
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		guard let detail = transitionContext.viewController(forKey: .from) else {
			fatalError("Could not get a reference to the detail view controller.")
		}
		
		UIView.animate(withDuration: 0.3, animations: { detail.view.alpha = 0.0 }) { finished in
			detail.view.removeFromSuperview()
			transitionContext.completeTransition(finished)
		}
	}
}
