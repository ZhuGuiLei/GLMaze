//
//  GLGridModel.swift
//  GLMaze
//
//  Created by apple on 2019/12/25.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit

let WallColor = UIColor.white(138)
let WallW = 2
let GridW = 20
let MoveSpeed = 0.1

class GLGridModel: NSObject {
    var row: Int = 0
    var column: Int = 0
    
    var top: GLWallModel?
    var left: GLWallModel?
    var bottom: GLWallModel = GLWallModel.init()
    var right: GLWallModel = GLWallModel.init()
    
    var canUp: Bool {
        return top?.isPath == true
    }
    var canLeft: Bool {
        return left?.isPath == true
    }
    var canDown: Bool {
        return bottom.isPath
    }
    var canRight: Bool {
        return right.isPath
    }
    
    var sideGrids: [GLGridModel] {
        var sides = [GLGridModel]()
        if canUp {
            sides.append(top!.gridMain)
        }
        if canLeft {
            sides.append(left!.gridMain)
        }
        if canDown {
            sides.append(bottom.gridNext!)
        }
        if canRight {
            sides.append(right.gridNext!)
        }
        return sides
    }
    
    var wallSet: Set<GLWallModel> {
        var set: Set<GLWallModel> = [bottom, right]
        if top != nil {
            set.insert(top!)
        }
        if left != nil {
            set.insert(left!)
        }
        return set
    }
    
    lazy var view: CALayer = {
        let view = CALayer.init()
        if top == nil {
            let t = CALayer.init()
            t.frame = CGRect(x: -WallW, y: -WallW, width: GridW+WallW, height: WallW)
            t.backgroundColor = WallColor.cgColor
            view.addSublayer(t)
        }
        if left == nil {
            let l = CALayer.init()
            l.frame = CGRect(x: -WallW, y: -WallW, width: WallW, height: GridW+WallW)
            l.backgroundColor = WallColor.cgColor
            view.addSublayer(l)
        }
        if !bottom.isPath {
            let b = CALayer.init()
            b.frame = CGRect(x: -WallW, y: GridW-WallW, width: GridW+WallW, height: WallW)
            b.backgroundColor = WallColor.cgColor
            view.addSublayer(b)
        }
        if !right.isPath {
            let r = CALayer.init()
            r.frame = CGRect(x: GridW-WallW, y: -WallW, width: WallW, height: GridW+WallW)
            r.backgroundColor = WallColor.cgColor
            view.addSublayer(r)
        }
        
        return view
    }()
    
    init(row: Int, column: Int) {
        super.init()
        
        self.row = row
        self.column = column
        
        bottom.gridMain = self
        right.gridMain = self
    }
}
