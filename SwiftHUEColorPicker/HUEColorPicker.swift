//
//  HUEColorPicker.swift
//  SwiftHUEColorPicker
//
//  Created by Maxim Bilan on 5/6/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit

protocol HUEColorPickerDelegate {
	func valuePicked(color: UIColor, type: HUEColorPicker.PickerType)
}

class HUEColorPicker: UIView {
	
	enum PickerType: Int {
		case Color
		case Saturation
		case Luminosity
	}
	
	enum PickerDirection: Int {
		case Horizontal
		case Vertical
	}
	
	var delegate: HUEColorPickerDelegate!
	var type: PickerType = .Color
	var direction: PickerDirection = .Horizontal
	var currentColor: UIColor {
		get {
			return color
		}
	}
	
	private var color: UIColor!
	private var currentSelectionY: CGFloat = 0.0
	private var currentSelectionX: CGFloat = 0.0
	private var roundedRectPath: UIBezierPath!
	
	// Initialization
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.backgroundColor = UIColor.clearColor()
		roundedRectPath = UIBezierPath(roundedRect: self.frame, cornerRadius: 50)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.clearColor()
		roundedRectPath = UIBezierPath(roundedRect: self.frame, cornerRadius: 50)
	}
	
	// Drawing
	
	override func drawRect(rect: CGRect) {
		super.drawRect(rect)
		
		UIColor.blackColor().set()
		var tempYPlace = currentSelectionY
		if tempYPlace < 0.0 {
			tempYPlace = 0.0
		}
		else if (tempYPlace >= self.frame.size.height) {
			tempYPlace = self.frame.size.height - 1.0
		}
		
		var tempXPlace = currentSelectionX
		if tempXPlace < 0.0 {
			tempXPlace = 0.0
		}
		else if (tempXPlace >= self.frame.size.width) {
			tempXPlace = self.frame.size.width - 1.0
		}
		
		var temp = (direction == .Horizontal ? CGRectMake(tempXPlace, 0, 1.0, self.frame.size.height) : CGRectMake(0, tempYPlace, self.frame.size.width, 1.0))
		UIRectFill(temp)
		
		if direction == .Horizontal {
			let offset = 0//self.frame.size.height * 0.5
			//let cbHeight = self.frame.size.height * 0.8
			for var x: Int = 0; x < Int(self.frame.size.width); ++x {
				UIColor(hue: CGFloat(CGFloat(x) / self.frame.size.width), saturation: 1.0, brightness: 1.0, alpha: 1.0).set()
				let temp = CGRectMake(CGFloat(x), 0, 1, self.frame.size.height)
				UIRectFill(temp)
			}
		}
		else {
			let cbxBegin = self.frame.size.width * 0.2
			let cbWidth = self.frame.size.width * 0.6
			for var y: Int = 0; y < Int(self.frame.size.height); ++y {
				UIColor(hue: CGFloat(CGFloat(y) / self.frame.size.height), saturation: 1.0, brightness: 1.0, alpha: 1.0).set()
				let temp = CGRectMake(cbxBegin, CGFloat(y), cbWidth, 1)
				UIRectFill(temp)
			}
		}
		
		
		let radius = self.frame.size.height
		let circleRect = CGRectMake(currentSelectionX - radius * 0.5, 0, radius, radius)
		let context = UIGraphicsGetCurrentContext();
//		CGContextAddEllipseInRect(context, circleRect);
//		CGContextSetFillColor(context, CGColorGetComponents(UIColor.whiteColor().CGColor));
//		CGContextFillPath(context);
//		CGContextStrokePath(context);
		
		UIColor.whiteColor().set()
		
		CGContextAddEllipseInRect(context, circleRect);
		CGContextSetFillColor(context, CGColorGetComponents(UIColor.whiteColor().CGColor));
		CGContextFillPath(context);
		CGContextStrokePath(context);
		
		UIColor.clearColor().set()
		
		CGContextAddPath(context, roundedRectPath.CGPath)
		CGContextFillPath(context);
		CGContextStrokePath(context);
	}
	
	// Touch events
	
	override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		let point = touch!.locationInView(self)
		currentSelectionX = point.x
		currentSelectionY = point.y
		
		let hue: CGFloat = (direction == .Horizontal ? CGFloat(currentSelectionX / self.frame.size.width) : CGFloat(currentSelectionY / self.frame.size.height))
		color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
		
		if delegate != nil {
			delegate.valuePicked(color, type: type)
		}
		setNeedsDisplay()
	}
	
	override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		let point = touch!.locationInView(self)
		currentSelectionX = point.x
		currentSelectionY = point.y
		
		let hue: CGFloat = (direction == .Horizontal ? CGFloat(currentSelectionX / self.frame.size.width) : CGFloat(currentSelectionY / self.frame.size.height))
		color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
		
		if delegate != nil {
			delegate.valuePicked(color, type: type)
		}
		setNeedsDisplay()
	}
	
	override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		let point = touch!.locationInView(self)
		currentSelectionX = point.x
		currentSelectionY = point.y
		
		let hue: CGFloat = (direction == .Horizontal ? CGFloat(currentSelectionX / self.frame.size.width) : CGFloat(currentSelectionY / self.frame.size.height))
		color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
		
		if delegate != nil {
			delegate.valuePicked(color, type: type)
		}
		setNeedsDisplay()
	}
	
	override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
		
	}

}
