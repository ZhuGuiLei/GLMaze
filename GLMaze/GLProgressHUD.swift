//
//  GLProgressHUD.swift
//  GLProgressHUD
//
//  Created by apple on 2019/9/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SVProgressHUD
import MBProgressHUD

/// 提示
class GLProgressHUD: NSObject {

    static var delay: TimeInterval = 1.5
    
    static let fontSize: CGFloat = 15
    
    
    
    class func initConfig() {
                
        // 前景色
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setBackgroundColor(UIColor.black.withAlphaComponent(0.6))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setMaximumDismissTimeInterval(10)
        // 最小尺寸
        SVProgressHUD.setMinimumSize(CGSize(width: 70, height: 70))
        // 圆角
        SVProgressHUD.setCornerRadius(5)
        // 字体大小
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: fontSize))
        // 动画类型
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setRingRadius(25)
        // 用户是否可以做其他操作
        SVProgressHUD.setDefaultMaskType(.none)
        // 提示图片大小
        SVProgressHUD.setImageViewSize(CGSize.init(width: 50, height: 50))
//        SVProgressHUD.setSuccessImage(UIImage.init(asset: Asset.supplierSuccesss) ?? UIImage.init())
//        SVProgressHUD.setErrorImage(UIImage.init(asset: Asset.supplierFail) ?? UIImage.init())
//        SVProgressHUD.setInfoImage(UIImage.init(named: "") ?? UIImage.init())
    }
    
    
    
    /// 显示文字信息
    ///
    /// - Parameter msg: 文字信息
    class func show(msg: String?) {
        self.show(msg: msg, to: nil)
    }
    
    class func show(msg: String?, to view: UIView?) {
        var sup: UIView
        if view != nil {
            sup = view!
        } else {
            sup = UIApplication.shared.keyWindow!
        }
        let hud = MBProgressHUD.showAdded(to: sup, animated: true)
        hud.label.text = msg
        hud.label.numberOfLines = 2
        hud.label.font = UIFont.systemFont(ofSize: fontSize)
        hud.contentColor = UIColor.white
        // 背景颜色
        hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        for view in hud.bezelView.subviews {
            if view.isKind(of: UIVisualEffectView.self) {
                view.isHidden = true
            }
        }
        // 再设置模式
        hud.mode = .customView
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        // 边距
        hud.margin = 16
        // 显示时用户可否进行其他操作，NO可以，YES不可以
        hud.isUserInteractionEnabled = true
        // 1秒之后再消失
        hud.hide(animated: true, afterDelay: delay)
    }
    
    static func show(customView view: UIView) {
        self.show(customView: view, to: nil)
    }
    static func show(customView view: UIView, to supview: UIView?) {
        
        var sup: UIView
        if supview != nil {
            sup = supview!
        } else {
            sup = UIApplication.shared.keyWindow!
        }
        let hud = MBProgressHUD.showAdded(to: sup, animated: true)
        hud.customView = view
        
        hud.contentColor = UIColor.white
        // 背景颜色
        hud.bezelView.backgroundColor = UIColor.black
        // 再设置模式
        hud.mode = .customView
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
        // 边距
        hud.margin = 16
        // 显示时用户可否进行其他操作，NO可以，YES不可以
        hud.isUserInteractionEnabled = false
        // 1秒之后再消失
        hud.hide(animated: true, afterDelay: delay)
    }
    
    /// 修改文字信息
    ///
    /// - Parameter msg: 文字信息
    class func message(_ msg: String?) {
        SVProgressHUD.setStatus(msg)
    }
    
    
    
//MARK: - 菊花
    /// 菊花
    class func showIndicator() {
        SVProgressHUD.show()
    }
    
    /// 菊花+文字
    class func showIndicator(msg: String?) {
        SVProgressHUD.show(withStatus: msg)
    }
    
    
    
//MARK: - dismiss
    class func dismissAll() {
        SVProgressHUD.dismiss()
    }
    
    class func dismissOne() {
        SVProgressHUD.popActivity()
    }
    
    
//MARK: - 进度
    /// 显示进度
    ///
    /// - Parameter progress: 0.0-1.0进度
    class func show(progress: Float) {
        SVProgressHUD.showProgress(progress)
    }
    
    /// 显示进度和文字信息
    ///
    /// - Parameters:
    ///   - progress: 0.0-1.0进度
    ///   - msg: 文字信息
    class func show(progress: Float, msg: String?) {
        SVProgressHUD.showProgress(progress, status: msg)
    }
    
    
    
    
//MARK: - 图片文字
    /// 显示信息图片和文字信息
    ///
    /// - Parameter msg: 文字信息
    class func showInfo(msg: String?) {
        SVProgressHUD.showInfo(withStatus: msg)
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
    /// 显示成功图片和文字信息
    ///
    /// - Parameter msg: 文字信息
    class func showSuccess(msg: String?) {
        SVProgressHUD.showSuccess(withStatus: msg)
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
    /// 显示错误图片和文字信息
    ///
    /// - Parameter msg: 文字信息
    class func showError(msg: String?, isCustom: Bool = true) {
        SVProgressHUD.showError(withStatus: msg)
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
    /// 显示图片和文字信息
    ///
    /// - Parameters:
    ///   - img: 图片
    ///   - msg: 文字信息
    class func show(img: UIImage?, msg: String?) {
        if img == nil {
            GLProgressHUD.show(msg: msg)
        } else {
            SVProgressHUD.show(img!, status: msg)
            SVProgressHUD.dismiss(withDelay: delay)
        }
    }
    
    
    
}
