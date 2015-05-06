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
		
	}
	
	// Touch events
	
	override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
		
	}
	
	override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
		
	}
	
	override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
		
	}
	
	override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
		
	}

}
