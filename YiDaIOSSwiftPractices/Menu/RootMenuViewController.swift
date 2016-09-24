//
//  RootMenuViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 9/20/16.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class RootMenuViewController: UIViewController {

  @IBOutlet weak var topButton: UIButton!
  @IBOutlet weak var bottomButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    configureButtons()
  }

  func configureButtons() {
    // top button
    //    topButton.layer.cornerRadius = 4
    //    topButton.layer.masksToBounds = true

    //    var hiImage: UIImage

    //    topButton.setBackgroundImage(#imageLiteral(resourceName: "RootMenuTopButtonBackgroundImage"), for: .highlighted)
    //    hiImage = blurredImage(from: #imageLiteral(resourceName: "RootMenuTopButtonBackgroundImage"), radius: 15)
    //    topButton.setBackgroundImage(hiImage, for: .normal)

    // bottom button
    //    bottomButton.layer.cornerRadius = 4
    //    bottomButton.layer.masksToBounds = true

    //    bottomButton.setBackgroundImage(#imageLiteral(resourceName: "RootMenuBottomButtonBackgroundImage"), for: .highlighted)
    //    hiImage = blurredImage(from: #imageLiteral(resourceName: "RootMenuBottomButtonBackgroundImage"), radius: 15)
    //    bottomButton.setBackgroundImage(hiImage, for: .normal)
  }

  func blurredImage(from image: UIImage, radius: Float) -> UIImage {
    let context = CIContext(options: nil)
    let input = CIImage(cgImage: image.cgImage!)

    let blur = CIFilter(name: "CIGaussianBlur")!
    blur.setValue(input, forKey: kCIInputImageKey)
    blur.setValue(radius, forKey: kCIInputRadiusKey)
    let output = blur.value(forKey: kCIOutputImageKey) as! CIImage

    let cgImage = context.createCGImage(output, from: input.extent)!

    return UIImage(cgImage: cgImage)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: true)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    self.navigationController?.setNavigationBarHidden(false, animated: true)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc = segue.destination as! SecondLevelMenuTableViewController

    let bar = UINavigationBar.appearance()

    switch segue.identifier! {
    case "Show iOS Basics Second Menu":
      vc.practiceLevel = .Basics

      let baseColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)

      UIApplication.shared.keyWindow!.tintColor = baseColor
      bar.barTintColor = baseColor
      bar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      bar.titleTextAttributes = [
        NSForegroundColorAttributeName: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
      ]

    case "Show iOS Advanced Second Menu":
      vc.practiceLevel = .Advanced
      let baseColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)

      UIApplication.shared.keyWindow!.tintColor = baseColor
      bar.barTintColor = baseColor
      bar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      bar.titleTextAttributes = [
        NSForegroundColorAttributeName: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
      ]

    default:
      assertionFailure("Invalid segue identifier \(segue.identifier!)")
    }
  }

  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    return true
  }
}
