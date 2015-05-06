//
//  UIView+Extension.swift
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