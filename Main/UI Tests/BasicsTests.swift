//
//  BasicsTests.swift
//  Main
//
//  Created by Mudox on 06/11/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//
import XCTest

extension MainUITests {

	func testLoginFormViewController() {
		enterBasicPartIfNeeded()
		app.cells["Login Form Interface"].tap()

		let validInputs = [
			("name", "王尼玛"),
			("number", "YD-2016-0133"),
			("phone", "18308837383"),
			("address", "深圳市福田区车公庙皇冠科技园"),
		]

		var field: XCUIElement

		for (id, text) in validInputs {
			field = app.textFields[id]
			field.tap()
			field.typeText(text)
		}

		field = app.textFields["birthday"]
		field.tap()

		field = app.secureTextFields["password"]
		field.tap()
		field.typeText("xixihaha")

		app.buttons["register"].tap()
		sleep(50)

	}
}
