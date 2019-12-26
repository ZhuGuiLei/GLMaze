//
//  UIColor+GL.swift
//  Extension
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 zhuguilei. All rights reserved.
//

import Foundation
import UIKit


public extension UIColor {
    
    /// 颜色黑-白
    ///
    /// - Parameter white: 0:黑, 255:白
    /// - Returns: color
    static func white(_ white: UInt8) -> UIColor {
        return rgb(white, white, white)
    }
    
    /// 快捷颜色
    ///
    /// - Parameters:
    ///   - red: 0-255
    ///   - green: 0-255
    ///   - blue: 0-255
    /// - Returns: color
    static func rgb(_ red: UInt8, _ green: UInt8, _ blue: UInt8) -> UIColor {
        return rgba(red, green, blue, 1)
    }
    
    /// 快捷颜色
    ///
    /// - Parameters:
    ///   - red: 0-255
    ///   - green: 0-255
    ///   - blue: 0-255
    ///   - alpha: 0.0-1.0
    /// - Returns: color
    static func rgba(_ red: UInt8, _ green: UInt8, _ blue: UInt8, _ alpha: CGFloat) -> UIColor {
        return UIColor.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    

    /// 随即色
    ///
    /// - Returns: color
    static func randomColor() -> UIColor {
        return UIColor.rgb(UInt8(Rand(255)), UInt8(Rand(255)), UInt8(Rand(255)))
    }
    
    private static func Rand(_ x: UInt32) -> UInt32 {
        return arc4random_uniform(x)
    }
    
}


/// 梯度
///
/// - level: 水平
/// - vertical: 竖直
public enum GradientChangeDirection {
    /// 水平
    case level
    /// 竖直
    case vertical
    case downDiagonalLine
    case upwardDiagonalLine
}

public extension UIColor
{
    
    /// 梯度色
    ///
    /// - Parameters:
    ///   - size: 尺寸，不可为zero
    ///   - direction: 渐变方向，level，vertical，downDiagonalLine，upwardDiagonalLine
    ///   - startColor: 开始颜色
    ///   - endColor: 结束颜色
    /// - Returns: 指定尺寸的渐变色
    static func gradientColor(size: CGSize, direction: GradientChangeDirection, startColor: UIColor, endColor: UIColor) -> UIColor
    {
        if size == .zero {
            return startColor
        }
        let gradientColors = [startColor.cgColor, endColor.cgColor]
        
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        gradientLayer.colors = gradientColors
        
        var startPoint = CGPoint.zero
        if direction == .upwardDiagonalLine {
            startPoint = CGPoint.init(x: 0.0, y: 1.0)
        }
        gradientLayer.startPoint = startPoint
        
        var endPoint = CGPoint.zero
        switch direction {
        case .level:
            endPoint = CGPoint.init(x: 1.0, y: 0.0)
        case .vertical:
            endPoint = CGPoint.init(x: 0.0, y: 1.0)
        case .downDiagonalLine:
            endPoint = CGPoint.init(x: 1.0, y: 1.0)
        case .upwardDiagonalLine:
            endPoint = CGPoint.init(x: 1.0, y: 0.0)
        }
        gradientLayer.endPoint = endPoint
        
        
        UIGraphicsBeginImageContext(gradientLayer.frame.size);
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext();
        return UIColor.init(patternImage: image)
    }
}



