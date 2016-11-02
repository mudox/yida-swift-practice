//
//  ScrollViewInspectorTableViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 30/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import pop

fileprivate let jack: Jack.Type = {
	Jack.setLevelOfThisFile(.verbose)
	return Jack.self
}()

class ScrollViewInspectorTableViewController: UITableViewController {

	var imageView: UIImageView!
	@IBOutlet weak var scrollView: CenteredZoomOutScrollView!

	// contentOffset labels
	@IBOutlet weak var contentOffsetXlabel: UILabel!
	@IBOutlet weak var contentOffsetYLabel: UILabel!

	// contentSize labels
	@IBOutlet weak var contentSizeWidthLabel: UILabel!
	@IBOutlet weak var contentSizeHeightLabel: UILabel!

	// bounds labels
	@IBOutlet weak var boundsXLabel: UILabel!
	@IBOutlet weak var boundsYLabel: UILabel!
	@IBOutlet weak var boundsWidthLabel: UILabel!
	@IBOutlet weak var boundsHeightLabel: UILabel!

	// content view frame lables
	@IBOutlet weak var frameXLabel: UILabel!
	@IBOutlet weak var frameYLabel: UILabel!
	@IBOutlet weak var frameWidthLabel: UILabel!
	@IBOutlet weak var frameHeightLabel: UILabel!

	// content view transform
	@IBOutlet weak var transformALabel: UILabel!
	@IBOutlet weak var transformBLabel: UILabel!
	@IBOutlet weak var transformCLabel: UILabel!
	@IBOutlet weak var transformDLabel: UILabel!
	@IBOutlet weak var transformTXLabel: UILabel!
	@IBOutlet weak var transformTYLabel: UILabel!

	// simulator area
	@IBOutlet weak var fakeScrollView: UIView!
	@IBOutlet weak var fakeScrollViewBounds: UIView!
	@IBOutlet weak var fakeContentView: UIImageView!

	override func viewDidLoad() {
		super.viewDidLoad()

		let image = PlaceholderImageSource.aImage(imageSize: CGSize(width: 414, height: 736 / 3))
		imageView = UIImageView(image: image)
		scrollView.internalStateListener = self

		fakeScrollView.backgroundColor = .clear
		fakeScrollView.layer.borderColor = UIColor.lightGray.cgColor
		fakeScrollView.layer.borderWidth = 1

		fakeScrollViewBounds.backgroundColor = .clear
		fakeScrollViewBounds.layer.borderColor = UIColor.orange.cgColor
		fakeScrollViewBounds.layer.borderWidth = 1

		fakeContentView.image = image

	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		navigationController?.disablePanInAnyWhereToPop()

		scrollView.contentView = imageView
		imageView.alpha = 0
		UIView.animate(withDuration: 0.5) {
			self.imageView.alpha = 1
		}
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.enablePanInAnywhereToPop()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		glowBoxes.removeAll()
	}
}

extension ScrollViewInspectorTableViewController: InternalStateListener {

	func scrollView(_ scrollView: CenteredZoomOutScrollView,
		internalStateDidChange newState: CenteredZoomOutScrollView.InternalState)
	{
		// contentOffset
		contentOffsetXlabel.pulseTextUpdate(withNewText: newState.contentOffset.x.shortDescription)
		contentOffsetYLabel.pulseTextUpdate(withNewText: newState.contentOffset.y.shortDescription)

		// contentSize
		contentSizeWidthLabel.pulseTextUpdate(withNewText: newState.contentSize.width.shortDescription)
		contentSizeHeightLabel.pulseTextUpdate(withNewText: newState.contentSize.height.shortDescription)

		// bounds
		boundsXLabel.pulseTextUpdate(withNewText: newState.bounds.origin.x.shortDescription)
		boundsYLabel.pulseTextUpdate(withNewText: newState.bounds.origin.y.shortDescription)
		boundsWidthLabel.pulseTextUpdate(withNewText: newState.bounds.width.shortDescription)
		boundsHeightLabel.pulseTextUpdate(withNewText: newState.bounds.height.shortDescription)

		// frame
		frameXLabel.pulseTextUpdate(withNewText: newState.frame?.origin.x.shortDescription)
		frameYLabel.pulseTextUpdate(withNewText: newState.frame?.origin.y.shortDescription)
		frameWidthLabel.pulseTextUpdate(withNewText: newState.frame?.size.width.shortDescription)
		frameHeightLabel.pulseTextUpdate(withNewText: newState.frame?.size.height.shortDescription)

		// transform
		transformALabel.pulseTextUpdate(withNewText: newState.transform?.a.shortDescription)
		transformBLabel.pulseTextUpdate(withNewText: newState.transform?.b.shortDescription)
		transformCLabel.pulseTextUpdate(withNewText: newState.transform?.c.shortDescription)
		transformDLabel.pulseTextUpdate(withNewText: newState.transform?.d.shortDescription)
		transformTXLabel.pulseTextUpdate(withNewText: newState.transform?.tx.shortDescription)
		transformTYLabel.pulseTextUpdate(withNewText: newState.transform?.ty.shortDescription)

		syncSimulatorCell(newState: newState)
	}

	func syncSimulatorCell(newState: CenteredZoomOutScrollView.InternalState) {
		let newOrigin = CGPoint(x: newState.bounds.origin.x / 2.4, y: newState.bounds.origin.y / 2.4)
		fakeScrollViewBounds.frame.origin = newOrigin

		let newContentSize = CGSize(
			width: newState.contentSize.width / 2.4,
			height: newState.contentSize.height / 2.4
		)

		if newContentSize.width < fakeScrollView.bounds.width {
			let xOffset = (fakeScrollView.bounds.width - newContentSize.width) * 0.5
			let yOffset = (fakeScrollView.bounds.height - newContentSize.height) * 0.5
			fakeContentView.center.x = newContentSize.width * 0.5 + xOffset
			fakeContentView.center.y = newContentSize.height * 0.5 + yOffset
		} else {
			fakeContentView.frame.origin = .zero
		}

		fakeContentView.frame.size = newContentSize
	}
}

fileprivate var glowBoxes = [UILabel: UIView](minimumCapacity: 20)

extension UILabel {
	func pulseTextUpdate(withNewText newText: String?) {
		guard text != newText else {
			return
		}

		let box: UIView
		if let view = glowBoxes[self] {
			box = view
		} else {
			box = UIView(frame: frame)
			box.layer.cornerRadius = 2

			glowBoxes[self] = box
			superview?.insertSubview(box, belowSubview: self)
		}

		box.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
		if newText != nil && text != nil &&
		(newText! as NSString).floatValue < (text! as NSString).floatValue {
			box.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
		}

		text = (newText != nil) ? newText : "n/a"

		sizeToFit()
		box.frame = frame.insetBy(dx: -3, dy: -1)

		UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseIn], animations: {
			box.backgroundColor = .clear
			}, completion: nil)
	}
}
