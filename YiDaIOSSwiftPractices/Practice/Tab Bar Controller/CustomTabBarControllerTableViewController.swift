//
//  CustomTabBarControllerTableViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 19/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class CustomTabBarControllerTableViewController: UITableViewController {

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



  // MARK: - Actions
  @IBAction func dimiss(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }

}
