//
//  SecondLevelMenuTableViewCell.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 9/21/16.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit
import SwiftyJSON

class SecondLevelMenuTableViewCell: UITableViewCell {
  @IBOutlet weak var titleLabel: YDTintedLabel!
  @IBOutlet weak var subtitleLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func set(withJSONItem item: JSON) {
    titleLabel.text = item["title"].stringValue
    subtitleLabel.text = item["subtitle"].stringValue
  }
}
