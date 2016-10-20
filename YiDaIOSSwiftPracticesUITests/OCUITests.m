//
//  OCUITests.m
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 18/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

#import <XCTest/XCTest.h>

static XCUIApplication *app = nil;

@interface OCUITests : XCTestCase

@end

@implementation OCUITests

- (void)setUp {
  [super setUp];

  // Put setup code here. This method is called before the invocation of each test method in the class.

  // In UI tests it is usually best to stop immediately when a failure occurs.
  self.continueAfterFailure = NO;
  // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
  app = [XCUIApplication new];
  [app launch];

  // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)testExample {
  [app.buttons[@"基 础"] tap];
  XCUICoordinate *from = [app.tables.element coordinateWithNormalizedOffset:CGVectorMake(0.01, 0.5)];
  XCUICoordinate *to   = [from coordinateWithOffset: CGVectorMake(200, 0)];
  [from pressForDuration:1 thenDragToCoordinate:to];
}

@end
