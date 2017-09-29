//
//  Optional+Extensions.swift
//  MyPhotoViewer
//
//  from: OptionalExtensions
//
//  Created by Rui Peres on 30/12/2015.
//  Copyright © 2015 Rui Peres. All rights reserved.
//

public extension Optional {
	
	func filter(_ predicate: (Wrapped) -> Bool) -> Optional {
		return map(predicate) == .some(true) ? self : .none
	}
	
	func mapNil(_ predicate: () -> Wrapped) -> Optional {
		return self ?? .some(predicate())
	}
	
	func flatMapNil(_ predicate: () -> Optional) -> Optional {
		return self ?? predicate()
	}
	
	func then(_ f: (Wrapped) -> Void) {
		if let wrapped = self { f(wrapped) }
	}
	
	func maybe<U>(_ defaultValue: U, f: (Wrapped) -> U) -> U {
		return map(f) ?? defaultValue
	}
	
	func onSome(_ f: (Wrapped) -> Void) -> Optional {
		then(f)
		return self
	}
	
	func onNone(_ f: () -> Void) -> Optional {
		if isNone { f() }
		return self
	}
	
	var isSome: Bool {
		return self != nil
	}
	
	var isNone: Bool {
		return !isSome
	}
}

//
// Additions by Amitai Blickstein
//

infix operator ?=

/// Syntactic sugar for `optional = optional ?? `default``
public func ?=<T>(optional: inout T?, default: T) {
	optional = optional ?? `default`
}



