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
	
	// Horizontal pickers
	@IBOutlet weak var horizontalColorPicker: HUEColorPicker!
	@IBOutlet weak var horizontalSaturationPicker: HUEColorPicker!
	@IBOutlet weak var horizontalBrightnessPicker: HUEColorPicker!
	@IBOutlet weak var horizontalAlphaPicker: HUEColorPicker!
	
	// Vertical pickers
	@IBOutlet weak var verticalColorPicker: HUEColorPicker!
	@IBOutlet weak var verticalSaturationPicker: HUEColorPicker!
	@IBOutlet weak var verticalBrightnessPicker: HUEColorPicker!
	@IBOutlet weak var verticalAlphaPicker: HUEColorPicker!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		horizontalColorPicker.delegate = self
		horizontalColorPicker.direction = HUEColorPicker.PickerDirection.Horizontal
		horizontalSaturationPicker.type = HUEColorPicker.PickerType.Color
		
		horizontalSaturationPicker.delegate = self
		horizontalSaturationPicker.direction = HUEColorPicker.PickerDirection.Horizontal
		horizontalSaturationPicker.type = HUEColorPicker.PickerType.Saturation
		
		horizontalBrightnessPicker.delegate = self
		horizontalBrightnessPicker.direction = HUEColorPicker.PickerDirection.Horizontal
		horizontalBrightnessPicker.type = HUEColorPicker.PickerType.Brightness
		
		horizontalAlphaPicker.delegate = self
		horizontalAlphaPicker.direction = HUEColorPicker.PickerDirection.Horizontal
		horizontalAlphaPicker.type = HUEColorPicker.PickerType.Alpha
		
		verticalColorPicker.delegate = self
		verticalColorPicker.direction = HUEColorPicker.PickerDirection.Vertical
		verticalColorPicker.type = HUEColorPicker.PickerType.Color
		
		verticalSaturationPicker.delegate = self
		verticalSaturationPicker.direction = HUEColorPicker.PickerDirection.Vertical
		verticalSaturationPicker.type = HUEColorPicker.PickerType.Saturation
		
		verticalBrightnessPicker.delegate = self
		verticalBrightnessPicker.direction = HUEColorPicker.PickerDirection.Vertical
		verticalBrightnessPicker.type = HUEColorPicker.PickerType.Brightness
		
		verticalAlphaPicker.delegate = self
		verticalAlphaPicker.direction = HUEColorPicker.PickerDirection.Vertical
		verticalAlphaPicker.type = HUEColorPicker.PickerType.Alpha
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func valuePicked(color: UIColor, type: HUEColorPicker.PickerType) {
		colorView.backgroundColor = color
		
		switch type {
		case HUEColorPicker.PickerType.Color:
			horizontalSaturationPicker.currentColor = color
			horizontalBrightnessPicker.currentColor = color
			horizontalAlphaPicker.currentColor = color
			verticalSaturationPicker.currentColor = color
			verticalBrightnessPicker.currentColor = color
			verticalAlphaPicker.currentColor = color
			break
		case HUEColorPicker.PickerType.Saturation:
			horizontalColorPicker.currentColor = color
			horizontalBrightnessPicker.currentColor = color
			horizontalAlphaPicker.currentColor = color
			verticalColorPicker.currentColor = color
			verticalBrightnessPicker.currentColor = color
			verticalAlphaPicker.currentColor = color
			break
		case HUEColorPicker.PickerType.Brightness:
			horizontalColorPicker.currentColor = color
			horizontalSaturationPicker.currentColor = color
			horizontalAlphaPicker.currentColor = color
			verticalColorPicker.currentColor = color
			verticalSaturationPicker.currentColor = color
			verticalAlphaPicker.currentColor = color
			break
		case HUEColorPicker.PickerType.Alpha:
			horizontalColorPicker.currentColor = color
			horizontalSaturationPicker.currentColor = color
			horizontalBrightnessPicker.currentColor = color
			verticalColorPicker.currentColor = color
			verticalSaturationPicker.currentColor = color
			verticalBrightnessPicker.currentColor = color
			break
		}
	}
	
}

