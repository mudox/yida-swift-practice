//: [Previous](@previous)

import UIKit

let a: UIView = UILabel()

extension UINavigationBar {
  open override func tintColorDidChange() {
    print("new tint color: \(tintColor)")
  }
}

let win = UIWindow()
let navBar = UINavigationBar()
win.addSubview(navBar)

win.tintColor = .blue
win.addSubview(UINavigationBar())

//: [Next](@next)
