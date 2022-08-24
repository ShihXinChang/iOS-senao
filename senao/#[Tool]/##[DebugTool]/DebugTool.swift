//
//  DebugToo.swift
//  WebSocket-Swift
//
//  Created by 張仕欣 on 2021/10/4.
//

import Foundation

public func debugLog(_ items: Any..., separator: String = " ", terminator: String = "\n", functionName: String = #function, fileName: String = #file, lineNumber: Int = #line, date: Date = Date()) {
#if DEBUG
    let className = (fileName as NSString).lastPathComponent
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    let dateString = formatter.string(from: date) as String
    let output = items.map { "\($0)" }.joined(separator: separator)
    Swift.print("[\(dateString)][\(className)][\(functionName)][#\(lineNumber)] \(output)")
#endif
}
