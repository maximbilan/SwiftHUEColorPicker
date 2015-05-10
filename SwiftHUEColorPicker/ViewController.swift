//
//  ViewController.swift
//  SwiftHUEColorPicker
//
//  Created by Maxim Bilan on 5/6/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HUEColorPickerDelegate {

	@IBOutlet weak var colorView: UIView!
	
	@IBOutlet weak var horizontalHUEColorPicker: HUEColorPicker!
	@IBOutlet weak var verticalHUEColorPicker: HUEColorPicker!
	@IBOutlet weak var horizontalSaturationPicker: HUEColorPicker!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
//		let brushSettings = BrushSettingsPicker.instantiateFromNib()
//		brushSettings.center = self.view.center
//		self.view.addSubview(brushSettings)
		
		horizontalHUEColorPicker.delegate = self
		horizontalHUEColorPicker.direction = HUEColorPicker.PickerDirection.Horizontal
		
		verticalHUEColorPicker.delegate = self
		verticalHUEColorPicker.direction = HUEColorPicker.PickerDirection.Vertical
		
		horizontalSaturationPicker.delegate = self
		horizontalSaturationPicker.direction = HUEColorPicker.PickerDirection.Horizontal
		horizontalSaturationPicker.type = HUEColorPicker.PickerType.Saturation
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func valuePicked(color: UIColor, type: HUEColorPicker.PickerType) {
		colorView.backgroundColor = color
		
		if type == HUEColorPicker.PickerType.Color {
			horizontalSaturationPicker.currentColor = color
		}
		else if type == HUEColorPicker.PickerType.Saturation {
			horizontalHUEColorPicker.currentColor = color
		}
	}
	
}

