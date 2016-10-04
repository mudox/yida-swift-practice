//
//  NavigationContentViewController.swift
//
//
//  Created by Mudox on 04/10/2016.
//
//

import UIKit

class NavigationContentViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func jumpButtonTapped(_ sender: AnyObject) {
    let title = "导航控制器"
    let message = "请选择跳转到："

    let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

    var action: UIAlertAction

    action = UIAlertAction(title: "上一级视图控制器", style: .default, handler: { (action: UIAlertAction) in
      let _ = self.navigationController?.popViewController(animated: true)
    })
    alert.addAction(action)

    action = UIAlertAction(title: "第二级视图控制器", style: .default, handler: { (action: UIAlertAction) in
      if let secondLevelViewController = self.navigationController?.viewControllers[1] {
        let _ = self.navigationController?.popToViewController(secondLevelViewController, animated: true)
      } else {
        Jack.debug("2nd level content view controller not exists")
      }
    })
    alert.addAction(action)

    action = UIAlertAction(title: "根视图控制器", style: .default, handler: { (action: UIAlertAction) in
      let _ = self.navigationController?.popToRootViewController(animated: true)
    })
    alert.addAction(action)

    self.present(alert, animated: true, completion: nil)
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
