//
//  PhotoViewerNavController.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/19/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit

class PhotoViewerNavController: UINavigationController {
	override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
		
		navigationBar.barTintColor = Color(named: .justPeachy)
		navigationBar.barStyle = .blackOpaque
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
