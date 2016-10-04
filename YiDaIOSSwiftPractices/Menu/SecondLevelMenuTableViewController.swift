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

  var level: String!
  let menu = (UIApplication.shared.delegate as! AppDelegate).menuJSON!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    let storyboardName = item["storyboardName"].stringValue
    let viewControllerReferenceID = item["viewControllerReferenceID"].stringValue

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
