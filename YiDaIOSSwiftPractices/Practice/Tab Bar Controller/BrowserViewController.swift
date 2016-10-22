//
//  BrowserViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 22/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController {
  var homeURL: URL?
  @IBOutlet weak var webView: UIWebView!
  @IBOutlet weak var addressBox: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    // set UI
    navigationController!.setToolbarHidden(false, animated: true)
//    navigationController!.toolbar.barTintColor = theWindow.tintColor
//    navigationController!.toolbar.tintColor = .white
    navigationItem.hidesBackButton = true
    setNeedsStatusBarAppearanceUpdate()

    addressBox.frame.size.width = navigationController!.navigationBar.bounds.width - 20

    // load page if any
    if let urlToLoad = homeURL {
      let request = URLRequest(url: urlToLoad)
      webView.loadRequest(request)
      addressBox.text = urlToLoad.host
    } else {
      addressBox.placeholder = "请输入要加载的地址"
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController!.setToolbarHidden(true, animated: animated)
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
  @IBAction func dismiss(_ sender: UIBarButtonItem) {
    navigationController!.popViewController(animated: true)
  }

  @IBAction func goBackward(_ sender: UIBarButtonItem) {
    if webView.canGoBack {
      webView.goBack()
    }
  }

  @IBAction func goForward(_ sender: UIBarButtonItem) {
    if webView.canGoForward {
      webView.goForward()
    }
  }

  @IBAction func goHome(_ sender: UIBarButtonItem) {
    if let urlToLoad = homeURL {
      let request = URLRequest(url: urlToLoad)
      webView.loadRequest(request)
    }
  }
}

// MARK: - as UITextFieldDelegate
extension BrowserViewController : UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    becomeFirstResponder()
    return true
  }

  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    resignFirstResponder()
    return true
  }
}
