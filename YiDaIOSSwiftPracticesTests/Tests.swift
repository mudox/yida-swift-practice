//
//  YiDaIOSSwiftPracticesTests.swift
//  YiDaIOSSwiftPracticesTests
//
//  Created by Mudox on 9/8/16.
//  Copyright © 2016 Mudox. All rights reserved.
//

import XCTest
@testable import YiDaIOSSwiftPractices

class DataTests: XCTestCase {

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testNews() {
    let newsList1 = loadNewsUsingSwiftyJSON()
    var log = newsList1.reduce("") { (lines, newsItem) -> String in
      
      return lines + "\n\(newsItem.dateString) (\(newsItem.timePassedDescription))"
    }
    Jack.debug(log)
    
    let newsList2 = loadNewsUsingGloss()
    log = newsList2.reduce("") { (lines, newsItem) -> String in
      
      return lines + "\n\(newsItem.dateString) (\(newsItem.timePassedDescription))"
    }
    Jack.debug(log)
  }
  
  func testMenu() {
    let menu = Menu.shared
    Jack.debug(menu.basicPart[4].headerText)
    XCTAssert(menu.basicPart[4].items[0].presenting != nil)
  }

  func testSwiftyJSONPerformance() {
    self.measure {
      for _ in 0..<100 {
        let _ = loadNewsUsingSwiftyJSON()
      }
    }
  }
  
  func testGlossPerformance() {
    self.measure {
      for _ in 0..<100 {
        let _ = loadNewsUsingGloss()
      }
    }
  }
}
