//
//  String+GL.swift
//  Extension
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 zhuguilei. All rights reserved.
//

import Foundation
import UIKit

public extension String
{
    /// 长度
    var length: Int {
        return self.count
    }
    /// 下标[i]
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

public extension String
{
    /// 保留指定小数位，保留数字后的文字
    ///
    /// - Parameter decimal: 保留位数
    /// - Returns: 指定位数的小数字符串
    func toFloatStr(decimal: Int) -> String {
        // "686.076.5kahf.hfo"
        var a = ""
        var b = ""
        for c in self {
            if (c >= "0" && c <= "9") || c == "." {
                a.append(c)
            } else {
                b = self.substring(fromIndex: a.count)
                break
            }
            
        }
        // a = 686.076.5; b = kahf.hfo"
        let arr = a.components(separatedBy: ".")
        if arr.count == 0 {
            return "" + b
        } else if arr.count == 1 {
            return arr[0] + b
        } else {
            var xiaoshu = arr[1]
            if xiaoshu.count > decimal {
                xiaoshu = xiaoshu.substring(toIndex: decimal)
            }
            a = arr[0] + "." + xiaoshu
            return a + b
        }
    }
}

public extension String
{
    func intValue() -> Int {
        let d = Double(self) ?? 0.0
        return Int(d)
    }
    
    func height(font: UIFont, width: CGFloat, minHight: CGFloat = 0) -> CGFloat {
        let labStr = NSString.init(string: self)
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let strSize = labStr.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: font], context: nil).size
        return max(strSize.height, minHight)
    }
    
    func width(font: UIFont, minWidth: CGFloat = 0) -> CGFloat {
        let labStr = NSString.init(string: self)
        let size = CGSize(width: CGFloat(MAXFLOAT), height: font.lineHeight)
        let strSize = labStr.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: font], context: nil).size
        return max(strSize.width, minWidth)
    }

    
}

public extension String
{
    /// 将字符串中数字转换成上标数字 ⁰¹²³⁴⁵⁶⁷⁸⁹
    func toNumSuperscript() -> String {
        let sub = "⁰¹²³⁴⁵⁶⁷⁸⁹"
        let str = "0123456789"
        var tmp = self
        for index in 0..<str.count {
            tmp = tmp.replacingOccurrences(of: str[index], with: sub[index])
        }
        return tmp
        
    }
    
    /// 将字符串中数字转换成下标数字 ₀₁₂₃₄₅₆₇₈₉
    func toNumSubscript() -> String {
        let sub = "₀₁₂₃₄₅₆₇₈₉"
        let str = "0123456789"
        var tmp = self
        for index in 0..<str.count {
            tmp = tmp.replacingOccurrences(of: str[index], with: sub[index])
        }
        return tmp
        
    }
    
    /// 转化电话
    func toHiddenPhone() -> String {
        if self.count < 7 {
            return self
        }
        return self[0..<3] + "*****" + self[self.count-4..<self.count]
    }
    
    /// 转化银行卡号
    func toHiddenAccountNo() -> String {
        if self.count < 8 {
            return self
        }
        return self[0..<4] + " **** **** " + self[self.count-4..<self.count]
    }
    
    
    /// 转为手机格式 return 180-5112-3421
    func toPhoneFormat() -> String
    {
        var tmp = self
        if tmp.count == 11 {
            tmp.insert("-", at: index(startIndex, offsetBy: 7))
            tmp.insert("-", at: index(startIndex, offsetBy: 3))
        }
        return tmp
    }
    
    /// 金额数字添加单位（暂时写了万和亿，有更多的需求请参考写法来自行添加）
    func stringChineseFormat(value: Double) -> String {
        if value / 100000000 >= 1 {
            return String.init(format: "%.0f亿", value / 100000000)
        } else if value / 10000 >= 1 {
            return String.init(format: "%.0f万", value / 10000)
        } else {
            return String.init(format: "%.0f", value)
        }
    }

    
    /// 抹除小数末尾的0
    func removeUnwantedZero() -> String {
        let format = NumberFormatter.init()
        format.numberStyle = .currency
        //如要增加小数点请自行修改为@"###,###,##"
        format.positiveFormat = "###,###"
        /// 自定义前缀
        format.positivePrefix = ""
        /// 自定义后缀
        format.positiveSuffix = ""
        return format.string(from: self.toNumber()) ?? ""
    }
    
    func countNumAndChangeFormat() -> String {
        let format = NumberFormatter.init()
        //如要增加小数点请自行修改为@"###,###,##"
        format.positiveFormat = "###,###,##"
        /// 自定义前缀
        format.positivePrefix = ""
        /// 自定义后缀
        format.positiveSuffix = ""
        return format.string(from: self.toNumber()) ?? ""
        
    }
    
