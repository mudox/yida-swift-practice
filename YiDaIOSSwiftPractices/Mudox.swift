//
//  Mudox.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 9/9/16.
//  Copyright © 2016 Mudox. All rights reserved.
//

import Foundation
import CocoaLumberjack

struct Mudox {

  static func configureCocoaLumberJack() {
    let formatter = MyLoggerFormatter()

    // Xcode debug area
    let ttyLogger = DDTTYLogger.sharedInstance()
    ttyLogger?.logFormatter = formatter
    DDLog.add(ttyLogger)

    // Log to file
    let logFileManager = DDLogFileManagerDefault(logsDirectory: "/tmp/CocoaLumberJack")
    let fileLogger = DDFileLogger(logFileManager: logFileManager)!
    fileLogger.logFormatter = formatter

    DDLog.add(fileLogger)

    Jack.info("\(ProcessInfo.processInfo.processName) --- \(Date())")
    Jack.error(">> Hi")
    Jack.warn(">> Jack")
    Jack.info(">> at")
    Jack.debug(">> your")
    Jack.verbose(">> service")
  }
}

struct Jack {

  static func error(_ message: String, _ file: String = #file, _ function: String = #function) {
    let fileName = URL(fileURLWithPath: file).lastPathComponent as NSString
    let name = fileName.substring(to: fileName.length - 5)

    DDLogError("\(name) \(function)] \(message)")
  }

  static func warn(_ message: String, _ file: String = #file, _ function: String = #function) {
    let fileName = URL(fileURLWithPath: file).lastPathComponent as NSString
    let name = fileName.substring(to: fileName.length - 5)

    DDLogWarn("\(name) \(function)] \(message)")
  }

  static func info(_ message: String, _ file: String = #file, _ function: String = #function) {
    let fileName = URL(fileURLWithPath: file).lastPathComponent as NSString
    let name = fileName.substring(to: fileName.length - 5)

    DDLogInfo("\(name) \(function)] \(message)")
  }

  static func debug(_ message: String, _ file: String = #file, _ function: String = #function) {
    let fileName = URL(fileURLWithPath: file).lastPathComponent as NSString
    let name = fileName.substring(to: fileName.length - 5)

    DDLogDebug("\(name) \(function)] \(message)")
  }

  static func verbose(_ message: String, _ file: String = #file, _ function: String = #function) {
    let fileName = URL(fileURLWithPath: file).lastPathComponent as NSString
    let name = fileName.substring(to: fileName.length - 5)

    DDLogVerbose("\(name) \(function)] \(message)")
  }
}

class MyLoggerFormatter: NSObject, DDLogFormatter {

  func format(message logMessage: DDLogMessage!) -> String {
    let prefix: String
    switch logMessage.flag {
    case DDLogFlag.error:
      prefix = "E"
    case DDLogFlag.warning:
      prefix = "W"
    case DDLogFlag.info:
      prefix = "I"
    case DDLogFlag.debug:
      prefix = "D"
    case DDLogFlag.verbose:
      prefix = "V"
    default:
      assertionFailure("Invalid DDLogFlag value")
      prefix = "):"
    }

    return "\(prefix)| \(logMessage.message!)"
  }
}
