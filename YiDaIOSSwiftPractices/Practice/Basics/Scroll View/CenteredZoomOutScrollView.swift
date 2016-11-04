//
//  CenteredZoomOutScrollView.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 30/10/2016.
//  Copyright © 2016 Mudox. All rights reserved
//

import UIKit

fileprivate let jack = Jack.with(levelOfThisFile: .verbose)

protocol InternalStateListener {
	func scrollView(_ scrollView: CenteredZoomOutScrollView, internalStateDidChange newState: CenteredZoomOutScrollView.InternalState)
}

/// It is used for showing jiejw=
class CenteredZoomOutScrollView: UIScrollView {

	struct InternalState {
		var contentOffset: CGPoint
		var contentSize: CGSize
		var contentInset: UIEdgeInsets
		var bounds: CGRect

		var contentViewFrame: CGRect?
		var contentViewTransform: CGAffineTransform?

		var isTracking: Bool
		var isDragging: Bool
		var isDecelerating: Bool

		var isZooming: Bool
		var isZoomBouncing: Bool
	}

	var internalStateListener: InternalStateListener?

	var contentView: UIView? {
		didSet {
			oldValue?.removeFromSuperview()
			configureZooming()
		}
	}

	init(frame: CGRect, contentView: UIView) {
		self.contentView = contentView
		super.init(frame: frame)
		configureZooming()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	func configureZooming() {
		maximumZoomScale = 2.0
		minimumZoomScale = 0.5

		delegate = self

		contentView?.frame = bounds
		if contentView != nil {
			addSubview(contentView!)
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		if !(isZooming || isZoomBouncing || isDragging || isDecelerating) {
			jack.debug("normal layout with frame: \(frame.shortDescription)")
		}

		// report states change to listerner if any
		if let listener = internalStateListener {
			let state = InternalState(
				contentOffset: contentOffset,
				contentSize: contentSize,
				contentInset: contentInset,
				bounds: bounds,
				contentViewFrame: contentView?.frame,
				contentViewTransform: contentView?.transform,
				isTracking: isTracking,
				isDragging: isDragging,
				isDecelerating: isDecelerating,
				isZooming: isZooming,
				isZoomBouncing: isZoomBouncing
			)
			listener.scrollView(self, internalStateDidChange: state)
		}
	}
}

extension CenteredZoomOutScrollView: UIScrollViewDelegate {
	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		guard let view = contentView else {
			return
		}

		// jack.debug("x: \((bounds.width * 0.5).shortDescription)(\(bounds.midX.shortDescription)), y: \((bounds.height * 0.5).shortDescription)(\(bounds.midY.shortDescription))")

		let xOffset = (bounds.width > contentSize.width)
			? (bounds.width - contentSize.width) * 0.5: 0.0

		let yOffset = bounds.height > contentSize.height
			? (bounds.height - contentSize.height) * 0.5: 0.0

		view.center = CGPoint(
			x: contentSize.width * 0.5 + xOffset,
			y: contentSize.height * 0.5 + yOffset
		);
	}

	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return contentView
	}
}
