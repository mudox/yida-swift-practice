//
//  YiDaIOSSwiftPracticesUITests.swift
//  YiDaIOSSwiftPracticesUITests
//
//  Created by Mudox on 9/8/16.
//  Copyright © 2016 Mudox. All rights reserved.
//

import XCTest

extension XCTest {

  var app: XCUIApplication {
    return XCUIApplication()
  }

  var device: XCUIDevice {
    return XCUIDevice.shared()
  }

  func enterBasicPartIfNeeded() {
    let button = app.buttons["基 础"]
    if button.exists {
      button.tap()
    }
  }

  func enterAdvancedPartIfNeeded() {
    let button = app.buttons["进 阶"]
    if button.exists {
      button.tap()
    }
  }

  func popCurrentViewController() {
    app.navigationBars.buttons["Back"].tap()
  }
}

class YiDaIOSSwiftPracticesUITests: XCTestCase {

  override func setUp() {
    super.setUp()

    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    app.launch()

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  // MARK: - Helpers

  // MARK: - Tests

  func testAll() {
    enterBasicPartIfNeeded()
    testNavgationContentViewController()
    testCustomNavigationController()

    popCurrentViewController()

    enterAdvancedPartIfNeeded()
  }
}

extension YiDaIOSSwiftPracticesUITests {

  func testCustomPresentationTableViewController() {
    enterBasicPartIfNeeded()
    app.cells["Customize View Controller Presentation And Transition"].tap()

    var chrome: XCUIElement
    var tapPoint: XCUICoordinate
    let control = app.segmentedControls["slideInPresentation"]

    // slide in from left
    control.buttons.element(boundBy: 0).tap()
    chrome = app.otherElements["dimmingView"]
    tapPoint = chrome.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.1))
    tapPoint.tap()

    // slide in from top
    control.buttons.element(boundBy: 1).tap()
    chrome = app.otherElements["dimmingView"]
    tapPoint = chrome.coordinate(withNormalizedOffset: CGVector(dx: 0.1, dy: 0.9))
    tapPoint.tap()

    // slide in to center
    control.buttons.element(boundBy: 2).tap()
    chrome = app.otherElements["dimmingView"]
    tapPoint = chrome.coordinate(withNormalizedOffset: CGVector(dx: 0.1, dy: 0.1))
    tapPoint.tap()

    // slide in from bottom
    control.buttons.element(boundBy: 3).tap()
    chrome = app.otherElements["dimmingView"]
    tapPoint = chrome.coordinate(withNormalizedOffset: CGVector(dx: 0.1, dy: 0.1))
    tapPoint.tap()

    // slide in from right
    control.buttons.element(boundBy: 4).tap()
    chrome = app.otherElements["dimmingView"]
    tapPoint = chrome.coordinate(withNormalizedOffset: CGVector(dx: 0.1, dy: 0.1))
    tapPoint.tap()
  }
}

extension YiDaIOSSwiftPracticesUITests {

  func testNavgationContentViewController() {
    enterBasicPartIfNeeded()
    app.cells["Navigation Controller Manages Content View Controllers"].tap()

    let jumpButton = app.navigationBars.buttons["跳转"]
    let actions = app.sheets["导航控制器"]
    for _ in 0 ..< 3 {
      jumpButton.tap()
      actions.buttons["压入新的视图控制器"].tap()
    }

    jumpButton.tap()
    actions.buttons["上一级视图控制器"].tap()
    jumpButton.tap()
    actions.buttons["第二级视图控制器"].tap()

    app.cells["Navigation Controller Manages Content View Controllers"].tap()
    jumpButton.tap()
    actions.buttons["根视图控制器"].tap()

    enterBasicPartIfNeeded()
  }

  func testCustomNavigationController() {
    enterBasicPartIfNeeded()
    app.cells["Customize Navigation Controller"].tap()

    // prompt
    app.tables.switches["prompt"].tap()

    // nav bar style
    app.segmentedControls["navbarStyle"].buttons.element(boundBy: 1).tap()

    // nav background
    for index: UInt in [1, 2] {
      app.segmentedControls["navbarBackground"].buttons.element(boundBy: index).tap()
    }

    // nav background
    for index: UInt in [2, 1] {
      app.segmentedControls["navTitle"].buttons.element(boundBy: index).tap()
    }

    // nav bar button items
    let leftStyle = app.segmentedControls["navLeftBarButtonItemStyle"]
    let leftCount = app.segmentedControls["navLeftBarButtonItemCount"]
    let hidesBackButton = app.switches["hidesBackButton"]
    let coexistsWithBackButton = app.switches["coexistsWithBackButton"]

    let rightStyle = app.segmentedControls["navRightBarButtonItemStyle"]
    let rightCount = app.segmentedControls["navRightBarButtonItemCount"]

    leftCount.buttons["1"].tap()
    leftStyle.buttons.element(boundBy: 1).tap()
    leftCount.buttons["2"].tap()
    for index: UInt in [3, 2] {
      leftStyle.buttons.element(boundBy: index).tap()
    }

    leftCount.buttons["1"].tap()
    coexistsWithBackButton.tap()
    hidesBackButton.tap()
    hidesBackButton.tap()

    rightCount.buttons["1"].tap()
    rightStyle.buttons.element(boundBy: 1).tap()
    rightCount.buttons["2"].tap()
    for index: UInt in [3, 2] {
      rightStyle.buttons.element(boundBy: index).tap()
    }

    // tool bar
    app.segmentedControls["toolbarStyle"].buttons.element(boundBy: 1).tap()
    app.segmentedControls["toolbarBackground"].buttons.element(boundBy: 1).tap()
    app.segmentedControls["toolbarBackground"].buttons.element(boundBy: 2).tap()

    for index: UInt in [0, 1, 3, 2] {
      app.segmentedControls["toolbarItemStyle"].buttons.element(boundBy: index).tap()
    }

    for index: UInt in [1, 2] {
      app.segmentedControls["toolbarItemLayout"].buttons.element(boundBy: index).tap()
    }

    popCurrentViewController()
  }
  
  func testSwipeToReturn() {
    enterBasicPartIfNeeded()
    let from = app.tables.element.coordinate(withNormalizedOffset: CGVector(dx: 0.01, dy: 0.5))
    let to = from.withOffset(CGVector(dx: 100, dy: 0))
    from.press(forDuration: 1, thenDragTo: to)
    to.press(forDuration: 1, thenDragTo: from)
    sleep(3)
//    popCurrentViewController()
  }
}

