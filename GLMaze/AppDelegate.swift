//
//  AppDelegate.swift
//  GLMaze
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    
    /// 在应用程序启动后用于自定义的覆盖点。
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIViewController.initializeMethod()
        GLProgressHUD.initConfig()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let vc = GLMazeMainVC.init()
        let nav = GLMainNavController.init(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

    


}

