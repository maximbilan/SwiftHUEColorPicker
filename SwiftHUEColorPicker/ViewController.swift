//
//  ViewController.swift
//  SwiftHUEColorPicker
//
//  Created by Maxim Bilan on 5/6/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SwiftHUEColorPickerDelegate {

	@IBOutlet weak var colorView: UIView!
	
	// Horizontal pickers
	@IBOutlet weak var horizontalColorPicker: SwiftHUEColorPicker!
	@IBOutlet weak var horizontalSaturationPicker: SwiftHUEColorPicker!
	@IBOutlet weak var horizontalBrightnessPicker: SwiftHUEColorPicker!
	@IBOutlet weak var horizontalAlphaPicker: SwiftHUEColorPicker!
	
	// Vertical pickers
	@IBOutlet weak var verticalColorPicker: SwiftHUEColorPicker!
	@IBOutlet weak var verticalSaturationPicker: SwiftHUEColorPicker!
	@IBOutlet weak var verticalBrightnessPicker: SwiftHUEColorPicker!
	@IBOutlet weak var verticalAlphaPicker: SwiftHUEColorPicker!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		horizontalColorPicker.delegate = self
		horizontalColorPicker.direction = SwiftHUEColorPicker.PickerDirection.Horizontal
		horizontalSaturationPicker.type = SwiftHUEColorPicker.PickerType.Color
		
		horizontalSaturationPicker.delegate = self
		horizontalSaturationPicker.direction = SwiftHUEColorPicker.PickerDirection.Horizontal
		horizontalSaturationPicker.type = SwiftHUEColorPicker.PickerType.Saturation
		
		horizontalBrightnessPicker.delegate = self
		horizontalBrightnessPicker.direction = SwiftHUEColorPicker.PickerDirection.Horizontal
		horizontalBrightnessPicker.type = SwiftHUEColorPicker.PickerType.Brightness
		
		horizontalAlphaPicker.delegate = self
		horizontalAlphaPicker.direction = SwiftHUEColorPicker.PickerDirection.Horizontal
		horizontalAlphaPicker.type = SwiftHUEColorPicker.PickerType.Alpha
		
		verticalColorPicker.delegate = self
		verticalColorPicker.direction = SwiftHUEColorPicker.PickerDirection.Vertical
		verticalColorPicker.type = SwiftHUEColorPicker.PickerType.Color
		
		verticalSaturationPicker.delegate = self
		verticalSaturationPicker.direction = SwiftHUEColorPicker.PickerDirection.Vertical
		verticalSaturationPicker.type = SwiftHUEColorPicker.PickerType.Saturation
		
		verticalBrightnessPicker.delegate = self
		verticalBrightnessPicker.direction = SwiftHUEColorPicker.PickerDirection.Vertical
		verticalBrightnessPicker.type = SwiftHUEColorPicker.PickerType.Brightness
		
		verticalAlphaPicker.delegate = self
		verticalAlphaPicker.direction = SwiftHUEColorPicker.PickerDirection.Vertical
		verticalAlphaPicker.type = SwiftHUEColorPicker.PickerType.Alpha
	}

	// SwiftHUEColorPickerDelegate
	
	func valuePicked(color: UIColor, type: SwiftHUEColorPicker.PickerType) {
		colorView.backgroundColor = color
		
		switch type {
		case SwiftHUEColorPicker.PickerType.Color:
			horizontalSaturationPicker.currentColor = color
			horizontalBrightnessPicker.currentColor = color
			horizontalAlphaPicker.currentColor = color
			verticalSaturationPicker.currentColor = color
			verticalBrightnessPicker.currentColor = color
			verticalAlphaPicker.currentColor = color
			break
		case SwiftHUEColorPicker.PickerType.Saturation:
			horizontalColorPicker.currentColor = color
			horizontalBrightnessPicker.currentColor = color
			horizontalAlphaPicker.currentColor = color
			verticalColorPicker.currentColor = color
			verticalBrightnessPicker.currentColor = color
			verticalAlphaPicker.currentColor = color
			break
		case SwiftHUEColorPicker.PickerType.Brightness:
			horizontalColorPicker.currentColor = color
			horizontalSaturationPicker.currentColor = color
			horizontalAlphaPicker.currentColor = color
			verticalColorPicker.currentColor = color
			verticalSaturationPicker.currentColor = color
			verticalAlphaPicker.currentColor = color
			break
		case SwiftHUEColorPicker.PickerType.Alpha:
			horizontalColorPicker.currentColor = color
			horizontalSaturationPicker.currentColor = color
			horizontalBrightnessPicker.currentColor = color
			verticalColorPicker.currentColor = color
			verticalSaturationPicker.currentColor = color
			verticalBrightnessPicker.currentColor = color
			break
		}
	}
	
	// Actions
	
	@IBAction func testButtonAction(sender: UIButton) {
		horizontalColorPicker.currentColor = UIColor.greenColor()
	}
	
}

