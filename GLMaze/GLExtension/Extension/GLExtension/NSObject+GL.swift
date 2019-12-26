//
//  NSObject+GL.swift
//  Extension
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 zhuguilei. All rights reserved.
//

import UIKit

public extension NSObject
{
    /// 拦截实例方法
    static func exchangeInstanceMethod(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        
        guard let originalMethod = class_getInstanceMethod(forClass, originalSelector) else { return }
        guard let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) else { return }
        
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    /// 拦截类方法
    static func exchangeClassMethod(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        
        guard let originalMethod = class_getClassMethod(forClass, originalSelector) else { return }
        guard let swizzledMethod = class_getClassMethod(forClass, swizzledSelector) else { return }
        
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    /// 覆盖实例方法
    static func overrideInstanceMethod(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        
        guard let originalMethod = class_getInstanceMethod(forClass, originalSelector) else { return }
        guard let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) else { return }
        
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            guard let imp = class_getMethodImplementation(forClass, swizzledSelector) else { return }
            method_setImplementation(originalMethod, imp)
        }
    }
    
    
    /// 覆盖类方法
    static func overrideClassMethod(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        
        guard let originalMethod = class_getClassMethod(forClass, originalSelector) else { return }
        guard let swizzledMethod = class_getClassMethod(forClass, swizzledSelector) else { return }
        
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            guard let imp = class_getMethodImplementation(forClass, swizzledSelector) else { return }
            method_setImplementation(originalMethod, imp)
        }
    }
}

