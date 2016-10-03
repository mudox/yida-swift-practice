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

  let basicTintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
  let advancedTintColor = #colorLiteral(red: 0.745098114, green: 0.258823514, blue: 0.2392157018, alpha: 1)

  // MARK: - Overrides

  override func viewDidLoad() {
    super.viewDidLoad()

    basicButton.backgroundColor = basicTintColor
    advancedButton.backgroundColor = advancedTintColor
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
    case "Show iOS Basic Second Menu":
      vc.navigationItem.title = "iOS 基础"
      vc.level = "basic"

      let baseColor = basicTintColor
      UIApplication.shared.keyWindow!.tintColor = baseColor
      bar.barTintColor = baseColor
      bar.tintColor = .white
      bar.titleTextAttributes = [
        NSForegroundColorAttributeName: UIColor.white
      ]

    case "Show iOS Advanced Second Menu":
      vc.navigationItem.title = "iOS 进阶"
      vc.level = "advanced"

      let baseColor = advancedTintColor
      UIApplication.shared.keyWindow!.tintColor = baseColor
      bar.barTintColor = baseColor
      bar.tintColor = .white
      bar.titleTextAttributes = [
        NSForegroundColorAttributeName: UIColor.white
      ]

    default:
      assertionFailure("Invalid segue identifier \(segue.identifier!)")
    }
  }

  // MARK: - Actions
}
