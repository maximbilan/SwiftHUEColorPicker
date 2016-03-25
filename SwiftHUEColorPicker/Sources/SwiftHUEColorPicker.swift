//
//  SwiftHUEColorPicker.swift
//  SwiftHUEColorPicker
//
//  Created by Maxim Bilan on 5/6/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit

public protocol SwiftHUEColorPickerDelegate : class {
	func valuePicked(color: UIColor, type: SwiftHUEColorPicker.PickerType)
}

public class SwiftHUEColorPicker: UIView {
	
	// MARK: - Type
	
	public enum PickerType: Int {
		case Color
		case Saturation
		case Brightness
		case Alpha
	}
	
	// MARK: - Direction
	
	public enum PickerDirection: Int {
		case Horizontal
		case Vertical
	}
	
	// MARK: - Constants
	
	let HUEMaxValue: CGFloat = 360
	let PercentMaxValue: CGFloat = 100
	
	// MARK: - Main public properties
	
	public weak var delegate: SwiftHUEColorPickerDelegate!
	public var type: PickerType = .Color
	public var direction: PickerDirection = .Horizontal
	public var currentColor: UIColor {
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
				var needUpdate = false
				if hueValue != hue {
					needUpdate = true
				}
				
				hueValue = hue
				saturationValue = s
				brightnessValue = b
				alphaValue = a
				
				if needUpdate && hueValue > 0 && hueValue < 1 {
					update()
					setNeedsDisplay()
				}
			}
		}
	}
	
	// MARK: - Additional public properties
	
	public var labelFontColor: UIColor = UIColor.whiteColor()
	public var labelBackgroundColor: UIColor = UIColor.blackColor()
	public var labelFont = UIFont(name: "Helvetica Neue", size: 12)
	public var cornerRadius: CGFloat = 10.0
	
	// MARK: - Private properties
	
	private var color: UIColor = UIColor.clearColor()
	private var currentSelectionY: CGFloat = 0.0
	private var currentSelectionX: CGFloat = 0.0
	private var hueImage: UIImage!
	private var hueValue: CGFloat = 0.0
	private var saturationValue: CGFloat = 1.0
	private var brightnessValue: CGFloat = 1.0
	private var alphaValue: CGFloat = 1.0
	
	// MARK: - Initialization
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.backgroundColor = UIColor.clearColor()
	}
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.clearColor()
	}
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		
		update()
	}
	
	// MARK: - Prerendering
	
	func generateHUEImage(size: CGSize) -> UIImage {
		
		let rect = CGRectMake(0, 0, size.width, size.height)
		UIGraphicsBeginImageContextWithOptions(size, false, 0)
		
		UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
		
		if direction == .Horizontal {
			for x: Int in 0 ..< Int(size.width) {
				
				switch type {
				case .Color:
					UIColor(hue: CGFloat(CGFloat(x) / size.width), saturation: 1.0, brightness: 1.0, alpha: 1.0).set()
					break
				case .Saturation:
					UIColor(hue: hueValue, saturation: CGFloat(CGFloat(x) / size.width), brightness: 1.0, alpha: 1.0).set()
					break
				case .Brightness:
					UIColor(hue: hueValue, saturation: 1.0, brightness: CGFloat(CGFloat(x) / size.width), alpha: 1.0).set()
					break
				case .Alpha:
					UIColor(hue: hueValue, saturation: 1.0, brightness: 1.0, alpha: CGFloat(CGFloat(x) / size.width)).set()
					break
				}
				
				let temp = CGRectMake(CGFloat(x), 0, 1, size.height)
				UIRectFill(temp)
			}
		}
		else {
			for y: Int in 0 ..< Int(size.height) {
				
				switch type {
				case .Color:
					UIColor(hue: CGFloat(CGFloat(y) / size.height), saturation: 1.0, brightness: 1.0, alpha: 1.0).set()
					break
				case .Saturation:
					UIColor(hue: hueValue, saturation: CGFloat(CGFloat(y) / size.height), brightness: 1.0, alpha: 1.0).set()
					break
				case .Brightness:
					UIColor(hue: hueValue, saturation: 1.0, brightness: CGFloat(CGFloat(y) / size.height), alpha: 1.0).set()
					break
				case .Alpha:
					UIColor(hue: hueValue, saturation: 1.0, brightness: 1.0, alpha: CGFloat(CGFloat(y) / size.height)).set()
					break
				}
				
				let temp = CGRectMake(0, CGFloat(y), size.width, 1)
				UIRectFill(temp)
			}
		}
		
		let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}
	
	// MARK: - Updating
	
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
		
		currentSelectionX = (value * size.width) + halfOffset
		currentSelectionY = (value * size.height) + halfOffset
		
		hueImage = generateHUEImage(size)
	}
	
	// MARK: - Drawing
	
	override public func drawRect(rect: CGRect) {
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
		let circleColor = labelBackgroundColor
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
		
		let textParagraphStyle = NSMutableParagraphStyle()
		textParagraphStyle.alignment = .Center
		
		let attributes: NSDictionary = [NSForegroundColorAttributeName: labelFontColor,
										NSParagraphStyleAttributeName: textParagraphStyle,
										NSFontAttributeName: labelFont!]
		
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
		
		let textValue: Int = Int(value * (type == .Color ? HUEMaxValue : PercentMaxValue))
		let text: NSString = "\(textValue)"
		var textRect = circleRect
		textRect.origin.y += (textRect.size.height - (labelFont?.lineHeight)!) * 0.5
		text.drawInRect(textRect, withAttributes: attributes as? [String : AnyObject])
	}
	
	// MARK: - Touch events
	
	override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let touch: AnyObject? = touches.first
		let point = touch!.locationInView(self)
		handleTouch(point)
	}
	
	override public func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let touch: AnyObject? = touches.first
		let point = touch!.locationInView(self)
		handleTouch(point)
	}
	
	override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let touch: AnyObject? = touches.first
		let point = touch!.locationInView(self)
		handleTouch(point)
	}
	
	override public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
		
	}

	// MARK: - Touch handling
	
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
