//
//  UIButton+Extension.swift
//  Extension
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 zhuguilei. All rights reserved.
//

import UIKit


public extension UIButton {
    /**
     UIButton图像文字同时存在时---图像相对于文字的位置
     
     - top:    图像在上
     - left:   图像在左
     - right:  图像在右
     - bottom: 图像在下
     */
    enum ButtonImageEdgeInsetsStyle {
        case top, left, right, bottom
    }
    
    
    func imagePosition(at style: ButtonImageEdgeInsetsStyle, space: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-space/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-space/2, right: 0)
            break;
            
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2, bottom: 0, right: space)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2, bottom: 0, right: -space/2)
            break;
            
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-space/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-space/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
            
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+space/2, bottom: 0, right: -labelWidth-space/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-space/2, bottom: 0, right: imageWidth!+space/2)
            break;
            
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}


extension UIButton: MethodProtocol {
  
    fileprivate struct AssociatedKeys {
        static var eventInterval: TimeInterval = 0.5
        static var eventUnavailable: Bool = false
    }
    /// 响应间隔
    var eventInterval: TimeInterval {
        get {
            if let value = objc_getAssociatedObject(self, &AssociatedKeys.eventInterval) as? TimeInterval {
                return value
            } else {
                return 0.5
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventInterval, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 事件不可用
    var eventUnavailable: Bool {
        get {
            if let value = objc_getAssociatedObject(self, &AssociatedKeys.eventUnavailable) as? Bool {
                return value
            } else {
                return false
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.eventUnavailable, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private static var once = true
    static func initializeMethod() {
        if once == false {
            return
        }
        once = false
//        let original = #selector(UIButton.sendAction(_:to:for:))
//        let swizzled = #selector(UIButton.glsendAction(_:to:for:))
//        self.swizzlingForClass(self, originalSelector: original, swizzledSelector: swizzled)
        
        
    }
    
    open override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        DLog("sendAction")
        if self.isKind(of: UIButton.self) && event?.allTouches?.first?.phase == UITouch.Phase.ended {
            if eventUnavailable == false {
                eventUnavailable = true
                perform(#selector(setEventUnavailable), with: nil, afterDelay: eventInterval)
                super.sendAction(action, to: target, for: event)
            }
        } else {
            super.sendAction(action, to: target, for: event)
        }
    }
    
    @objc open func glsendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        
    }
    
    @objc private func setEventUnavailable() {
        eventUnavailable = false
    }
    
    
}

