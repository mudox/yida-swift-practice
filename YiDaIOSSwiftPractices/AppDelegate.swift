//
//  AppDelegate.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 9/8/16.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var menuJSON: JSON!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    Jack.wakeUp()
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) { Jack.debug("▣")
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) { Jack.debug("▣")
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) { Jack.debug("▣")
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) { Jack.debug("▣")
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) { Jack.debug("▣")
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
}

// MARK: - App color scheme changeable
extension AppDelegate {
  /// Setting this property will change the whole app's color scheme automatically
  var themeColor: UIColor? {
    get {
      return window?.tintColor
    }

    set {
      guard let win = window else {
        Jack.warn("window is nil")
        return
      }

      let color = newValue

      // theme color
      win.tintColor = color

      // navigation bar
      let navBar = UINavigationBar.appearance()
      navBar.setBackgroundImage(nil, for: .default)

      navBar.barTintColor = color
      navBar.tintColor = .white
      navBar.titleTextAttributes = [
        NSForegroundColorAttributeName: UIColor.white,
      ]

      // tool bar
      let toolBar = UIToolbar.appearance()
      toolBar.barTintColor = color
      toolBar.tintColor = .white

      // tab bar
      let tabBar = UITabBar.appearance()
      tabBar.barTintColor = color
      tabBar.tintColor = .white

      // switch control
      UISwitch.appearance().onTintColor = color

      // refresh
      win.rootViewController?.setNeedsStatusBarAppearanceUpdate()
      for view in win.subviews {
        view.removeFromSuperview()
        win.addSubview(view)
      }
    }
  }
}
