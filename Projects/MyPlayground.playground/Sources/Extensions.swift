//
//  Extensions.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 22/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

extension CGRect {
	public var shortDescription: String {
		return NSString(format: "origin(%@)+size(%@)", origin.shortDescription, size.shortDescription) as String
	}
}

extension CGPoint {
	var shortDescription: String {
		return NSString(format: "%.02f, %.02f", x, y) as String
	}
}

extension CGSize {
	var shortDescription: String {
		return NSString(format: "%.02f, %.02f", width, height) as String
	}
}

extension CGFloat {
	var shortDescription: String {
		return NSString(format: "%.02f", self) as String
	}
}

extension Float {
	var shortDescription: String {
		return NSString(format: "%.02f", self) as String
	}
}

extension Double {
	var shortDescription: String {
		return NSString(format: "%.02f", self) as String
	}
}
