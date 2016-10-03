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
    let ttyLogger = DDTTYLogger.sharedInstance()!
    ttyLogger.logFormatter = formatter
    DDLog.add(ttyLogger)

    // Log to file
    let logFileManager = DDLogFileManagerDefault(logsDirectory: "/tmp/CocoaLumberJack")
    let fileLogger = DDFileLogger(logFileManager: logFileManager)!
    fileLogger.logFormatter = formatter

    DDLog.add(fileLogger)

    Jack.info("\(ProcessInfo.processInfo.processName) --- \(Date())")
    Jack.error("Hi")
    Jack.warn("Jack")
    Jack.info("at")
    Jack.debug("your")
    Jack.verbose("service\n\n\n")
  }
}

struct Jack {

  enum Prefix {
    case appName, fileFunctionName
  }

  static let appName = ProcessInfo.processInfo.processName

  static let indentRegex = try! NSRegularExpression(pattern: "\\n[^\\n ]{2}", options: [])

  private static func logFor(_ message: String, _ prefix: Prefix = .fileFunctionName,
                             _ file: String = #file, _ function: String = #function) -> String {
    // prefix uncontinued successive lines witb `>> `
    var log = indentRegex.stringByReplacingMatches(
      in: message, options: [], range: NSMakeRange(0, (message as NSString).length), withTemplate: "\n>> ")

    if prefix == .fileFunctionName {
      let fileName = URL(fileURLWithPath: file).lastPathComponent as NSString
      let name = fileName.substring(to: fileName.length - 5)

      log = "\(name) \(function)]" + log
    } else {
      log = "\(appName):" + log
    }

    return log
  }

  static func error(_ message: String, withPrefix prefix: Prefix = .fileFunctionName,
                    _ file: String = #file, _ function: String = #function) {

    DDLogError(logFor(message, prefix, file, function))
  }

  static func warn(_ message: String, withPrefix prefix: Prefix = .fileFunctionName,
                    _ file: String = #file, _ function: String = #function) {

    DDLogWarn(logFor(message, prefix, file, function))
  }

  static func info(_ message: String, withPrefix prefix: Prefix = .fileFunctionName,
                    _ file: String = #file, _ function: String = #function) {

    DDLogInfo(logFor(message, prefix, file, function))
  }

  static func debug(_ message: String, withPrefix prefix: Prefix = .fileFunctionName,
                    _ file: String = #file, _ function: String = #function) {
    DDLogDebug(logFor(message, prefix, file, function))
  }

  static func verbose(_ message: String, withPrefix prefix: Prefix = .fileFunctionName,
                    _ file: String = #file, _ function: String = #function) {
    DDLogVerbose(logFor(message, prefix, file, function))
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
