//: [Previous](@previous)

import UIKit

func f1(x: @autoclosure ()-> String) {
  print(x())
}

func f2(x: @autoclosure ()-> String) {
  f1(x: x)
}

let rect = CGRect.zero
f2(x: rect.shortDescription)





//: [Next](@next)
