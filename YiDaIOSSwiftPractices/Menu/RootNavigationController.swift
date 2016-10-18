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

    // Do any additional setup after loading the view.
//    interactivePopGestureRecognizer!.isEnabled = true
    interactivePopGestureRecognizer!.delegate = self
  }

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

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // hand over interface orirentation decision to top view controller on the stack
  override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
    return topViewController!.preferredInterfaceOrientationForPresentation
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return topViewController!.supportedInterfaceOrientations
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
  */
}

extension RootNavigationController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
