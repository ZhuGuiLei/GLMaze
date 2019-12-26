//
//  Array+GL.swift
//  GLMaze
//
//  Created by apple on 2019/12/25.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit

extension Array {
    
    /// 从数组中返回一个随机元素
    public var sample: Element? {
        //如果数组为空，则返回nil
        guard count > 0 else { return nil }
        let randomIndex = Int(arc4random_uniform(UInt32(count)))
        return self[randomIndex]
    }
}
