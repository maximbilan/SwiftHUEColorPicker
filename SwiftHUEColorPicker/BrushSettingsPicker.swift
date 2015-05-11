//
//  BrushSettingsPicker.swift
//  SwiftHUEColorPicker
//
//  Created by Maxim Bilan on 5/6/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit

class BrushSettingsPicker: UIView, SwiftHUEColorPickerDelegate {

	@IBOutlet weak var colorPicker: SwiftHUEColorPicker!
	
//	required init(coder aDecoder: NSCoder) {
//		super.init(coder: aDecoder)
//		
//		
//	}
//	
//	required override init(frame: CGRect) {
//		super.init(frame: frame)
//		
//		let subviewArray = NSBundle.mainBundle().loadNibNamed("BrushSettingsPicker", owner: self, options: nil)
//	}
	
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

	// HUEColorPickerDelegate
	
	func valuePicked(color: UIColor, type: SwiftHUEColorPicker.PickerType) {
	}
	
}
