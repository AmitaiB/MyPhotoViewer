//
//  AppDelegate.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/19/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		
		let photosViewController = PhotoCollectionViewController()
		let navController = PhotoViewerNavController(rootViewController: photosViewController)
		
		window?.rootViewController = navController
		window?.backgroundColor = Color.white
		window?.makeKeyAndVisible()
		
		return true
	}
}
