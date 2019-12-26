//
//  EVUtils.swift
//  Extension
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 zhuguilei. All rights reserved.
//

import UIKit
import AdSupport

/// 屏幕高
public let Hi: CGFloat = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
/// 屏幕宽
public let Wi: CGFloat = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
/// 状态栏高
public let Hs: CGFloat = UIApplication.shared.statusBarFrame.size.height
/// 导航栏高
public let Hn: CGFloat = (Hs + 44)
/// 下巴高
public var Hb: CGFloat {
    get {
        if #available(iOS 11.0, *) {
            return GLWindow?.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }
}
/// tabbar高
public let Htb: CGFloat = (Hb + 49)

/// 左右安全距离
public let GLSafeSide = CGFloat(isIphoneX ? 20 : 16)
/// 分辨率
public let GLScreenScale = (UIScreen.main.scale)




/// 当前AppDelegate
public let GLAppDelegate: UIApplicationDelegate? = UIApplication.shared.delegate

/// 主窗口
public let GLWindow: UIWindow? = UIApplication.shared.keyWindow


/// 类型别名
public typealias BaseBlock = (() -> Void)
public typealias BaseTypeBlock<T: NSObject> = ((T) -> Void)



//iPhoneX系列
public var isIphoneX: Bool {
    get {
        
        if #available(iOS 11.0, *) {
            if let bottom = GLWindow?.safeAreaInsets.bottom , bottom > 0 {
                return true
            }
        } else {
            DLog("iOS11 之前的版本")
        }
        return false
    }
}

/// 隐藏键盘
public func KeyboardHide() {
    UIApplication.shared.keyWindow?.endEditing(true)
}


public struct AppInfo {
    
    static let infoDictionary = Bundle.main.infoDictionary
    
    /// App 名称
    static let appDisplayName: String = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    
    /// Bundle Identifier
    static let bundleIdentifier: String = Bundle.main.bundleIdentifier!
    
    /// App 版本号
    static let appVersion: String = Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String
    
    /// Bulid 版本号
    static let buildVersion : String = Bundle.main.infoDictionary! ["CFBundleVersion"] as! String
    
    
    /// 设备 udid
    static let identifierNumber = UIDevice.current.identifierForVendor?.uuidString
    
    /// 设备名称
    static let systemName = UIDevice.current.systemName
    
    /// 设备版本
    static let systemVersion:String = UIDevice.current.systemVersion
    
    /// 设备型号
    static let model = UIDevice.current.model
    
    /// 设备区域化型号
    static let localizedModel = UIDevice.current.localizedModel
    
    /// 设备语言
    static let localLanguage = (UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray).object(at: 0)
    
    /// 广告标识
    static let identifierForAdvertising = ASIdentifierManager.shared().advertisingIdentifier.uuidString
    
    /// App 版本号
    static var appIntVersion: Int {
        let arr = appVersion.components(separatedBy: ".")
        var v = 0
        for str in arr {
            v = v * 100 + (Int(str) ?? 0)
        }
        return v
    }
}


/// 打电话
///
/// - Parameter phone: 电话号码
public func Call(phone: String?) {
    if phone == nil  {
        DLog("号码为空")
        return
    }
    if phone!.count <= 2 {
        DLog("号码为空\(phone ?? "")")
        return
    }
    DLog("call:" + phone!)
    let phone = "telprompt://" + phone!
    if UIApplication.shared.canOpenURL(URL(string: phone)!) {
        UIApplication.shared.openURL(URL(string: phone)!)
    }
    
}

/// 当前版本是否首次启动
public func isFirstLaunch() -> Bool
{
    guard let info = Bundle.main.infoDictionary else {
        return false
    }
    guard let current = info["CFBundleShortVersionString"] as? String else {
        return false
    }
    guard let old = UserDefaults.standard.object(forKey: "AppVersion") as? String else {
        UserDefaults.standard.set(current, forKey: "AppVersion")
        return true
    }
    let cArr = current.components(separatedBy: ".")
    var cv = 0
    for str in cArr {
        cv = cv * 100 + (Int(str) ?? 0)
    }
    
    let oArr = old.components(separatedBy: ".")
    var ov = 0
    for str in oArr {
        ov = ov * 100 + (Int(str) ?? 0)
    }
    
    if cv > ov {
        UserDefaults.standard.set(current, forKey: "AppVersion")
        return true
    } else {
        return false
    }
    
}


#if DEBUG

public func DLog(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    print(items, separator: separator, terminator: terminator)
}

#else

public func DLog(_ items: Any..., separator: String = " ", terminator: String = "\n") {}

#endif


