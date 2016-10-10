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

  let menu = (UIApplication.shared.delegate as! AppDelegate).menuJSON!

  var baseThemeColor: UIColor!

  var level: String!

  // MARK: - Overrides

  override func viewDidLoad() {
    super.viewDidLoad()

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    restoreTheme()

    // hide tool bar
    navigationController?.setToolbarHidden(true, animated: true)
  }

  func restoreTheme() {
    // theme color
    UIApplication.shared.keyWindow!.tintColor = baseThemeColor

    // restore navigation bar theme
    let navBar = navigationController!.navigationBar
    navBar.setBackgroundImage(nil, for: .default)
    navBar.barTintColor = baseThemeColor
    navBar.tintColor = .white
    navBar.titleTextAttributes = [
      NSForegroundColorAttributeName: UIColor.white
    ]

    setNeedsStatusBarAppearanceUpdate()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

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

  // MARK: - Table delegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let item = menuItem(forIndexPath: indexPath)

    guard
      let storyboardName = item["storyboardName"].string,
      storyboardName != "",
      let viewControllerReferenceID = item["viewControllerReferenceID"].string,
      viewControllerReferenceID != ""
      else {
        return
    }

    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerReferenceID)

    navigationController?.pushViewController(viewController, animated: true)
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
