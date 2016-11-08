//
//  MainEarlGreyTests.swift
//  MainEarlGreyTests
//
//  Created by Mudox on 07/11/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import EarlGrey
import XCTest

let G = EarlGrey.self

fileprivate enum Part: String {
	case basics = "Basics 1st Level Button"
	case advanced = "Advanced 1st Level Button"
	case framework = "Framework 1st Level Button"
}

fileprivate func enter(_ part: Part) {
	G.select(elementWithMatcher: grey_accessibilityID(part.rawValue))
		.perform(grey_tap())
}

class MainEarlGreyTests: XCTestCase {

	func testLoginForm() {
		enter(.basics)

		G.select(elementWithMatcher: grey_accessibilityID("Login Form Interface"))
			.perform(grey_tap())

		G.select(elementWithMatcher: grey_accessibilityID("student name"))
			.perform(grey_tap())
			.perform(grey_replaceText("王尼玛"))

		G.select(elementWithMatcher:
				grey_allOfMatchers([
					grey_accessibilityLabel("女"),
					grey_accessibilityTrait(UIAccessibilityTraitButton),
			])
		).perform(grey_tap())

		G.select(elementWithMatcher: grey_accessibilityID("number"))
			.perform(grey_typeText("YD-2016-0023"))

		G.select(elementWithMatcher: grey_accessibilityID("password"))
			.perform(grey_typeText("thisisasecret"))

		G.select(elementWithMatcher: grey_accessibilityID("phone"))
			.perform(grey_typeText("18388383923"))

		G.select(elementWithMatcher: grey_accessibilityID("birthday"))
			.perform(grey_tap())

		G.select(elementWithMatcher: grey_accessibilityID("date input picker"))
			.perform(grey_setDate(Date(timeIntervalSinceNow: -3600 * 356 * 24)))

		G.select(elementWithMatcher: grey_accessibilityID("address"))
			.usingSearch(grey_scrollInDirection(.down, 50), onElementWith: grey_kindOfClass(UIScrollView.self))
			.perform(grey_replaceText("深圳市 福田区 车公庙皇 冠科技园 A2312"))

		G.select(elementWithMatcher: grey_accessibilityID("email"))
			.perform(grey_typeText("wangnima@yd.com"))

		G.select(elementWithMatcher: grey_accessibilityID("register"))
			.perform(grey_tap())

		sleep(4)

		G.select(elementWithMatcher: grey_accessibilityID("message view"))
			.perform(grey_tap())

		G.select(elementWithMatcher: grey_accessibilityID("dismiss button"))
			.perform(grey_tap())
	}

}
