//
//  GLCurrentView.swift
//  GLMaze
//
//  Created by apple on 2019/12/27.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit

fileprivate let side = 4

class GLCurrentView: UIView {
    
    static var shared: GLCurrentView = {
        let view = GLCurrentView.init(frame: CGRect(x: side, y: side, width: GridW - WallW - 2 * side, height: GridW - WallW - 2 * side))
        view.cornerRadius = view.width * 0.5
        view.backgroundColor = UIColor.green
        return view
    }()

}

class GLStartView: UIView {
    
    static var shared: GLStartView = {
        let view = GLStartView.init(frame: CGRect(x: side, y: side, width: GridW - WallW - 2 * side, height: GridW - WallW - 2 * side))
        view.cornerRadius = view.width * 0.5
        view.backgroundColor = UIColor.cyan
        return view
    }()

}

class GLEndView: UIView {
    
    static var shared: GLEndView = {
        let view = GLEndView.init(frame: CGRect(x: side, y: side, width: GridW - WallW - 2 * side, height: GridW - WallW - 2 * side))
        view.cornerRadius = view.width * 0.5
        view.backgroundColor = UIColor.red
        return view
    }()

}
