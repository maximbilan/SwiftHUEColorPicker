//
//  ViewController.swift
//  SwiftHUEColorPicker
//
//  Created by Maxim Bilan on 5/6/15.
//  Copyright (c) 2015 Maxim Bilan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HUEColorPickerDelegate {

	@IBOutlet weak var colorPicker: HUEColorPicker!
	@IBOutlet weak var colorView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		colorPicker.delegate = self
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func valuePicked(color: UIColor, type: HUEColorPicker.PickerType) {
		colorView.backgroundColor = color
	}

}

