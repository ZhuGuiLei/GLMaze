//
//  UIViewController+GL.swift
//  Extension
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 zhuguilei. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    /// 顶部控制器
    static func topVC() -> UIViewController {
        if ((UIApplication.shared.keyWindow?.rootViewController) == nil) {
            print("topVC是nil")
            return UIViewController.init()
        }
        var vc = self.topViewController(UIApplication.shared.keyWindow?.rootViewController)
        while (vc?.presentedViewController != nil) {
            vc = self.topViewController((vc?.presentedViewController)!)
        }
        if (vc == nil) {
            print("topVC是nil")
        }
        return vc ?? UIViewController.init()
    }
    
    private static func topViewController(_ vc: UIViewController?) -> UIViewController? {
        
        if vc == nil {
            return nil
        }
        
        if vc!.isKind(of: UINavigationController.self) {
            return self.topViewController((vc as! UINavigationController).topViewController)
        } else if vc!.isKind(of: UITabBarController.self) {
            return self.topViewController((vc as! UITabBarController).selectedViewController)
        } else {
            return vc
        }
    }
    
    
    
}
