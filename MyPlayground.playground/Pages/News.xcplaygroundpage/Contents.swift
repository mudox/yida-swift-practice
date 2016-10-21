//: [Previous](@previous)

import Foundation

let url = Bundle.main.url(forResource: "News", withExtension: "json")!
let data = try! Data(contentsOf: url)
let list = try! JSONSerialization.jsonObject(with: data, options: [])
print(list)


//: [Next](@next)
