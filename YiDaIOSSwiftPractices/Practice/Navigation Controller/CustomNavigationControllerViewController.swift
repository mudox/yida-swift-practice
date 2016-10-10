/// /  CustomNavigationControllerViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 05/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class CustomNavigationControllerTableViewController: UITableViewController {

  var navigationBar: UINavigationBar {
    return navigationController!.navigationBar
  }

  var toolbar: UIToolbar {
    return navigationController!.toolbar
  }

  // MARK: - Outlets

  @IBOutlet weak var promptSwitch: UISwitch!
  @IBOutlet weak var promptDetailLabel: UILabel!

  @IBOutlet weak var navbarStyleSegmentedControl: UISegmentedControl!
  @IBOutlet weak var navbarStyleDetailLabel: UILabel!

  @IBOutlet weak var navbarBackgroundSegmentedControl: UISegmentedControl!
  @IBOutlet weak var navbarBackgroundDetailLabel: UILabel!

  @IBOutlet weak var navbarTitleSegmentedControl: UISegmentedControl!
  @IBOutlet weak var navbarTitleDetailLabel: UILabel!

  @IBOutlet weak var navbarButtonItemDetailLabel: UILabel!

  // left bar button item
  @IBOutlet weak var navbarLeftButtonItemStyleSegmentedControl: UISegmentedControl!
  @IBOutlet weak var navbarLeftButtonItemCountSegmentedControl: UISegmentedControl!

  @IBOutlet weak var navbarHideBackButtonSwitch: UISwitch!
  @IBOutlet weak var navbarCoexistsWithBackButtonSwitch: UISwitch!

  // right bar button item
  @IBOutlet weak var navbarRightButtonItemStyleSegmentedControl: UISegmentedControl!
  @IBOutlet weak var navbarRightButtonItemCountSegmentedControl: UISegmentedControl!

  // tool bar
  @IBOutlet weak var toolbarStyleSegmentedControl: UISegmentedControl!
  @IBOutlet weak var toolbarStyleDetailLabel: UILabel!
  @IBOutlet weak var toolbarBackgroundSegmentedControl: UISegmentedControl!
  @IBOutlet weak var toolbarBackgroundDetailLabel: UILabel!
  @IBOutlet weak var toolbarItemStyleSegmentedControl: UISegmentedControl!
  @IBOutlet weak var toolbarItemLayoutSegmentedControl: UISegmentedControl!
  @IBOutlet weak var toolbarItemsDetailLabel: UILabel!
  // MARK: - Actions
  enum navbarItemSide {
    case leftSide, rightSide
  }

  lazy var barButtonItems = initBarButtonItems()

  func updatenavbarIems(of side: navbarItemSide) {
    let itemCount = (side == .leftSide)
      ? navbarLeftButtonItemCountSegmentedControl.selectedSegmentIndex
      : navbarRightButtonItemCountSegmentedControl.selectedSegmentIndex

    let index = (side == .leftSide)
      ? navbarLeftButtonItemStyleSegmentedControl.selectedSegmentIndex
      : navbarRightButtonItemStyleSegmentedControl.selectedSegmentIndex

    if itemCount == 0 {
      if side == .leftSide {
        navigationItem.setLeftBarButtonItems(nil, animated: true)
      } else {
        navigationItem.setRightBarButtonItems(nil, animated: true)
      }
    } else {
      let itemsToAdd = [UIBarButtonItem](barButtonItems[side]![index][0 ..< itemCount])

      if side == .leftSide {
        navigationItem.setLeftBarButtonItems(itemsToAdd, animated: true)
      } else {
        navigationItem.setRightBarButtonItems(itemsToAdd, animated: true)
      }
    }
  }

  func updatenavbarButtonItemDetailLabel() {
    var detail = ""

    let leftItemCount = navbarLeftButtonItemCountSegmentedControl.selectedSegmentIndex
    if leftItemCount > 0 {
      switch navbarLeftButtonItemStyleSegmentedControl.selectedSegmentIndex {
      case 0:
        detail +=
          "let item = UIBarButtonItem(barButtonSystemItem: .action ...)\n"
          + "navigationItem.setLeftBarButtonItem(item, animated: true)"
      case 1:
        detail +=
          "var items = [UIBarButtonItem]()\n"
          + "for _ in 0..<\(leftItemCount) {\n"
          + "  let item = UIBarButtonItem(title: \"1\" ...)\n"
          + "  items.append(item)\n"
          + "}\n"
          + "navigationItem.setLeftBarButtonItems(items, animated: true)"
      case 2:
        detail +=
          "var items = [UIBarButtonItem]()\n"
          + "for _ in 0..<\(leftItemCount) {\n"
          + "  let item = UIBarButtonItem(customView: UIImageView(...) ...)\n"
          + "  items.append(item)\n"
          + "}\n"
          + "navigationItem.setLeftBarButtonItems(items, animated: true)"
      case 3:
        detail +=
          "var items = [UIBarButtonItem]()\n"
          + "for _ in 0..<\(leftItemCount) {\n"
          + "  let button = UIButton(...)\n"
          + "  button.frame = CGRect(...)\n"
          + "  button.setTitle(...)\n"
          + "  let item = UIBarButtonItem(customView: UIButton(...) ...)\n"
          + "  items.append(item)\n"
          + "}\n"
          + "navigationItem.setLeftBarButtonItems(items, animated: true)"
      default:
        assertionFailure()
      }
    }

    detail += "\n\n"
      + "navigationItem.setHidesBackButton(\(navbarHideBackButtonSwitch.isOn), animedted: true)\n"
      + "navigationItem.leftItemsSupplementBackButton = \(navigationItem.leftItemsSupplementBackButton)\n\n"

    let rightItemCount = navbarRightButtonItemCountSegmentedControl.selectedSegmentIndex
    if rightItemCount > 0 {
      switch navbarRightButtonItemStyleSegmentedControl.selectedSegmentIndex {
      case 0:
        detail +=
          "let item = UIBarButtonItem(barButtonSystemItem: .action ...)\n"
          + "navigationItem.setRightBarButtonItem(item, animated: true)"
      case 1:
        detail +=
          "var items = [UIBarButtonItem]()\n"
          + "for _ in 0..<\(rightItemCount) {\n"
          + "  let item = UIBarButtonItem(title: \"1\" ...)\n"
          + "  items.append(item)\n"
          + "}\n"
          + "navigationItem.setRightBarButtonItems(items, animated: true)"
      case 2:
        detail +=
          "var items = [UIBarButtonItem]()\n"
          + "for _ in 0..<\(rightItemCount) {\n"
          + "  let item = UIBarButtonItem(image: UIImage(...) ...)\n"
          + "  items.append(item)\n"
          + "}\n"
          + "navigationItem.setRightBarButtonItems(items, animated: true)"
      case 3:
        detail +=
          "var items = [UIBarButtonItem]()\n"
          + "for _ in 0..<\(rightItemCount) {\n"
          + "  let button = UIButton(...)\n"
          + "  button.frame = CGRect(...)\n"
          + "  button.setTitle(...)\n"
          + "  let item = UIBarButtonItem(customView: UIButton(...) ...)\n"
          + "  items.append(item)\n"
          + "}\n"
          + "navigationItem.setRightBarButtonItems(items, animated: true)"
      default:
        assertionFailure()
      }
    }

    navbarButtonItemDetailLabel.text = detail
    tableView.reloadData()
  }

  // MARK: Customize navigation bar

  @IBAction func promptSwitchChanged(_ sender: UISwitch) {
    if sender.isOn {
      navigationItem.prompt = "宜达互联 SWIFT"
      promptDetailLabel.text = "navigationItem.prompt = \"宜达互联 SWIFT\""
      Jack.verbose("navigation bar with prompt, height: \(navigationBar.frame.height)")
    } else {
      navigationItem.prompt = nil
      promptDetailLabel.text = "navigationItem.prompt = nil"
      Jack.verbose("navigation bar without prompt, height: \(navigationBar.frame.height)")
    }
  }

  @IBAction func navbarStyleChanged(_ sender: UISegmentedControl) {
    // bar style setting will be overriden by background setting
    navbarBackgroundSegmentedControl.selectedSegmentIndex = 0
    navbarBackgroundChanged(navbarBackgroundSegmentedControl)

    switch sender.selectedSegmentIndex {
    case 0: // default
      navigationBar.barStyle = .default
      navigationBar.tintColor = nil
      navbarStyleDetailLabel.text = "navigationController!.navigationBar.barStyle = .default"
    case 1: // black
      navigationBar.barStyle = .black
      navigationBar.tintColor = .white
      navbarStyleDetailLabel.text = "navigationController!.navigationBar.barStyle = .black"
    default:
      assertionFailure()
    }

    setNeedsStatusBarAppearanceUpdate()
    updatenavbarIems(of: .leftSide)
    updatenavbarIems(of: .rightSide)
    tableView.reloadData()
  }

  @IBAction func navbarBackgroundChanged(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {

    case 0: // default
      navigationBar.setBackgroundImage(nil, for: .default)

      navigationBar.barTintColor = nil
      navigationBar.tintColor = (navigationBar.barStyle == .default) ? nil : .white
      navigationBar.titleTextAttributes = nil

      navbarBackgroundDetailLabel.text =
        "navigationBar.barTintColor = nil\n"
        + "navigationBar.tintColor = nil\n"
        + "navigationBar.titleTextAttributes = nil"

    case 1: // color background
      navigationBar.setBackgroundImage(nil, for: .default)

      navigationBar.barTintColor = view.window?.tintColor
      navigationBar.tintColor = .white
      navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

      navbarBackgroundDetailLabel.text =
        "navigationBar.barTintColor = view.window?.tintColor\n"
        + "navigationBar.tintColor = .white\n"
        + "navigationBar.titleTextAttributes = [\n"
        + "  NSForegroundColorAttributeName: UIColor.white\n"
        + "]"

    case 2: // image background
      navigationBar.tintColor = .white
      navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
      navigationBar.setBackgroundImage(#imageLiteral(resourceName: "Navbar"), for: .default)
      navbarBackgroundDetailLabel.text = "navigationBar.setBackgroundImage(aImage, for: .default)"

    default:
      assertionFailure()
    }

    setNeedsStatusBarAppearanceUpdate()
    updatenavbarIems(of: .leftSide)
    updatenavbarIems(of: .rightSide)
    tableView.reloadData()
  }

  @IBAction func navbarTitleChanged(_ sender: UISegmentedControl) {

    switch sender.selectedSegmentIndex {

    case 0: // text title
      navigationItem.titleView = nil
      navigationItem.title = "标题"
      navbarTitleDetailLabel.text =
        "navigationItem.titleView = nil\n"
        + "navigationItem.title = \"标题\""

    case 1: // image title
      navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "NavbarTitle"))
      navbarTitleDetailLabel.text = "navigationItem.titleView = UIImageView(image: aImage)"

    case 2: // custom view
      let control = UISegmentedControl(items: ["左", "右"])
      control.selectedSegmentIndex = 0
      navigationBar.setTitleVerticalPositionAdjustment(-1, for: .default)
      navigationItem.titleView = control
      navbarTitleDetailLabel.text = "navigationItem.titleView = aControl"

    default:
      assertionFailure()
    }
  }

  @IBAction func navbarLeftButtonItemStyleChanged(_ sender: UISegmentedControl) {
    if navbarLeftButtonItemStyleSegmentedControl.selectedSegmentIndex == 0 {
      if navbarLeftButtonItemCountSegmentedControl.selectedSegmentIndex > 1 {
        navbarLeftButtonItemCountSegmentedControl.selectedSegmentIndex = 1
      }
      navbarLeftButtonItemCountSegmentedControl.setEnabled(false, forSegmentAt: 2)
    } else {
      navbarLeftButtonItemCountSegmentedControl.setEnabled(true, forSegmentAt: 2)
    }

    updatenavbarIems(of: .leftSide)
    updatenavbarButtonItemDetailLabel()
  }

  @IBAction func navbarLeftButtonItemCountChanged(_ sender: UISegmentedControl) {
    updatenavbarIems(of: .leftSide)
    updatenavbarButtonItemDetailLabel()
  }

  @IBAction func navbarHideBackButtonChanged(_ sender: UISwitch) {
    guard (navigationItem.leftItemsSupplementBackButton
      && navigationItem.leftBarButtonItems != nil)
      || navigationItem.leftBarButtonItems == nil else {
      return
    }

    navigationItem.setHidesBackButton(sender.isOn, animated: true)
    updatenavbarButtonItemDetailLabel()
  }

  @IBAction func navbarCoexistsWithBackButtonChanged(_ sender: UISwitch) {
    navigationItem.leftItemsSupplementBackButton = sender.isOn
    updatenavbarButtonItemDetailLabel()
  }

  @IBAction func navbarRightBarButtonItemCountChanged(_ sender: UISegmentedControl) {
    updatenavbarIems(of: .rightSide)
    updatenavbarButtonItemDetailLabel()
  }

  @IBAction func navRightBarButtonItemStyleChanged(_ sender: UISegmentedControl) {
    if navbarRightButtonItemStyleSegmentedControl.selectedSegmentIndex == 0 {
      if navbarRightButtonItemCountSegmentedControl.selectedSegmentIndex > 1 {
        navbarRightButtonItemCountSegmentedControl.selectedSegmentIndex = 1
      }
      navbarRightButtonItemCountSegmentedControl.setEnabled(false, forSegmentAt: 2)
    } else {
      navbarRightButtonItemCountSegmentedControl.setEnabled(true, forSegmentAt: 2)
    }

    updatenavbarIems(of: .rightSide)
    updatenavbarButtonItemDetailLabel()
  }

  // MARK: Customize tool bar

  lazy var toolbarButtonItems = inittoolbarBarButtonItems()

  private func updatetoolbarItems() {
    var items = [UIBarButtonItem](toolbarButtonItems[toolbarItemStyleSegmentedControl.selectedSegmentIndex])
    let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    fixedSpace.width = 5
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    switch toolbarItemLayoutSegmentedControl.selectedSegmentIndex {
    case 0:
      items.insert(flexibleSpace, at: 0)
      items.insert(flexibleSpace, at: 2)
      items.insert(flexibleSpace, at: 4)
      items.insert(flexibleSpace, at: 6)
      setToolbarItems(items, animated: true)
    case 1:
      items.insert(fixedSpace, at: 0)
      items.insert(flexibleSpace, at: 2)
      items.insert(flexibleSpace, at: 4)
      items.insert(fixedSpace, at: 6)
      setToolbarItems(items, animated: true)
    case 2:
      items.insert(flexibleSpace, at: 0)
      items.insert(fixedSpace, at: 2)
      items.insert(fixedSpace, at: 4)
      items.append(flexibleSpace)
      setToolbarItems(items, animated: true)
    default:
      assertionFailure()
    }
  }

  private func updateToolbarItemsDetail() {
    var itemCreation = ""
    var itemLayout = ""

    itemCreation +=
      "let fixedSpace = UIBarButtonItem("
      + "\n  barButtonSystemItem: .fixedSpace, ...)"
      + "\nlet flexibleSpace = UIBarButtonItem("
      + "\nbarButtonSystemItem: .flexibleSpace, ...)"

    switch toolbarItemStyleSegmentedControl.selectedSegmentIndex {
    case 0: // system
      itemCreation +=
        "\nlet item1 = UIBarButtonItem(barButtonSystemItem: .rewind, ...)"
        + "\nlet item2 = UIBarButtonItem(barButtonSystemItem: .pause, ...)"
        + "\nlet item3 = UIBarButtonItem(barButtonSystemItem: .fastForward, ...)"
    case 1: // with title
      itemCreation +=
        "\nlet item1 = UIBarButtonItem(title: \"左边\", ...)"
        + "\nlet item2 = UIBarButtonItem(title: \"中间\", ...)"
        + "\nlet item3 = UIBarButtonItem(title: \"右边\", ...)"
    case 2: // with image
      itemCreation +=
        "\nlet item1 = UIBarButtonItem(image: ...)"
        + "\nlet item2 = UIBarButtonItem(image: ...)"
        + "\nlet item3 = UIBarButtonItem(image: ...)"
    case 3: // with custom view
      itemCreation +=
        "\nlet item1 = UIBarButtonItem(customView: view1, ...)"
        + "\nlet item2 = UIBarButtonItem(customView: view2, ...)"
        + "\nlet item3 = UIBarButtonItem(customView: view3, ...)"
    default:
      assertionFailure()
    }

    switch toolbarItemLayoutSegmentedControl.selectedSegmentIndex {
    case 0:
      itemLayout =
        "let items = [flexibleSpace, item1, flexibleSpace,"
        + "\n  item2, flexibleSpace, item3, flexibleSpace]"
    case 1:
      itemLayout =
        "let items = [fixedSpace, item1, flexibleSpace,"
        + "\n  item2, flexibleSpace, item3, fixedSpace]"
    case 2:
      itemLayout =
        "let items = [flexibleSpace, item1, fixedSpace,"
        + "\n  item2, fixedSpace, item3, flexibleSpace]"
    default:
      assertionFailure()
    }

    let detail = "\(itemCreation)\n\n\(itemLayout)"
      + "\n\nsetToolbarItems(items, animated: true)"

    toolbarItemsDetailLabel.text = detail
    tableView.reloadData()
  }

  @IBAction func toolbarStyleChanged(_ sender: UISegmentedControl) {
    toolbarBackgroundSegmentedControl.selectedSegmentIndex = 0
    toolbarBackgroundChanged(toolbarBackgroundSegmentedControl)

    switch sender.selectedSegmentIndex {
    case 0: // default
      toolbar.barStyle = .default
      toolbar.tintColor = nil
    case 1: // black
      toolbar.barStyle = .black
      toolbar.tintColor = .white
    default:
      assertionFailure()
    }

    updatetoolbarItems()

    toolbarStyleDetailLabel.text = "navigationController?.toolbar.barStyle = \((sender.selectedSegmentIndex == 0) ? ".default" : ".black")"
    tableView.reloadData()
  }

  @IBAction func toolbarBackgroundChanged(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0: // default
      toolbar.barTintColor = nil
      toolbar.setBackgroundImage(nil, forToolbarPosition: .any, barMetrics: .default)

      toolbarBackgroundDetailLabel.text =
        "navigationController!.toolbar.setbackgroundImage("
        + "\n  nil, forToolbarPosition: .any, barMetrics: .default)"
        + "\nnavigationController!.toolbar.barTintColor = nil"
    case 1: // color
      toolbar.setBackgroundImage(nil, forToolbarPosition: .any, barMetrics: .default)
      toolbar.barTintColor = view.window!.tintColor
      toolbar.tintColor = .white

      toolbarBackgroundDetailLabel.text =
        "navigationController!.toolbar.setbackgroundImage("
        + "\n  nil, forToolbarPosition: .any, barMetrics: .default)"
        + "\nnavigationController!.toolbar.barTintColor = aColor"
        + "\nnavigationController!.toolbar.tintColor = .white"
    case 2:
      toolbar.setBackgroundImage(#imageLiteral(resourceName: "Toolbar"), forToolbarPosition: .any, barMetrics: .default)
      toolbar.tintColor = .white

      toolbarBackgroundDetailLabel.text =
        "navigationController!.toolbar.setbackgroundImage("
        + "\n  aImage, forToolbarPosition: .any, barMetrics: .default)"
        + "\nnavigationController!.toolbar.tintColor = .white"
    default:
      assertionFailure()
    }

    updatetoolbarItems()
    tableView.reloadData()
  }

  @IBAction func toolbarItemStyleChanged(_ sender: UISegmentedControl) {
    updatetoolbarItems()
    updateToolbarItemsDetail()
  }

  @IBAction func toolbarItemLayoutChanged(_ sender: UISegmentedControl) {
    updatetoolbarItems()
    updateToolbarItemsDetail()
  }

  // MARK: - Overrides

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.estimatedRowHeight = 50

    // controll UI testable
    promptSwitch.accessibilityIdentifier = "prompt"

    navbarStyleSegmentedControl.accessibilityIdentifier = "navbarStyle"
    navbarBackgroundSegmentedControl.accessibilityIdentifier = "navbarBackground"
    navbarTitleSegmentedControl.accessibilityIdentifier = "navTitle"

    navbarLeftButtonItemStyleSegmentedControl.accessibilityIdentifier = "navLeftBarButtonItemStyle"
    navbarLeftButtonItemCountSegmentedControl.accessibilityIdentifier = "navLeftBarButtonItemCount"
    navbarRightButtonItemStyleSegmentedControl.accessibilityIdentifier = "navRightBarButtonItemStyle"
    navbarRightButtonItemCountSegmentedControl.accessibilityIdentifier = "navRightBarButtonItemCount"
    navbarHideBackButtonSwitch.accessibilityIdentifier = "hidesBackButton"
    navbarCoexistsWithBackButtonSwitch.accessibilityIdentifier = "coexistsWithBackButton"

    toolbarStyleSegmentedControl.accessibilityIdentifier = "toolbarStyle"
    toolbarBackgroundSegmentedControl.accessibilityIdentifier = "toolbarBackground"
    toolbarItemStyleSegmentedControl.accessibilityIdentifier = "toolbarItemStyle"
    toolbarItemLayoutSegmentedControl.accessibilityIdentifier = "toolbarItemLayout"
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    // update navigation bar appearence
    promptSwitchChanged(promptSwitch)
    navbarStyleChanged(navbarStyleSegmentedControl)
    navbarBackgroundChanged(navbarBackgroundSegmentedControl)
    navbarTitleChanged(navbarTitleSegmentedControl)

    navbarLeftButtonItemStyleChanged(navbarLeftButtonItemStyleSegmentedControl)
    navRightBarButtonItemStyleChanged(navbarRightButtonItemStyleSegmentedControl)

    // update tool bar appearence
    navigationController?.setToolbarHidden(false, animated: true)
    updateToolbarItemsDetail()
    toolbarStyleChanged(toolbarStyleSegmentedControl)
    toolbarBackgroundChanged(toolbarBackgroundSegmentedControl)
    toolbarItemStyleChanged(toolbarItemStyleSegmentedControl)
    toolbarItemLayoutChanged(toolbarItemLayoutSegmentedControl)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let height = super.tableView(tableView, heightForRowAt: indexPath)

    if indexPath.row % 2 == 1 {
      return UITableViewAutomaticDimension
    } else {
      return height
    }
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

