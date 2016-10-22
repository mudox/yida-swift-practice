//
//  IOSBasicsMenuTableViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 9/20/16.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit
import SwiftyJSON

class SecondLevelMenuTableViewController: UITableViewController {

  let menu = theAppDelegate.menuJSON!

  var baseThemeColor: UIColor!

  var level: String!

  // MARK: - as UIViewController
  override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
    return .portrait
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  // MARK: - as UITableViewDataSource
  override func numberOfSections(in tableView: UITableView) -> Int {
    return menu[level].arrayValue.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menu[level, section, "items"].arrayValue.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "2nd Level Menu Cell", for: indexPath) as! SecondLevelMenuTableViewCell

    let item = menuItem(forIndexPath: indexPath)
    cell.set(withJSONItem: item)

    return cell
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return menu[level, section, "headerText"].stringValue
  }

  // MARK: - as UITableViewDelegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let item = menuItem(forIndexPath: indexPath)

    guard
      let storyboardName = item["storyboardName"].string, storyboardName != "",
      let viewControllerReferenceID = item["viewControllerReferenceID"].string, viewControllerReferenceID != ""
      else {
        Jack.error("found invalid menu item: \(item)")
        return
    }

    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerReferenceID)

    if let presenting = item["presenting"].string {
      switch presenting {
      case "Cross Dissolve":
        viewController.modalTransitionStyle = .crossDissolve
      case "Cover Vertical":
        viewController.modalTransitionStyle = .coverVertical
      case "Flip Horizontal":
        viewController.modalTransitionStyle = .flipHorizontal
      default:
        assertionFailure()
      }

      present(viewController, animated: true, completion: nil)
    } else {
      navigationController?.pushViewController(viewController, animated: true)
    }
  }

  // MARK: - Navigation
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

    return true
  }

  // MARK: - Helper methods
  func menuItem(forIndexPath indexPath: IndexPath) -> JSON {
    return menu[level, indexPath.section, "items", indexPath.row]
  }
}
