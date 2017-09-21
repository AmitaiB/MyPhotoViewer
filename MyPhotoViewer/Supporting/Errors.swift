//
//  Errors.swift
//  MyPhotoViewer
//
//  Created by Amitai Blickstein on 9/20/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

enum NetworkError: Error {
	case responseFailed(reason: String)
}

enum LocalError: Error {
	case cacheFailed
}

