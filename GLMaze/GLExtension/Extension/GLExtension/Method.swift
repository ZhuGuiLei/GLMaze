//
//  Method.swift
//  Extension
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 zhuguilei. All rights reserved.
//

import UIKit

protocol MethodProtocol: NSObjectProtocol {
    static func initializeMethod()
}


public class Method {
    // 获取到所有的类，遍历类，遵守协议MethodProtocol的类执行initializeMethod方法
    static func performOnce() {
        let count = Int(objc_getClassList(nil, 0))
        let classes = UnsafeMutablePointer<AnyClass?>.allocate(capacity: count)
        let autoreleaseClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(classes)
        objc_getClassList(autoreleaseClasses, Int32(count))
        for index in 0..<count {
            (classes[index] as? MethodProtocol.Type)?.initializeMethod()
        }
        classes.deallocate()
    }
}


public extension UIApplication {
    private static let runOnce: Void = {
//        Method.performOnce()
        UIViewController.initializeMethod()
        UIButton.initializeMethod()
    }()

    private static var once = true

    override var next: UIResponder? {
        if UIApplication.once {
            UIApplication.once = false
            UIApplication.runOnce
        }
        return super.next
    }
}
