//
//  ScrollExercisesTableViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 02/11/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class ScrollExercisesTableViewController: UITableViewController {

	@IBOutlet weak var exercise1ScrollView: UIScrollView!
	@IBOutlet weak var exercise1ContentView: UIStackView!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		for x in 0..<5 {
			let image = PlaceholderImageSource.aImage(ofSize: exercise1ScrollView.frame.size, text: "\(x)", maxFontPoint: CGFloat.infinity)
			let imageView = UIImageView(image: image)
			imageView.translatesAutoresizingMaskIntoConstraints = false
			exercise1ContentView.addSubview(imageView)
			exercise1ContentView.addArrangedSubview(imageView)
		}
	}
}
