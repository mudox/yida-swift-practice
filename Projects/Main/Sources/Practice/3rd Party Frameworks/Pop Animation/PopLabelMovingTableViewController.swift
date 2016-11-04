//
//  PopLabelMovingTableViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 01/11/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit
import pop
import SwiftMessages
import RxSwift
import RxCocoa

class PopLabelMovingTableViewController: UITableViewController {
	@IBOutlet weak var movingLabelView: UILabel!
	@IBOutlet var tapGesture: UITapGestureRecognizer!

	@IBOutlet weak var springBouncinessLabel: UILabel!
	@IBOutlet weak var springBouncinessSlider: UISlider!

	@IBOutlet weak var springSpeedSlider: UISlider!
	@IBOutlet weak var springSpeedLabel: UILabel!

	private var disposeBag: DisposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()

		movingLabelView.layer.cornerRadius = 3
		movingLabelView.layer.backgroundColor = theWindow.tintColor.cgColor
		movingLabelView.textColor = .white

		springBouncinessSlider.rx.value
			.map { $0.shortDescription }
			.bindTo(springBouncinessLabel.rx.text)
			.addDisposableTo(disposeBag)

		springSpeedSlider.rx.value
			.map { $0.shortDescription }
			.bindTo(springSpeedLabel.rx.text)
			.addDisposableTo(disposeBag)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		navigationController?.disablePanInAnyWhereToPop()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.enablePanInAnywhereToPop()
	}

	@IBAction func tapGesturedStateUpdated(_ sender: UITapGestureRecognizer) {
		if sender.state == .recognized {
			performAnimation()
		}
	}

	func performAnimation() {
		tapGesture.isEnabled = false

		movingLabelView.layer.pop_removeAllAnimations()

		let anim = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)!

		anim.springBounciness = CGFloat(springBouncinessSlider.value)
		anim.springSpeed = CGFloat(springSpeedSlider.value)

		anim.fromValue = 30
		anim.toValue = 120

		let view = MessageView.viewFromNib(layout: .CardView)
		var config = SwiftMessages.Config()
		config.presentationStyle = .bottom
		view.configureTheme(.success)
		view.configureDropShadow()

		anim.completionBlock = { anim, finished in
			if finished {
				view.configureContent(body: "动画成功")
			} else {
				view.configureContent(body: "动画失败")
			}
			SwiftMessages.show(config: config, view: view)
			self.tapGesture.isEnabled = true
		}

		movingLabelView.layer.pop_add(anim, forKey: "Moving Label")
	}
}
