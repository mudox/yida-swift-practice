//
//  ImageSource.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 26/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

struct ImageSource {
  static let shared = ImageSource()
  
  func aImage(
    imageSize: CGSize,
    imageText: String? = nil,
    backgroundColor: UIColor = .orange,
    foregroundColor: UIColor = .white
    ) -> UIImage {
    
    let text = imageText ?? "\(imageSize.width)x\(imageSize.height)"
    if let image = fetchFromCache(
      size: imageSize, text: text, backgroundColor: backgroundColor,foregroundColor: foregroundColor) {
      return image
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, true, 1)
    
    // drawing background
    let frame = CGRect(origin: .zero, size: imageSize)
    UIColor.orange.setFill()
    let path = UIBezierPath(rect: frame)
    path.fill()
    
    // height
    var fontSize = imageSize.height
    let textStyle = NSMutableParagraphStyle()
    textStyle.alignment = .center
    var textAttributes = [
      NSFontAttributeName: UIFont.systemFont(ofSize: 100),
      NSForegroundColorAttributeName: UIColor.white,
      NSParagraphStyleAttributeName: textStyle
    ]
    
    var textSize = text.boundingRect(
      with: CGSize(width: CGFloat.infinity, height: CGFloat.infinity),
      options: NSStringDrawingOptions.usesLineFragmentOrigin,
      attributes: textAttributes,
      context: nil
    )
    
    let gap: CGFloat = 8
    let maxWidthAllowed = frame.width - gap * 2
    if textSize.width > maxWidthAllowed {
      fontSize = fontSize * maxWidthAllowed / textSize.width
      while true {
        textAttributes[NSFontAttributeName] = UIFont.systemFont(ofSize: fontSize)
        textSize = text.boundingRect(
          with: CGSize(width: CGFloat.infinity, height: CGFloat.infinity),
          options: NSStringDrawingOptions.usesLineFragmentOrigin,
          attributes: textAttributes,
          context: nil
        )
        
        if textSize.width < maxWidthAllowed {
          break
        } else {
          fontSize -= 1
        }
      }
    }
    
    text.draw(in: CGRect(x: frame.minX, y: (frame.height - textSize.height) / 2, width: frame.width, height: textSize.height), withAttributes: textAttributes)
    
    return UIGraphicsGetImageFromCurrentImageContext()!
  }
  
  func fetchFromCache(size: CGSize, text: String, backgroundColor: UIColor, foregroundColor: UIColor) -> UIImage? {
    // fake return
    return nil
  }
}
