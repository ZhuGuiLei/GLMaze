//
//  UIViewController+ev.swift
//  Extension
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 zhuguilei. All rights reserved.
//

import Foundation
import UIKit

/// 方法替换
extension UIViewController: MethodProtocol {
      
    private static var once = true
    static func initializeMethod() {
        if once == false {
            return
        }
        once = false
        var original = #selector(UIViewController.present(_:animated:completion:))
        var swizzled = #selector(UIViewController.evpresent(_:animated:completion:))
        self.exchangeInstanceMethod(self, originalSelector: original, swizzledSelector: swizzled)
        
        original = #selector(UIViewController.viewDidAppear(_:))
        swizzled = #selector(UIViewController.evviewDidAppear(_:))
        self.exchangeInstanceMethod(self, originalSelector: original, swizzledSelector: swizzled)
        
        original = #selector(UIViewController.viewWillDisappear(_:))
        swizzled = #selector(UIViewController.evviewWillDisappear(_:))
        self.exchangeInstanceMethod(self, originalSelector: original, swizzledSelector: swizzled)
        
        original = #selector(UIViewController.viewDidDisappear(_:))
        swizzled = #selector(UIViewController.evviewDidDisappear(_:))
        self.exchangeInstanceMethod(self, originalSelector: original, swizzledSelector: swizzled)
        
    }

    
    @objc private func evpresent(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        print("evpresent")
        if viewControllerToPresent.modalPresentationStyle == .overFullScreen || viewControllerToPresent.modalPresentationStyle == .overCurrentContext {
            if let nav = viewControllerToPresent as? UINavigationController {
                nav.glStatusBarStyle = self.preferredStatusBarStyle
                if let vc = nav.topViewController {
                    vc.glStatusBarStyle = self.preferredStatusBarStyle
                }
            } else  {
                viewControllerToPresent.glStatusBarStyle = self.preferredStatusBarStyle
            }
            self.definesPresentationContext = true
        } else {
            if #available(iOS 13.0, *) {
                if viewControllerToPresent.modalPresentationStyle != .overFullScreen && viewControllerToPresent.modalPresentationStyle != .overCurrentContext {
                    viewControllerToPresent.modalPresentationStyle = .fullScreen
                }
            }
        }
        self.evpresent(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    
    @objc func evviewDidAppear(_ animated: Bool) {
        self.evviewDidAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    @objc func evviewWillDisappear(_ animated: Bool) {
        self.evviewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    @objc func evviewDidDisappear(_ animated: Bool) {
        self.evviewDidDisappear(animated)
        UIViewController.topVC().setNeedsStatusBarAppearanceUpdate()
    }
    
}


public extension UIViewController
{
    fileprivate struct AssociatedKeys {
        static var statusBarHidden: Bool = false
        static var glStatusBarStyle: UIStatusBarStyle = UIStatusBarStyle.default
    }
    
    
    
    var statusBarHidden: Bool {
        get {
            if let value = objc_getAssociatedObject(self, &AssociatedKeys.statusBarHidden) as? Bool {
                return value
            } else {
                return false
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.statusBarHidden, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    /// 状态栏类型
    var glStatusBarStyle: UIStatusBarStyle {
        get {
            if let value = objc_getAssociatedObject(self, &AssociatedKeys.glStatusBarStyle) as? UIStatusBarStyle {
                return value
            } else {
                return .default
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.glStatusBarStyle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            setNeedsStatusBarAppearanceUpdate()
        }
    }
}


