//
//  GLMainViewController.swift
//  GLMaze
//
//  Created by apple on 2019/12/25.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit

// MARK: - 基础vc
class GLMainViewController: UIViewController {

    deinit {
        print("deinit:\(self)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.clipsToBounds = true
    }
    
}


        
// MARK: - 状态栏和屏幕旋转
extension GLMainViewController
{
    override var childForStatusBarHidden: UIViewController? {
        return self.presentedViewController
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.presentedViewController
    }
    /// 状态栏是否隐藏
    override var prefersStatusBarHidden: Bool
    {
        return self.presentedViewController?.prefersStatusBarHidden ?? statusBarHidden
    }
    
    /// 状态栏动画
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation
    {
        return self.presentedViewController?.preferredStatusBarUpdateAnimation ?? .none
    }
    
    /// 状态栏的类型
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return self.presentedViewController?.preferredStatusBarStyle ?? glStatusBarStyle
    }
    
    /// 是否支持自动旋转
    override var shouldAutorotate: Bool {
        return self.presentedViewController?.shouldAutorotate ?? true
    }
    
    /// 支持的旋转方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.presentedViewController?.supportedInterfaceOrientations ?? .portrait
    }
}
