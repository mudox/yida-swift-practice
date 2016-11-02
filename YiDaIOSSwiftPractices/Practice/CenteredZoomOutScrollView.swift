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
		var frame: CGRect?
		var transform: CGAffineTransform?
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

		// report states change to listerner if any
		if let listener = internalStateListener {
			let state = InternalState(
				contentOffset: contentOffset,
				contentSize: contentSize,
				contentInset: contentInset,
				bounds: bounds,
				frame: contentView?.frame,
				transform: contentView?.transform
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

		jack.debug("x: \((bounds.width * 0.5).shortDescription)(\(bounds.midX.shortDescription)), y: \((bounds.height * 0.5).shortDescription)(\(bounds.midY.shortDescription))")

		let xOffset = (bounds.width > contentSize.width)
			? (bounds.width - contentSize.width) * 0.5: 0.0;
		let yOffset = bounds.height > contentSize.height
			? (bounds.height - contentSize.height) * 0.5: 0.0;
		view.center = CGPoint(
			x: contentSize.width * 0.5 + xOffset,
			y: contentSize.height * 0.5 + yOffset
		);

		/*
		 if zoomScale < 1 {
		 view.center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
		 } else {
		 view.frame.origin = .zero
		 }
		 */
	}

	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return contentView
	}
}
