//
//  BrushSettingsPicker.swift
//  SwiftHUEColorPicker
//
//  Created by Maxim Bilan on 5/6/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit

public extension UIView {
	
	public class func instantiateFromNib<T: UIView>(viewType: T.Type) -> T {
		return NSBundle.mainBundle().loadNibNamed(NSStringFromClass(viewType).pathExtension, owner: nil, options: nil).first as! T
	}
	
	public class func instantiateFromNib() -> Self {
		return instantiateFromNib(self)
	}
	
}

class BrushSettingsPicker: UIView, HUEColorPickerDelegate {

	@IBOutlet weak var colorPicker: HUEColorPicker!
	
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
	
	func valuePicked(color: UIColor, type: HUEColorPicker.PickerType) {
	}
	
}
