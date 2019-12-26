//
//  UIView+Tool.swift
//  Extension
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 zhuguilei. All rights reserved.
//

import UIKit

public extension UIView
{
    /// 所在的控制器
    func viewController() -> UIViewController? {
        
        for view in sequence(first: self.superview, next: {$0?.superview}){
            
            if let responder = view?.next {
                
                if responder.isKind(of: UIViewController.self){
                    
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    
    /// 转化一个矩形到另一个视图上
    ///
    /// - Parameters:
    ///   - rect: 尺寸
    ///   - view: 目标视图
    /// - Returns: 矩形在目标视图上的位置
    func convert(rect: CGRect, toViewOrWindow view: UIView?) -> CGRect {
        if view == nil {
            if let window = self as? UIWindow {
                return window.convert(rect, to: nil)
            } else {
                return self.convert(rect, to: nil)
            }
        }
        
        let from = self as? UIWindow ?? self.window
        let to = view as? UIWindow ?? view?.window
        if from == nil || to == nil {
            return self.convert(rect, to: view)
        } else if from == to {
            return self.convert(rect, to: view)
        } else {
            var tmp: CGRect = rect
            tmp = self.convert(tmp, to: from)
            tmp = to!.convert(tmp, from: from)
            tmp = view!.convert(tmp, from: to)
            return tmp
        }
    }
}

public extension UIView
{
    /// 移除所有子视图
    func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    /// 移除所有手势
    func removeAllGestureRecognizer() {
        for gr in self.gestureRecognizers ?? [] {
            self.removeGestureRecognizer(gr)
        }
    }
}
