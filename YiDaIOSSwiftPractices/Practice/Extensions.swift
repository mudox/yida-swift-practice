//
//  Extensions.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 22/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

// MARK: - UIViewController Dismissable

// if view controller is in a modally presented view controller hierarchy,
// add a bar button item to the left of the navigation bar to dismiss the presentation.
extension UIViewController {
  func installDismissButtonOnNavigationBar() {
    guard presentingViewController != nil &&
      navigationController != nil else {
        Jack.warn("invoked on wrong context")
        return
    }

    let buttonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "NavIcon-Dismiss"), style: .done, target: self, action: #selector(dismiss(sender:)))
    navigationItem.leftBarButtonItem = buttonItem
  }

  func dismiss(sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - Pan In AnyWhere To Pop Feature
extension UINavigationController: UIGestureRecognizerDelegate {

  func enablePanInAnywhereToPop() {
    interactivePopGestureRecognizer!.isEnabled = false
    let target = interactivePopGestureRecognizer!.delegate!
    let panGesture = UIPanGestureRecognizer(target: target, action: Selector("handleNavigationTransition:"))
    panGesture.delegate = self
    view.addGestureRecognizer(panGesture)
  }

  func enableEdgePanToPopAlways() {
    interactivePopGestureRecognizer!.delegate = self
  }

  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
