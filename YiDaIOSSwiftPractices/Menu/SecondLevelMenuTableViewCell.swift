//
//  SecondLevelMenuTableViewCell.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 9/21/16.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class SecondLevelMenuTableViewCell: UITableViewCell {
  @IBOutlet weak var title: YDTintedLabel!
  @IBOutlet weak var subtitle: UILabel!

  var level: YiDaIOSPracticeLevel = .Basics

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func set(withInfo info: SecondLevelMenuCellInfo) {
    title.text = info.title
    subtitle.text = info.subTitle
  }
}
