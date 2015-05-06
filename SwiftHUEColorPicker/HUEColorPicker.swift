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
	private var color: UIColor!
	var currentColor: UIColor {
		get {
			return color
		}
	}
		
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
