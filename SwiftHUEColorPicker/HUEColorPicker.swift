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
		case Brightness
		case Alpha
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
		set(newCurrentColor) {
			color = newCurrentColor
			var hue: CGFloat = 0
			var s: CGFloat = 0
			var b: CGFloat = 0
			var a: CGFloat = 0
			if color.getHue(&hue, saturation: &s, brightness: &b, alpha: &a) {
				hueValue = hue
				saturationValue = s
				brightnessValue = b
				alphaValue = a
				update()
				setNeedsDisplay()
			}
		}
	}
	
	private var color: UIColor = UIColor.clearColor()
	private var currentSelectionY: CGFloat = 0.0
	private var currentSelectionX: CGFloat = 0.0
	private var hueImage: UIImage!
	private var hueValue: CGFloat = 0.0
	private var saturationValue: CGFloat = 1.0
	private var brightnessValue: CGFloat = 1.0
	private var alphaValue: CGFloat = 1.0
	
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
		
		update()
	}
	
	func generateHUEImage(size: CGSize) -> UIImage {
		
		var rect = CGRectMake(0, 0, size.width, size.height)
		UIGraphicsBeginImageContextWithOptions(size, false, 0)
		
		UIBezierPath(roundedRect: rect, cornerRadius: 10.0).addClip()
		
		if direction == .Horizontal {
			for var x: Int = 0; x < Int(size.width); ++x {
				
				switch type {
				case .Color:
					UIColor(hue: CGFloat(CGFloat(x) / size.width), saturation: saturationValue, brightness: brightnessValue, alpha: alphaValue).set()
					break
				case .Saturation:
					UIColor(hue: hueValue, saturation: CGFloat(CGFloat(x) / size.width), brightness: brightnessValue, alpha: alphaValue).set()
					break
				case .Brightness:
					UIColor(hue: hueValue, saturation: saturationValue, brightness: CGFloat(CGFloat(x) / size.width), alpha: alphaValue).set()
					break
				case .Alpha:
					UIColor(hue: hueValue, saturation: saturationValue, brightness: brightnessValue, alpha: CGFloat(CGFloat(x) / size.width)).set()
					break
				}
				
				let temp = CGRectMake(CGFloat(x), 0, 1, size.height)
				UIRectFill(temp)
			}
		}
		else {
			for var y: Int = 0; y < Int(size.height); ++y {
				
				switch type {
				case .Color:
					UIColor(hue: CGFloat(CGFloat(y) / size.height), saturation: saturationValue, brightness: brightnessValue, alpha: alphaValue).set()
					break
				case .Saturation:
					UIColor(hue: hueValue, saturation: CGFloat(CGFloat(y) / size.height), brightness: brightnessValue, alpha: alphaValue).set()
					break
				case .Brightness:
					UIColor(hue: hueValue, saturation: saturationValue, brightness: CGFloat(CGFloat(y) / size.height), alpha: alphaValue).set()
					break
				case .Alpha:
					UIColor(hue: hueValue, saturation: saturationValue, brightness: brightnessValue, alpha: CGFloat(CGFloat(y) / size.height)).set()
					break
				}
				
				let temp = CGRectMake(0, CGFloat(y), size.width, 1)
				UIRectFill(temp)
			}
		}
		
		var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}
	
	func update() {
		let offset = (direction == .Horizontal ? self.frame.size.height : self.frame.size.width)
		let halfOffset = offset * 0.5
		var size = self.frame.size
		if direction == .Horizontal {
			size.width -= offset
		}
		else {
			size.height -= offset
		}
		
		var value: CGFloat = 0
		switch type {
		case .Color:
			value = hueValue
			break
		case .Saturation:
			value = saturationValue
			break
		case .Brightness:
			value = brightnessValue
			break
		case .Alpha:
			value = alphaValue
			break
		}
		currentSelectionX = value * (self.frame.size.width - offset) + halfOffset
		currentSelectionY = value * (self.frame.size.height - offset) + halfOffset
		
		hueImage = generateHUEImage(size)
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
		
		let textColor: UIColor = UIColor.whiteColor()
		let textFont = UIFont(name: "Helvetica Neue", size: 12)
		var textParagraphStyle = NSMutableParagraphStyle()
		textParagraphStyle.alignment = .Center
		
		var attributes: NSDictionary = [NSForegroundColorAttributeName: textColor,
										NSParagraphStyleAttributeName: textParagraphStyle,
										NSFontAttributeName: textFont!]
		
		var value: CGFloat = 0;
		switch type {
		case .Color:
			value = hueValue
			break
		case .Saturation:
			value = saturationValue
			break
		case .Brightness:
			value = brightnessValue
			break
		case .Alpha:
			value = alphaValue
			break
		}
		
		let textValue: Int = Int(value * (type == .Color ? 360 : 100))
		let text: NSString = "\(textValue)"
		var textRect = circleRect
		textRect.origin.y += (textRect.size.height - (textFont?.lineHeight)!) * 0.5
		text.drawInRect(textRect, withAttributes: attributes as [NSObject : AnyObject])
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
		
		let offset = (direction == .Horizontal ? self.frame.size.height : self.frame.size.width)
		let halfOffset = offset * 0.5
		if currentSelectionX < halfOffset {
			currentSelectionX = halfOffset
		}
		else if currentSelectionX >= self.frame.size.width - halfOffset {
			currentSelectionX = self.frame.size.width - halfOffset
		}
		if currentSelectionY < halfOffset {
			currentSelectionY = halfOffset
		}
		else if currentSelectionY >= self.frame.size.height - halfOffset {
			currentSelectionY = self.frame.size.height - halfOffset
		}
		
		let value = (direction == .Horizontal ? CGFloat((currentSelectionX - halfOffset) / (self.frame.size.width - offset))
											  : CGFloat((currentSelectionY - halfOffset) / (self.frame.size.height - offset)))
		
		switch type {
		case .Color:
			hueValue = value
			break
		case .Saturation:
			saturationValue = value
			break
		case .Brightness:
			brightnessValue = value
			break
		case .Alpha:
			alphaValue = value
			break
		}
		
		color = UIColor(hue: hueValue, saturation: saturationValue, brightness: brightnessValue, alpha: alphaValue)
		
		if delegate != nil {
			delegate.valuePicked(color, type: type)
		}
		setNeedsDisplay()
	}
	
}