private func initBarButtonItems() -> [CustomNavigationControllerTableViewController.navbarItemSide: [[UIBarButtonItem]]] {
  var items: [CustomNavigationControllerTableViewController.navbarItemSide: [[UIBarButtonItem]]] = [
    CustomNavigationControllerTableViewController.navbarItemSide.leftSide: [
      [
        UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil),
      ],
      [
        UIBarButtonItem(title: "左一", style: .plain, target: nil, action: nil),
        UIBarButtonItem(title: "左二", style: .plain, target: nil, action: nil),
      ],
      [
        UIBarButtonItem(image: #imageLiteral(resourceName: "BarButtonItem-1"), style: .plain, target: nil, action: nil),
        UIBarButtonItem(image: #imageLiteral(resourceName: "BarButtonItem-2"), style: .plain, target: nil, action: nil),
      ],
    ],

    CustomNavigationControllerTableViewController.navbarItemSide.rightSide: [
      [
        UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil),
      ],
      [
        UIBarButtonItem(title: "右一", style: .plain, target: nil, action: nil),
        UIBarButtonItem(title: "右二", style: .plain, target: nil, action: nil),
      ],
      [
        UIBarButtonItem(image: #imageLiteral(resourceName: "BarButtonItem-1"), style: .plain, target: nil, action: nil),
        UIBarButtonItem(image: #imageLiteral(resourceName: "BarButtonItem-2"), style: .plain, target: nil, action: nil),
      ],
    ],
  ]

  var itemList = [UIBarButtonItem]()
  for i in 1 ... 2 {
    let button = UIButton(type: .system)
    button.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
    button.setTitle("B\(i)", for: .normal)
    let item = UIBarButtonItem(customView: button)
    itemList.append(item)
  }
  items[.leftSide]!.append(itemList)

  itemList = [UIBarButtonItem]()
  for i in 1 ... 2 {
    let button = UIButton(type: .system)
    button.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
    button.setTitle("B\(i)", for: .normal)
    let item = UIBarButtonItem(customView: button)
    itemList.append(item)
  }
  items[.rightSide]!.append(itemList)

  return items
}

private func inittoolbarBarButtonItems() -> [[UIBarButtonItem]] {
  var items: [[UIBarButtonItem]] = []
  // system item
  var sublist = [
    UIBarButtonItem(barButtonSystemItem: .rewind, target: nil, action: nil),
    UIBarButtonItem(barButtonSystemItem: .pause, target: nil, action: nil),
    UIBarButtonItem(barButtonSystemItem: .fastForward, target: nil, action: nil),
  ]
  items.append(sublist)

  // item with title
  sublist = [
    UIBarButtonItem(title: "左边", style: .plain, target: nil, action: nil),
    UIBarButtonItem(title: "中间", style: .plain, target: nil, action: nil),
    UIBarButtonItem(title: "右边", style: .plain, target: nil, action: nil),
  ]
  items.append(sublist)

  // item with image
  sublist = [
    UIBarButtonItem(image: #imageLiteral(resourceName: "BarButtonItem-3"), style: .plain, target: nil, action: nil),
    UIBarButtonItem(image: #imageLiteral(resourceName: "BarButtonItem-4"), style: .plain, target: nil, action: nil),
    UIBarButtonItem(image: #imageLiteral(resourceName: "BarButtonItem-5"), style: .plain, target: nil, action: nil),
  ]
  items.append(sublist)

  // items with custom view
  sublist = []

  var segment = UISegmentedControl(items: ["左一", "左二"])
  segment.selectedSegmentIndex = 0
  sublist.append(UIBarButtonItem(customView: segment))

  let switchControl = UISwitch()
  switchControl.isOn = true
  sublist.append(UIBarButtonItem(customView: switchControl))

  segment = UISegmentedControl(items: ["右二", "右一"])
  segment.selectedSegmentIndex = 1
  sublist.append(UIBarButtonItem(customView: segment))

  items.append(sublist)

  return items
}
