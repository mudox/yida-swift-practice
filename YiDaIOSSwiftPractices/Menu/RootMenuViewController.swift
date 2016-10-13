//
//  RootMenuViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 9/20/16.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

enum YiDaPracticeLevel {
  case basics, advanced
}

class RootMenuViewController: UIViewController {
  @IBOutlet weak var basicButton: UIButton!
  @IBOutlet weak var advancedButton: UIButton!
  @IBOutlet weak var frameworksButton: UIButton!

  var basicTintColor = UIColor.white
  var advancedTintColor = UIColor.white
  var frameworksTintColor = UIColor.white

  // MARK: - Overrides

  override func viewDidLoad() {
    super.viewDidLoad()

    // background setted in storyboard will become the theme color of each part
    basicTintColor = basicButton.backgroundColor!
    advancedTintColor = advancedButton.backgroundColor!
    frameworksTintColor = frameworksButton.backgroundColor!
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: true)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    self.navigationController?.setNavigationBarHidden(false, animated: true)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc = segue.destination as! SecondLevelMenuTableViewController

    var baseColor: UIColor = .black

    switch segue.identifier! {
    case "Show iOS Basic Second Level Menu":
      baseColor = basicTintColor

      vc.navigationItem.title = "iOS 基础"
      vc.level = "basic"

    case "Show iOS Advanced Second Level Menu":
      baseColor = advancedTintColor

      vc.navigationItem.title = "iOS 进阶"
      vc.level = "advanced"

    case "Show iOS 3rd Party Frameworks Second Level Menu":
      baseColor = frameworksTintColor

      vc.navigationItem.title = "开源框架"
      vc.level = "3rd party frameworks"

    default:
      assertionFailure("Invalid segue identifier \(segue.identifier!)")
    }

    vc.baseThemeColor = baseColor
    setAppTheme(withBaseColor: baseColor)
  }

  func setAppTheme(withBaseColor baseColor: UIColor) {
    // navigation bar
    UIApplication.shared.keyWindow!.tintColor = baseColor

    let navBar = UINavigationBar.appearance()
    navBar.barTintColor = baseColor
    navBar.tintColor = .white
    navBar.titleTextAttributes = [
      NSForegroundColorAttributeName: UIColor.white
    ]

    // switch control
    UISwitch.appearance().onTintColor = baseColor
  }
}
