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
	
	var delegate: HUEColorPickerDelegate!
	var type: PickerType = PickerType.Color
	var currentColor: UIColor {
		get {
			return color
		}
	}
	
	private var color: UIColor!
	private var currentSelectionY: CGFloat = 0.0
	
	// Initialization
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.backgroundColor = UIColor.clearColor()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.clearColor()
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
		
		let temp = CGRectMake(0, tempYPlace, self.frame.size.width, 1.0)
		UIRectFill(temp)
		
		let cbxBegin = self.frame.size.width * 0.2
		let cbWidth = self.frame.size.width * 0.6
		for var y: Int = 0; y < Int(self.frame.size.height); ++y {
			UIColor(hue: CGFloat(y / Int(self.frame.size.height)), saturation: 1.0, brightness: 1.0, alpha: 1.0).set()
			let temp = CGRectMake(cbxBegin, CGFloat(y), cbWidth, 1)
			UIRectFill(temp)
		}
	}
	
	// Touch events
	
	override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		let point = touch!.locationInView(self)
		currentSelectionY = point.y
		color = UIColor(hue: CGFloat(currentSelectionY / self.frame.size.height), saturation: 1.0, brightness: 1.0, alpha: 1.0)
		
		if delegate != nil {
			delegate.valuePicked(color, type: type)
		}
		setNeedsDisplay()
	}
	
	override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		let point = touch!.locationInView(self)
		currentSelectionY = point.y
		color = UIColor(hue: CGFloat(currentSelectionY / self.frame.size.height), saturation: 1.0, brightness: 1.0, alpha: 1.0)
		
		if delegate != nil {
			delegate.valuePicked(color, type: type)
		}
		setNeedsDisplay()
	}
	
	override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
		let touch: AnyObject? = touches.first
		let point = touch!.locationInView(self)
		currentSelectionY = point.y
		color = UIColor(hue: CGFloat(currentSelectionY / self.frame.size.height), saturation: 1.0, brightness: 1.0, alpha: 1.0)
		
		if delegate != nil {
			delegate.valuePicked(color, type: type)
		}
		setNeedsDisplay()
	}
	
	override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
		
	}

}
