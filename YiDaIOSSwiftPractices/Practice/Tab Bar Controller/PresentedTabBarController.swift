//
//  PresentedTabBarController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 19/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class PresentedTabBarController: UITabBarController {

  override func awakeFromNib() {
    super.awakeFromNib()

    delegate = self
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    initContentViewControllers()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func initContentViewControllers() {

    for (index, viewController): (Int, UIViewController) in viewControllers!.enumerated() {
      let vc = (viewController as! UINavigationController).topViewController as! TabBarContentViewController
      vc.title = "Tab Bar Content View Controller #\(index + 1)"
      vc.index = index

//      let tabItem = tabBarController!.tabBar.items![index]
//      tabItem.image = UIImage(named: "TabIcon-\(index + 1)")
//      tabItem.selectedImage = UIImage(named: "TabIcon-\(index + 1)-Selected")
//      tabItem.title = ""
    }
  }
}

extension PresentedTabBarController : UITabBarControllerDelegate {

  func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return TabBarControllerAnimator()
  }

}
