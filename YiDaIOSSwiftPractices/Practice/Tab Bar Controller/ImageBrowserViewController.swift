//
//  ImageBrowserViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 30/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class ImageBrowserViewController: UIViewController {
	static let identifier = "Image Browser View Controller"

	@IBOutlet var scrollView: CenteredZoomOutScrollView!
	@IBOutlet weak var dismissButton: UIButton!

	var image: UIImage?

	override var prefersStatusBarHidden: Bool {
		return true
	}

	@IBAction func dismiss(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

	override func viewDidLoad() {
		scrollView.backgroundColor = .black

		let imageView = UIImageView(image: image)
		imageView.contentMode = .scaleAspectFit
		scrollView.contentView = imageView
	}

	override func viewWillAppear(_ animated: Bool) {
		dismissButton.alpha = 0
	}

	override func viewDidAppear(_ animated: Bool) {
		UIView.animate(withDuration: 0.4) {
			self.dismissButton.alpha = 1
		}
	}
}
