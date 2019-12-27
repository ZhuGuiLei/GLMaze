//
//  GLCurrentView.swift
//  GLMaze
//
//  Created by apple on 2019/12/27.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit

class GLCurrentView: UIView {
    
    static var shared: GLCurrentView = {
        let view = GLCurrentView.init(frame: CGRect(x: 0, y: 0, width: GridW - WallW, height: GridW - WallW))
        view.backgroundColor = UIColor.green
        return view
    }()

}

class GLStartView: UIView {
    
    static var shared: GLStartView = {
        let view = GLStartView.init(frame: CGRect(x: 0, y: 0, width: GridW - WallW, height: GridW - WallW))
        view.backgroundColor = UIColor.cyan
        return view
    }()

}

class GLEndView: UIView {
    
    static var shared: GLEndView = {
        let view = GLEndView.init(frame: CGRect(x: 0, y: 0, width: GridW - WallW, height: GridW - WallW))
        view.backgroundColor = UIColor.red
        return view
    }()

}
