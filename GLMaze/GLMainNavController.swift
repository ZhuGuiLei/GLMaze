//
//  GLMainNavController.swift
//  GLMaze
//
//  Created by apple on 2019/12/25.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit

class GLMainNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.isTranslucent = false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool)
    {
        viewController.extendedLayoutIncludesOpaqueBars = true
//        viewController.automaticallyAdjustsScrollViewInsets = false
        viewController.edgesForExtendedLayout = UIRectEdge.init()
        
        if self.children.count > 0 {
            // 不是根控制器，隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            
            // 默认的返回按钮
            //            let backItem = UIBarButtonItem.init(image: UIImage(asset: Asset.navBackDark), style: .done, target: self, action: #selector(self.goback))
            //            viewController.navigationItem.leftBarButtonItem = backItem
        }
        super.pushViewController(viewController, animated: animated)
    }
    

}


// MARK: - 状态栏和屏幕旋转
extension GLMainNavController
{
    
    override var childForStatusBarHidden: UIViewController? {
        return self.presentedViewController ?? self.topViewController
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.presentedViewController ?? self.topViewController
    }
    
    /// 状态栏是否隐藏
    override var prefersStatusBarHidden: Bool {
        return self.presentedViewController?.prefersStatusBarHidden ?? self.topViewController?.prefersStatusBarHidden ?? statusBarHidden
    }
    
    /// 状态栏的类型
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.presentedViewController?.preferredStatusBarStyle ?? self.topViewController?.preferredStatusBarStyle ?? glStatusBarStyle
    }
    
    /// 是否支持自动旋转
    override var shouldAutorotate: Bool {
        return self.presentedViewController?.shouldAutorotate ?? self.topViewController?.shouldAutorotate ?? true
    }
    
    /// 支持的旋转方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.presentedViewController?.supportedInterfaceOrientations ?? self.topViewController?.supportedInterfaceOrientations ?? UIInterfaceOrientationMask.portrait
    }
    
}
