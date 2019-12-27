//
//  GLGridModel.swift
//  GLMaze
//
//  Created by apple on 2019/12/25.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit

let WallColor = UIColor.white(248)
let WallW = 2
let GridW = 20
let MoveSpeed = 0.1

let IsSingleStep = false


class GLGridModel: NSObject {
    var row: Int = 0
    var column: Int = 0
    
    var step: Int = 0
    var showStep = false {
        didSet {
            if showStep {
                let t = CATextLayer.init()
                t.frame = CGRect(x: 0, y: 5, width: GridW, height: 10)
                t.fontSize = 8
                t.foregroundColor = R.color.w666()?.cgColor
                t.alignmentMode = .center
                t.string = "\(step)"
                view.addSublayer(t)
            }
        }
    }
    
    var top: GLWallModel?
    var left: GLWallModel?
    var bottom: GLWallModel = GLWallModel.init()
    var right: GLWallModel = GLWallModel.init()
    
    lazy var canUp: Bool = {
        return top?.isPath == true
    }()
    lazy var canLeft: Bool = {
        return left?.isPath == true
    }()
    lazy var canDown: Bool = {
        return bottom.isPath
    }()
    lazy var canRight: Bool = {
        return right.isPath
    }()
    
    lazy var sideGrids: [GLGridModel] = {
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
    }()
    
    lazy var wallSet: Set<GLWallModel> = {
        var set: Set<GLWallModel> = [bottom, right]
        if top != nil {
            set.insert(top!)
        }
        if left != nil {
            set.insert(left!)
        }
        return set
    }()
    
    lazy var view: CALayer = {
        let view = CALayer.init()
        if top == nil {
            let t = CALayer.init()
            t.frame = CGRect(x: -WallW, y: -WallW, width: GridW+WallW*2, height: WallW)
            t.backgroundColor = WallColor.cgColor
            view.addSublayer(t)
        }
        if left == nil {
            let l = CALayer.init()
            l.frame = CGRect(x: -WallW, y: -WallW, width: WallW, height: GridW+WallW*2)
            l.backgroundColor = WallColor.cgColor
            view.addSublayer(l)
        }
        if !bottom.isPath {
            let b = CALayer.init()
            b.frame = CGRect(x: -WallW, y: GridW, width: GridW+WallW*2, height: WallW)
            b.backgroundColor = WallColor.cgColor
            view.addSublayer(b)
        }
        if !right.isPath {
            let r = CALayer.init()
            r.frame = CGRect(x: GridW, y: -WallW, width: WallW, height: GridW+WallW*2)
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
