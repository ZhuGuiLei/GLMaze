//
//  SwiftString.swift
//  Extension
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 zhuguilei. All rights reserved.
//

import UIKit

public extension String {

    ///  Finds the string between two bookend strings if it can be found.
    ///
    ///  - parameter left:  The left bookend
    ///  - parameter right: The right bookend
    ///
    ///  - returns: The string between the two bookends, or nil if the bookends cannot be found, the bookends are the same or appear contiguously.
    func between(left: String, _ right: String) -> String? {
        if let leftRange = self.range(of: left) {
            if let rightRange = self.range(of: right, options: .backwards) {
                if left != right && leftRange.upperBound < rightRange.lowerBound {
                    let substring = self[leftRange.upperBound ..< rightRange.lowerBound]
                    return String.init(substring)
                }
            }
        }
        return nil
    }
    
    // https://gist.github.com/stevenschobert/540dd33e828461916c11
    ///  转为驼峰格式
    func camelize() -> String {
        var source = self.capitalized.clean(with: "", allOf: "-", "_", " ")
        source = source.reduce("$") { (str1, char) -> String in
            if str1 == "$" {
                return String.init(char).lowercased()
            } else {
                return str1 + "\(char)"
            }
        }
        return source
    }
    /// 首字母大写
    func capitalize() -> String {
        return capitalized
    }
    
   
    
    func chompLeft(prefix: String) -> String {
        if let prefixRange = self.range(of: prefix) {
            if prefixRange.upperBound >= endIndex {
                let substring = self[startIndex ..< prefixRange.lowerBound]
                return String.init(substring)
            } else {
                let substring = self[prefixRange.upperBound ..< endIndex]
                return String.init(substring)
            }
        }
        return self
    }
    
    func chompRight(suffix: String) -> String {
        if let suffixRange = self.range(of: suffix, options: .backwards) {
            if suffixRange.upperBound >= endIndex {
                let substring = self[startIndex ..< suffixRange.lowerBound]
                return String.init(substring)
            } else {
                let substring = self[suffixRange.upperBound ..< endIndex]
                return String.init(substring)
            }
        }
        return self
    }
    
    func collapseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines).filter { $0.isEmpty() }
        return " ".join(components)
    }
    
    
    
    func clean(with: String, allOf: String...) -> String {
        var string = self
        for target in allOf {
            string = string.replacingOccurrences(of: target, with: with)
        }
        return string
    }
    
    func count(substring: String) -> Int {
        return self.components(separatedBy: substring).count - 1
    }
    
    func startsWith(_ prefix: String) -> Bool {
        return hasPrefix(prefix)
    }
    
    func endsWith(_ suffix: String) -> Bool {
        return hasSuffix(suffix)
    }
    
    func ensureLeft(_ prefix: String) -> String {
        if startsWith(prefix) {
            return self
        } else {
            return "\(prefix)\(self)"
        }
    }
    
    func ensureRight(_ suffix: String) -> String {
        if endsWith(suffix) {
            return self
        } else {
            return "\(self)\(suffix)"
        }
    }
    
//    func indexOf(substring: String) -> Int? {
//        if let range = self.range(of: substring) {
//            return range.lowerBound
//        }
//        if let range = rangeOfString(substring) {
//            return startIndex.distanceTo(range.startIndex)
//        }
//        return nil
//    }
    
    func initials() -> String {
        let words = self.components(separatedBy: " ")
        let reduce = words.reduce("") { $0 + $1[0] }
        return reduce
    }
    
    func initialsFirstAndLast() -> String {
        let words = self.components(separatedBy: " ")
        let reduce = words.reduce("") { ($0 == "" ? "" : $0[0..<1]) + $1[0..<1] }
        return reduce
    }
    
    func isAlpha() -> Bool {
        for chr in self {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    
    func isAlphaNumeric() -> Bool {
        return "".join(components(separatedBy: .alphanumerics)).count == 0
    }
    
    func isEmpty() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).count == 0
    }
    
    func isNumeric() -> Bool {
        if let _ =  NumberFormatter.init().number(from: self) {
            return true
        }
        return false
    }
    
    func join(_ elements: [String]) -> String {
        return elements.reduce("$") { ($0 == "$") ? $1 : $0 + self + $1 }
    }
    
    func latinize() -> String {
        return self.folding(options: .diacriticInsensitive, locale: Locale.current)
    }
    
    func lines() -> [String] {
        return self.components(separatedBy: .newlines)
    }
    
    
    
    func pad(n: Int, _ string: String = " ") -> String {
        return "".join([string.times(n), self, string.times(n)])
    }
    
    func padLeft(n: Int, _ string: String = " ") -> String {
        return "".join([string.times(n), self])
    }
    
    func padRight(n: Int, _ string: String = " ") -> String {
        return "".join([self, string.times(n)])
    }
    
    func split(separator: Character) -> [String] {
        return self.split{$0 == separator}.map(String.init)
    }
    
    
    func times(_ n: Int) -> String {
        return (0..<n).reduce("") { (str, i) -> String in
            return str + self
        }
    }
    
    func toFloat() -> Float? {
        if let number = NumberFormatter().number(from: self) {
            return number.floatValue
        }
        return nil
    }
    
    func toInt() -> Int? {
        if let number = NumberFormatter().number(from: self) {
            return number.intValue
        }
        return nil
    }
    
    func toDouble(locale: Locale = Locale.current) -> Double? {
        let nf = NumberFormatter()
        nf.locale = locale
        if let number = nf.number(from: self) {
            return number.doubleValue
        }
        return nil
    }
    
    func toBool() -> Bool? {
        let trimmed = self.trimmed().lowercased()
        if trimmed == "true" || trimmed == "false" {
            return (trimmed as NSString).boolValue
        }
        return nil
    }
    
    
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