    func toNumber() -> NSNumber {
        let format = NumberFormatter.init()
        format.numberStyle = .currency
        /// 自定义前缀
        format.positivePrefix = ""
        /// 自定义后缀
        format.positiveSuffix = ""
        return format.number(from: self) ?? NSNumber.init(value: 0)
    }
    

    /// 去掉前后空格
    func trimmedString() -> String
    {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }


}


public extension String
{
    
    /** 检查是否为空 true:不是空; false:空 */
    func isValid() -> Bool
    {
        return self.trimmedString().isEmpty == false
    }
    
    /// 有效的电话号码
    func isValidTelNum(showAlert: Bool) -> Bool {
        var msg = ""
        if self.count == 0 {
            msg = "号码不能为空!"
        } else {
            let telNum = "^1\\d{10}$"
            let predicate = NSPredicate.init(format: "SELF MATCHES %@", telNum)
            let isMatch = predicate.evaluate(with: self)
            
            if !isMatch {
                msg = "请输入正确的手机号码!"
            }
        }
        
        if msg.isEmpty {
            return true
        } else {
            if showAlert {
                let vc = UIAlertController.init(title: "提示", message: msg, preferredStyle: .alert)
                let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
                vc.addAction(action)
                UIViewController.topVC().present(vc, animated: true, completion: nil)
            }
            return false
        }
    }
    
    /// 是否是有效的身份证
    func isValidIdCard() -> Bool {
        if self.count == 15 {
            return isValidIdentifyFifteen()
        } else {
            return isValidIdentifyEighteen()
        }
    }
    
    private func isValidIdentifyFifteen() -> Bool {
        let idCard = "^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", idCard)
        return predicate.evaluate(with: self)
    }
    
    private func isValidIdentifyEighteen() -> Bool {
        if self.count != 18 {
            return false
        }
        
        let scan = Scanner.init(string: self.substring(toIndex: 17))
        var val = 0
        let isNum = scan.scanInt(&val) && scan.isAtEnd
        if !isNum {
            return false
        }
        
        let codeArray = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
        let checkCodeDic = ["0": "1", "1": "0", "2": "X", "3": "9", "4": "8", "5": "7", "6": "6", "7": "5", "8": "4", "9": "3", "10": "2", ]
        
        var sumValue = 0
        for i in 0..<17 {
            sumValue += self[i].intValue() * codeArray[i]
        }
        let last = checkCodeDic["\(sumValue%11)"]
        return last == self.substring(fromIndex: 17)
    }
    
    /// 有效的银行卡号
    func isValidBankCardNumber() -> Bool {
        let bankCard = "^(\\d{16}|\\d{19})$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", bankCard)
        return predicate.evaluate(with: self)
    }
    
    /// 有效的邮箱
    func isValidEmail() -> Bool {
        let email = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", email)
        return predicate.evaluate(with: self)
    }
    
    /// 有效的url
    func isValidUrl() -> Bool {
        let url = "^(https?://[\\S]*)$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", url)
        return predicate.evaluate(with: self)
    }
    
    /// 有效的验证码(根据自家的验证码位数进行修改)
    func isValidVerifyCode() -> Bool {
        let code = "^[0-9]{4,6}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", code)
        return predicate.evaluate(with: self)
    }
    
    /// 有效的真实姓名
    func isValidRealName() -> Bool {
        let realName = "^[\u{4e00}-\u{9fa5}]{2,8}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", realName)
        return predicate.evaluate(with: self)
    }
    
    /// 有效的昵称
    func validateNickName() -> Bool {
        let nickName = "^[A-Za-z0-9\u{4e00}-\u{9fa5}]{1,24}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", nickName)
        return predicate.evaluate(with: self)
    }
    
    
    /// 是否只有中文（不能包含空格回车）
    func isValidChinese() -> Bool {
        let chinese = "^[\u{4e00}-\u{9fa5}]{0,}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", chinese)
        return predicate.evaluate(with: self)
    }

    /// 限制只能输入数字
    func isValidNumber() -> Bool {
        let number = "^[0-9]{0,}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", number)
        return predicate.evaluate(with: self)
    }
    /// 限制只能输入数字(包含两位小数)
    func isValidDecimalNumber() -> Bool {
        let number = "([1-9][0-9]*)+(\\.[0-9]{0,2})?$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", number)
        return predicate.evaluate(with: self)
    }
    
    /// 有效的字母数字密码
    func isValidSafePassword() -> Bool {
        //检测用户输入密码是否以字母开头，6-16位数字和字母组合
        let safePassword = "^[a-zA-Z][a-zA-Z0-9_]{5,15}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", safePassword)
        return predicate.evaluate(with: self)
    }



}
