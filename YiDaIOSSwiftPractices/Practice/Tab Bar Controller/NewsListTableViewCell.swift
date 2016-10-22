//
//  NewsListTableViewCell.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 22/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var thumbnailView: UIImageView!
  @IBOutlet weak var sourceLabel: UILabel!
  @IBOutlet weak var dateLable: UILabel!
  @IBOutlet weak var readCountLabel: UILabel!

  func setup(with item: NewsItem) {
    titleLabel.text = item.title
    descriptionLabel.text = item.description
    thumbnailView.image = UIImage(named: item.imageName)
    sourceLabel.text = item.source
    dateLable.text = item.timePassedDescription
    readCountLabel.text = "\(item.readCount)人已读"
  }
}
