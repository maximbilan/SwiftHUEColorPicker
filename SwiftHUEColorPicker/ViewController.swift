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
	
	// MARK: - Horizontal pickers
	
	@IBOutlet weak var horizontalColorPicker: SwiftHUEColorPicker!
	@IBOutlet weak var horizontalSaturationPicker: SwiftHUEColorPicker!
	@IBOutlet weak var horizontalBrightnessPicker: SwiftHUEColorPicker!
	@IBOutlet weak var horizontalAlphaPicker: SwiftHUEColorPicker!
	
	// MARK: - Vertical pickers
	
	@IBOutlet weak var verticalColorPicker: SwiftHUEColorPicker!
	@IBOutlet weak var verticalSaturationPicker: SwiftHUEColorPicker!
	@IBOutlet weak var verticalBrightnessPicker: SwiftHUEColorPicker!
	@IBOutlet weak var verticalAlphaPicker: SwiftHUEColorPicker!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		horizontalColorPicker.delegate = self
		horizontalColorPicker.direction = SwiftHUEColorPicker.PickerDirection.horizontal
		horizontalSaturationPicker.type = SwiftHUEColorPicker.PickerType.color
		
		horizontalSaturationPicker.delegate = self
		horizontalSaturationPicker.direction = SwiftHUEColorPicker.PickerDirection.horizontal
		horizontalSaturationPicker.type = SwiftHUEColorPicker.PickerType.saturation
		
		horizontalBrightnessPicker.delegate = self
		horizontalBrightnessPicker.direction = SwiftHUEColorPicker.PickerDirection.horizontal
		horizontalBrightnessPicker.type = SwiftHUEColorPicker.PickerType.brightness
		
		horizontalAlphaPicker.delegate = self
		horizontalAlphaPicker.direction = SwiftHUEColorPicker.PickerDirection.horizontal
		horizontalAlphaPicker.type = SwiftHUEColorPicker.PickerType.alpha
		
		verticalColorPicker.delegate = self
		verticalColorPicker.direction = SwiftHUEColorPicker.PickerDirection.vertical
		verticalColorPicker.type = SwiftHUEColorPicker.PickerType.color
		
		verticalSaturationPicker.delegate = self
		verticalSaturationPicker.direction = SwiftHUEColorPicker.PickerDirection.vertical
		verticalSaturationPicker.type = SwiftHUEColorPicker.PickerType.saturation
		
		verticalBrightnessPicker.delegate = self
		verticalBrightnessPicker.direction = SwiftHUEColorPicker.PickerDirection.vertical
		verticalBrightnessPicker.type = SwiftHUEColorPicker.PickerType.brightness
		
		verticalAlphaPicker.delegate = self
		verticalAlphaPicker.direction = SwiftHUEColorPicker.PickerDirection.vertical
		verticalAlphaPicker.type = SwiftHUEColorPicker.PickerType.alpha
	}

	// MARK: - SwiftHUEColorPickerDelegate
	
	func valuePicked(_ color: UIColor, type: SwiftHUEColorPicker.PickerType) {
		colorView.backgroundColor = color
		
		switch type {
		case SwiftHUEColorPicker.PickerType.color:
			horizontalSaturationPicker.currentColor = color
			horizontalBrightnessPicker.currentColor = color
			horizontalAlphaPicker.currentColor = color
			verticalSaturationPicker.currentColor = color
			verticalBrightnessPicker.currentColor = color
			verticalAlphaPicker.currentColor = color
			break
		case SwiftHUEColorPicker.PickerType.saturation:
			horizontalColorPicker.currentColor = color
			horizontalBrightnessPicker.currentColor = color
			horizontalAlphaPicker.currentColor = color
			verticalColorPicker.currentColor = color
			verticalBrightnessPicker.currentColor = color
			verticalAlphaPicker.currentColor = color
			break
		case SwiftHUEColorPicker.PickerType.brightness:
			horizontalColorPicker.currentColor = color
			horizontalSaturationPicker.currentColor = color
			horizontalAlphaPicker.currentColor = color
			verticalColorPicker.currentColor = color
			verticalSaturationPicker.currentColor = color
			verticalAlphaPicker.currentColor = color
			break
		case SwiftHUEColorPicker.PickerType.alpha:
			horizontalColorPicker.currentColor = color
			horizontalSaturationPicker.currentColor = color
			horizontalBrightnessPicker.currentColor = color
			verticalColorPicker.currentColor = color
			verticalSaturationPicker.currentColor = color
			verticalBrightnessPicker.currentColor = color
			break
		}
	}
	
	// MARK: - Actions
	
	@IBAction func testButtonAction(_ sender: UIButton) {
		horizontalColorPicker.currentColor = UIColor.green
	}
	
}

