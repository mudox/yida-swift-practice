//
//  RootMenuViewController.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 9/20/16.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class RootMenuViewController: UIViewController {
  @IBOutlet weak var topScrollLeading: NSLayoutConstraint!
  @IBOutlet weak var topScrollTrailing: NSLayoutConstraint!

  @IBOutlet weak var bottomScrollLeading: NSLayoutConstraint!
  @IBOutlet weak var bottomScrollTrailing: NSLayoutConstraint!

  @IBOutlet weak var topBox: UIView!
  @IBOutlet weak var topButton: UIButton!
  @IBOutlet weak var topScrollImageView: UIImageView!
  @IBOutlet weak var topVibrancyEffect: UIVisualEffectView!

  @IBOutlet weak var bottomBox: UIView!
  @IBOutlet weak var bottomButton: UIButton!
  @IBOutlet weak var bottomScrollImageView: UIImageView!
  @IBOutlet weak var bottomVibrancyEffect: UIVisualEffectView!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  //  func blurredImage(from image: UIImage, radius: Float) -> UIImage {
  //    let context = CIContext(options: nil)
  //    let input = CIImage(cgImage: image.cgImage!)
  //
  //    let blur = CIFilter(name: "CIGaussianBlur")!
  //    blur.setValue(input, forKey: kCIInputImageKey)
  //    blur.setValue(radius, forKey: kCIInputRadiusKey)
  //    let output = blur.value(forKey: kCIOutputImageKey) as! CIImage
  //
  //    let cgImage = context.createCGImage(output, from: input.extent)!
  //
  //    return UIImage(cgImage: cgImage)
  //  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.navigationController?.setNavigationBarHidden(true, animated: true)

    topVibrancyEffect.isHidden = true
    bottomVibrancyEffect.isHidden = true

    topScrollLeading.priority = UILayoutPriorityDefaultHigh
    topScrollTrailing.priority = UILayoutPriorityDefaultLow

    bottomScrollLeading.priority = UILayoutPriorityDefaultLow
    bottomScrollTrailing.priority = UILayoutPriorityDefaultHigh
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    topScrollLeading.priority = UILayoutPriorityDefaultLow
    topScrollTrailing.priority = UILayoutPriorityDefaultHigh

    bottomScrollLeading.priority = UILayoutPriorityDefaultHigh
    bottomScrollTrailing.priority = UILayoutPriorityDefaultLow

    UIView.animate(withDuration: 80, delay: 0, options: [.repeat, .autoreverse, .curveLinear], animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
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
      //      let baseColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
      let baseColor = #colorLiteral(red: 0.1022580639, green: 0.2696460485, blue: 0.5451318622, alpha: 1)

      UIApplication.shared.keyWindow!.tintColor = baseColor
      bar.barTintColor = baseColor
      bar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      bar.titleTextAttributes = [
        NSForegroundColorAttributeName: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
      ]

    case "Show iOS Advanced Second Menu":
      vc.practiceLevel = .Advanced
      //      let baseColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
      let baseColor = #colorLiteral(red: 0.745098114, green: 0.258823514, blue: 0.2392157018, alpha: 1)

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

  @IBAction func buttonTouchDown(_ button: UIButton) {
    switch button {
    case topButton:
      topVibrancyEffect.isHidden = false
    case bottomButton:
      bottomVibrancyEffect.isHidden = false
    default:
      assertionFailure()
    }
  }

  @IBAction func buttonTouchUpOuside(_ button: UIButton) {
    UIView.animate(withDuration: 0.4, animations: {
      switch button {
      case self.topButton:
        self.topVibrancyEffect.isHidden = true
      case self.bottomButton:
        self.bottomVibrancyEffect.isHidden = true
      default:
        assertionFailure()
      }
    })
  }

  @IBAction func buttonTouchUpInside(_ button: UIButton) {
    switch button {
    case topButton:
      topVibrancyEffect.isHidden = true
      performSegue(withIdentifier: "Show iOS Basics Second Menu", sender: self)
    case bottomButton:
      bottomVibrancyEffect.isHidden = true
      performSegue(withIdentifier: "Show iOS Advanced Second Menu", sender: self)
    default:
      assertionFailure()
    }
  }

  //  @IBAction func buttonTouchCancel(_ sender: AnyObject) {
  //    Jack.info("...")
  //  }
  //
  //  @IBAction func buttonDragExit(_ sender: AnyObject) {
  //    Jack.info("...")
  //  }
  //
  //  @IBAction func buttonDragEnter(_ sender: UIButton) {
  //    Jack.info("...")
  //  }
}
