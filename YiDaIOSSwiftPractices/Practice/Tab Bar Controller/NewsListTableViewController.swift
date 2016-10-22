////  NewsListTableViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 22/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class NewsListTableViewController: UITableViewController {

  let newsList = DataSource.newsList
  var urlToBrowse: URL?

  override func viewDidLoad() {
    super.viewDidLoad()

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()

    tableView.rowHeight = 126

    installDismissButtonOnNavigationBar()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNeedsStatusBarAppearanceUpdate()
  }
}

// MARK: - as UITableViewDataSource
extension NewsListTableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return newsList.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "News List Cell", for: indexPath) as! NewsListTableViewCell
    cell.setup(with: newsList[indexPath.row])
    return cell
  }
}

// MARK: - as UITableViewDelegate
extension NewsListTableViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let newsItem = newsList[indexPath.row]
    urlToBrowse = newsItem.url
    performSegue(withIdentifier: "Browse News Content", sender: self)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "Browse News Content" else {
      fatalError("unexpected segue identifier '\(segue.identifier)'")
    }

    let browserVC = segue.destination as! BrowserViewController
    browserVC.homeURL = urlToBrowse
  }
}
