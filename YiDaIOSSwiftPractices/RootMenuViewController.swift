//
//  RootMenuViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 9/20/16.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class RootMenuViewController: UIViewController {

  @IBOutlet weak var topButton: UIButton!
  @IBOutlet weak var bottomButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let topButton = topButton, let bottomButton = bottomButton else {
      sb.error("top/bottom button is nil")
      return
    }

    topButton.layer.cornerRadius = 4
    bottomButton.layer.cornerRadius = 4
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
    let bar = UINavigationBar.appearance()

    switch segue.identifier! {
    case "Show iOS Basics Second Menu":
      vc.practiceLevel = .Basics

      let baseColor = topButton.backgroundColor

      UIApplication.shared.keyWindow!.tintColor = baseColor
      bar.barTintColor = baseColor
      bar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      bar.titleTextAttributes = [
        NSForegroundColorAttributeName: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
      ]

    case "Show iOS Advanced Second Menu":
      vc.practiceLevel = .Advanced
      let baseColor = bottomButton.backgroundColor

      UIApplication.shared.keyWindow!.tintColor = baseColor
      bar.barTintColor = baseColor
      bar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      bar.titleTextAttributes = [
        NSForegroundColorAttributeName: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
      ]

    default:
      assertionFailure("Invalid segue identifier \(segue.identifier!)")
    }
  }

  func configureAppearence(for level: YiDaIOSPracticeLevel) {
    let bar = UINavigationBar.appearance()

    bar.barTintColor = UIApplication.shared.keyWindow!.tintColor
  }
}
