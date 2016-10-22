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
  override var preferredStatusBarStyle: UIStatusBarStyle {
    let bar = navigationBar

    if bar.barTintColor != nil ||
      bar.barStyle != .default ||
      bar.backgroundImage(for: .default) != nil {
      return .lightContent
    } else {
      return .default
    }
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
