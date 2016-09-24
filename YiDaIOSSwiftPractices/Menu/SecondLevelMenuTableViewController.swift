//
//  IOSBasicsMenuTableViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 9/20/16.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

enum YiDaIOSPracticeLevel {
  case Basics, Advanced
}

struct SecondLevelMenuCellInfo {
  var title: String
  var subTitle: String
  var storyboard: String
  var referenceID: String
}

private struct SectionInfo {
  var headerText: String
  var cellInfos: [SecondLevelMenuCellInfo]
}

class SecondLevelMenuTableViewController: UITableViewController {

  var practiceLevel: YiDaIOSPracticeLevel = .Basics

  private let iOSBasicsSections: [SectionInfo] =
    [
    SectionInfo(
      headerText: "视图与控件（VIEW & CONTROLS)",
      cellInfos: [
        SecondLevelMenuCellInfo(
          title: "视图基础",
          subTitle: "UIView & UIView animation basics",
          storyboard: "...",
          referenceID: "..."
        ),
        SecondLevelMenuCellInfo(
          title: "按钮控件（计算器)",
          subTitle: "Use UIButton to build a simple calculator",
          storyboard: "...",
          referenceID: "..."
        ),
      ]
    ),
    SectionInfo(
      headerText: "视图与控件（UIVIEW AND CONTROLS)",
      cellInfos: [
        SecondLevelMenuCellInfo(
          title: "视图基础",
          subTitle: "UIView basics, UIView animation basics",
          storyboard: "...",
          referenceID: "..."
        ),
        SecondLevelMenuCellInfo(
          title: "按钮视图（计算器)",
          subTitle: "UIButton, a simple calculator",
          storyboard: "...",
          referenceID: "..."
        ),
      ]
    ),
  ]

  private let iOSAdvancedSections: [SectionInfo] =
    [
    SectionInfo(
      headerText: "视图与控件（UIVIEW AND CONTROLS)",
      cellInfos: [
        SecondLevelMenuCellInfo(
          title: "视图基础",
          subTitle: "UIView basics, UIView animation basics",
          storyboard: "...",
          referenceID: "..."
        ),
        SecondLevelMenuCellInfo(
          title: "按钮视图（计算器)",
          subTitle: "UIButton, a simple calculator",
          storyboard: "...",
          referenceID: "..."
        ),
      ]
    ),
    SectionInfo(
      headerText: "视图与控件（UIVIEW AND CONTROLS)",
      cellInfos: [
        SecondLevelMenuCellInfo(
          title: "视图基础",
          subTitle: "UIView basics, UIView animation basics",
          storyboard: "...",
          referenceID: "..."
        ),
        SecondLevelMenuCellInfo(
          title: "按钮视图（计算器)",
          subTitle: "UIButton, a simple calculator",
          storyboard: "...",
          referenceID: "..."
        ),
      ]
    ),
  ]

  private var currentMenuSections: [SectionInfo] {
    switch practiceLevel {
    case .Basics:
      return iOSBasicsSections
    case .Advanced:
      return iOSAdvancedSections
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()

    switch practiceLevel {
    case .Basics:
      self.navigationItem.title = "宜达 iOS 基础"
    case .Advanced:
      self.navigationItem.title = "宜达 iOS 进阶"
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return currentMenuSections.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentMenuSections[section].cellInfos.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "2nd Level Menu Cell", for: indexPath) as! SecondLevelMenuTableViewCell

    let cellInfo = currentMenuSections[indexPath.section].cellInfos[indexPath.row]
    cell.set(withInfo: cellInfo)

    return cell
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return currentMenuSections[section].headerText
  }

  // MARK: - Navigation
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

    return true
  }
}
