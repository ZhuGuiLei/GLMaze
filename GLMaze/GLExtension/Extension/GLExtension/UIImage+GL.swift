//
//  UIImage+MDExtension.swift
//  Extension
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 zhuguilei. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    /// 颜色创建Image
    static func image(color: UIColor) -> UIImage
    {
        return UIImage.image(color: color, size: CGSize.init(width: 1, height: 1))
    }
    
    /// 颜色创建Image
    /// - Parameter size: 尺寸
    static func image(color: UIColor, size: CGSize) -> UIImage
    {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize) -> UIImage? {

        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat) -> UIImage? {
        let reSize = CGSize(width: self.size.width, height: self.size.width * 4 / 5)
        return reSizeImage(reSize: reSize)
    }
}
