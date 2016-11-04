//
//  RootNavigationController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 23/09/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {

	override func viewDidLoad() {
		super.viewDidLoad()
		enablePanInAnywhereToPop()
	}

	// MARK: Manage status bar
	var statusBarStyle: UIStatusBarStyle = .lightContent {
		didSet {
			setNeedsStatusBarAppearanceUpdate()
		}
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return statusBarStyle
	}

	// MARK: Manage interface orirentation

	// hand over interface orirentation decision to top view controller on the stack
	override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
		return topViewController!.preferredInterfaceOrientationForPresentation
	}

	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return topViewController!.supportedInterfaceOrientations
	}

}
