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
	private var hueImage: UIImage!
	
	// Initialization
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.backgroundColor = UIColor.clearColor()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.clearColor()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let offset = (direction == .Horizontal ? self.frame.size.height : self.frame.size.width)
		var size = self.frame.size
		if direction == .Horizontal {
			size.width -= offset
		}
		else {
			size.height -= offset
		}
		hueImage = generateHUEImage(size)
	}
	
	func generateHUEImage(size: CGSize) -> UIImage {
		var rect = CGRectMake(0, 0, size.width, size.height)
		UIGraphicsBeginImageContextWithOptions(size, false, 0)
		
		UIBezierPath(roundedRect: rect, cornerRadius: 10.0).addClip()
		
		if direction == .Horizontal {
			for var x: Int = 0; x < Int(size.width); ++x {
				UIColor(hue: CGFloat(CGFloat(x) / size.width), saturation: 1.0, brightness: 1.0, alpha: 1.0).set()
				let temp = CGRectMake(CGFloat(x), 0, 1, size.height)
				UIRectFill(temp)
			}
		}
		else {
			for var y: Int = 0; y < Int(size.height); ++y {
				UIColor(hue: CGFloat(CGFloat(y) / size.height), saturation: 1.0, brightness: 1.0, alpha: 1.0).set()
				let temp = CGRectMake(0, CGFloat(y), size.width, 1)
				UIRectFill(temp)
			}
		}
		
		var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}
	
	// Drawing
	
	override func drawRect(rect: CGRect) {
		super.drawRect(rect)
		
		let radius = (direction == .Horizontal ? self.frame.size.height : self.frame.size.width)
		let halfRadius = radius * 0.5
		var circleX = currentSelectionX - halfRadius
		var circleY = currentSelectionY - halfRadius
		if circleX >= rect.size.width - radius {
			circleX = rect.size.width - radius
		}
		else if circleX < 0 {
			circleX = 0
		}
		if circleY >= rect.size.height - radius {
			circleY = rect.size.height - radius
		}
		else if circleY < 0 {
			circleY = 0
		}
		
		let circleRect = (direction == .Horizontal ? CGRectMake(circleX, 0, radius, radius) : CGRectMake(0, circleY, radius, radius))
		let circleColor = UIColor.blackColor()
		var hueRect = rect
		
		if hueImage != nil {
			if direction == .Horizontal {
				hueRect.size.width -= radius
				hueRect.origin.x += halfRadius
			}
			else {
				hueRect.size.height -= radius
				hueRect.origin.y += halfRadius
			}
			hueImage.drawInRect(hueRect)
		}
		
		let context = UIGraphicsGetCurrentContext();
		circleColor.set()
		CGContextAddEllipseInRect(context, circleRect);
		CGContextSetFillColor(context, CGColorGetComponents(circleColor.CGColor));
		CGContextFillPath(context);
		CGContextStrokePath(context);
	}
	
	// Touch events
	
	override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		let point = touch!.locationInView(self)
		handleTouch(point)
	}
	
	override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		let point = touch!.locationInView(self)
		handleTouch(point)
	}
	
	override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		let point = touch!.locationInView(self)
		handleTouch(point)
	}
	
	override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
		
	}

	// Touch handling
	
	func handleTouch(touchPoint: CGPoint) {
		currentSelectionX = touchPoint.x
		currentSelectionY = touchPoint.y
		
		let hue: CGFloat = (direction == .Horizontal ? CGFloat(currentSelectionX / self.frame.size.width) : CGFloat(currentSelectionY / self.frame.size.height))
		color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
		
		if delegate != nil {
			delegate.valuePicked(color, type: type)
		}
		setNeedsDisplay()
	}
	
}
