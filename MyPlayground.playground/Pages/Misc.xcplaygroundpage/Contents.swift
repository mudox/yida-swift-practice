//: Playground - noun: a place where people can play

import UIKit

let ids = Locale.availableIdentifiers.filter { (id: String) -> Bool in
  id.hasPrefix("zh")
}
for id in ids.sorted() {
  print(id)
}

print(NSTimeZone.default)
print(NSTimeZone.local)
print(NSTimeZone.system)

let dateString = "2014-6-20 23:11:00"

let formatter = DateFormatter()
formatter.dateFormat = "yy-MM-dd HH:mm:ss"
formatter.locale = Locale(identifier: "zh_Hans_CN")
formatter.timeZone = NSTimeZone.local

let date = formatter.date(from: dateString)!
print(date)
print(formatter.string(from: date))

let calendar = Calendar(identifier: .gregorian)
calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: Date())

