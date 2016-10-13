//
//  CustomPresentedViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 12/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class CustomPresentedViewController: UIViewController {
  @IBOutlet weak var labelView: UILabel!
  var labelText = "点击灰暗区域撤下本视图"

  var direction = PresentationDirection.center

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    labelView.text = labelText
  }

  override func viewWillAppear(_ animated: Bool) {
   super.viewWillAppear(animated)

    if direction == .center {
      view.layer.cornerRadius = 4
    } else {
      view.layer.cornerRadius = 0
    }

    labelView.alpha = 0

    Jack.verbose("\ncoordinator: \(self.transitionCoordinator)")
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    UIView.animate(withDuration: 0.15) {
      self.labelView.alpha = 1
    }

    Jack.verbose("\ncoordinator: \(self.transitionCoordinator)")
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    labelView.alpha = 0
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
