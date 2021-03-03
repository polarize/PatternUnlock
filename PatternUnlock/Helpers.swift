//
//  Helpers.swift
//  PatternUnlock
//
//  Created by Issam Bendaas on 03.03.21.
//

import UIKit

extension CGPoint {
	var toPoint: Point {
		return Point(x: Float(x), y: Float(y))
	}
}

extension Point {
	var toCGPoint: CGPoint {
		return CGPoint(x: CGFloat(x), y: CGFloat(y))
	}
}

