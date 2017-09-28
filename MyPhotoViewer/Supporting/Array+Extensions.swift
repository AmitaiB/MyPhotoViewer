//
//  Array+Extensions.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/27/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation


extension Array {
	/// - returns: If the value does not exist or cannot be accessed, returns a `nil` optional.
	subscript (safe index: Int) -> Element? {
		return index < count ? self[index] : nil
	}
}

