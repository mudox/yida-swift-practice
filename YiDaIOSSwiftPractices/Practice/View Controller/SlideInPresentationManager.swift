//
//  SlideInPresentationManager.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 11/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

enum PresentationDirection {
  case top, bottom, left, right, center
}

class SlideInPresentationManager: NSObject {

  var direction = PresentationDirection.left

}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    let controller = SlideInPresentationController(presentedViewController: presented, presenting: presenting, direction: direction)
    return controller
  }

  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return SlideInAnimator(direction: direction, isPresentation: true)
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return SlideInAnimator(direction: direction, isPresentation: false)
  }
}
