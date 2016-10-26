//
//  LyricsParser.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 26/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import Foundation
import AVFoundation

struct LyricsParse {
  
}

let lineRegex = try! NSRegularExpression(pattern: "(\\[\\d\\d:\\d\\d(\\.\\d\\d)?\\]\\s*)+(.*)", options: [])
let timestampRegex = try! NSRegularExpression(pattern: "\\[\\d\\d:\\d\\d(\\.\\d\\d)?\\]", options: []);

let url = URL(fileURLWithPath: "/tmp/media_test/缠绵游戏.lrc")
let lyrics = try! String(contentsOf: url)

var lyricsList = [(timestamp: TimeInterval, text: String)]()

lyrics.enumerateLines { (line, stop) in
  if let match = lineRegex.firstMatch(in: line, options: [], range: NSMakeRange(0, line.characters.count)) {
    // a valid timeline line
    let lyricsText = (line as NSString).substring(with: match.rangeAt(match.numberOfRanges - 1))
    let matches = timestampRegex.matches(in: line, options: [], range: NSMakeRange(0, line.characters.count))
    let timestamps = matches.map { (match: NSTextCheckingResult) -> TimeInterval in
      var stamp = (line as NSString).substring(with: match.range) as NSString
      let minuteText = stamp.substring(with: NSMakeRange(1, 2))
      let secondText = stamp.substring(with: NSMakeRange(4, 2))
      return TimeInterval(minuteText)! * 60 + TimeInterval(secondText)!
    }
    
    for timePoint in timestamps {
      lyricsList.append((timePoint, lyricsText))
    }
  }
}

lyricsList.sort { (lhs: (timestamp: TimeInterval, text: String), rhs: (timestamp: TimeInterval, text: String)) -> Bool in
  return lhs.timestamp < rhs.timestamp
}

for (timestamp, text) in lyricsList {
  print("\(timestamp) - \(text)")
}
