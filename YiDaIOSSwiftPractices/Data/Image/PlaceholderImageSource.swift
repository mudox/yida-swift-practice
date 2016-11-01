//
//  PlaceholderImageSource.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 26/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

/**
 *  Use PlaceholderImageGenerator to draw a new image in memory and cache them for subsequent reuse.
 */
struct PlaceholderImageSource {

	static let backgroundColorsPool: [UIColor] = [
		#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1), #colorLiteral(red: 0.9803922176, green: 0.4745098054, blue: 0.1294118017, alpha: 1), #colorLiteral(red: 0.1803922057, green: 0.7686275244, blue: 0.7137255073, alpha: 1), #colorLiteral(red: 0.9058824182, green: 0.1137254983, blue: 0.2117646933, alpha: 1), #colorLiteral(red: 0.6078432202, green: 0.7725489736, blue: 0.2392157018, alpha: 1), #colorLiteral(red: 0.9294118285, green: 0.4156863093, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.3935527503, green: 0.3036974072, blue: 0.4120727777, alpha: 1), #colorLiteral(red: 0.2594889998, green: 0.1152844056, blue: 0.5033598542, alpha: 1), #colorLiteral(red: 0.5202972889, green: 0.0961311087, blue: 0.3996624649, alpha: 1), #colorLiteral(red: 0.1631833613, green: 0.3730655909, blue: 0.2650748491, alpha: 1), #colorLiteral(red: 0.4918266535, green: 0.266887933, blue: 0.5030089617, alpha: 1)
	]

	static func aImage(
		imageSize: CGSize,
		imageText: String? = nil,
		backgroundColor: UIColor? = nil,
		foregroundColor: UIColor? = .white
	) -> UIImage {

		let fgColor = foregroundColor ?? .white
		let bgColor = backgroundColor ?? backgroundColorsPool[Int(arc4random_uniform(UInt32(backgroundColorsPool.count)))]

//		if let image = fetchFromCache(
//			size: imageSize, text: imageText, backgroundColor: bgColor, foregroundColor: fgColor) {
//				return image
//		}

		let imageGenerater = PlaceholderImageGenerator(imageSize: imageSize)
		imageGenerater.foregroundColor = fgColor
		imageGenerater.backgroundColor = bgColor
		return imageGenerater.drawImage()
	}

	/* TODO:
	 static func aNavigationBarItemImage() -> UIImage {

	 }

	 static func aTabBarItemImage() -> UIImage {

	 }
	 */

	/* TODO:
	 static func fetchFromCache(size: CGSize, text: String, backgroundColor: UIColor, foregroundColor: UIColor) -> UIImage? {
	 // fake return
	 return nil
	 }
	 */
}
