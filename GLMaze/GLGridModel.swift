//
//  GLGridModel.swift
//  GLMaze
//
//  Created by apple on 2019/12/25.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit

let wallColor = UIColor.white(238)
let wallWidth = 2

class GLGridModel: NSObject {
    var row: Int = 0
    var column: Int = 0
    
    var top: GLWallModel?
    var left: GLWallModel?
    var bottom: GLWallModel!
    var right: GLWallModel!
    
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
    
    lazy var view: UIView = {
        let view = UIView.init()
        if top == nil {
            let t = UIView.init()
            t.backgroundColor = wallColor
            view.addSubview(t)
            t.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalToSuperview().offset(-wallWidth)
                make.height.equalTo(wallWidth)
            }
        }
        if left == nil {
            let l = UIView.init()
            l.backgroundColor = wallColor
            view.addSubview(l)
            l.snp.makeConstraints { (make) in
                make.bottom.equalToSuperview()
                make.left.top.equalToSuperview().offset(-wallWidth)
                make.width.equalTo(wallWidth)
            }
        }
        if !bottom.isPath {
            let b = UIView.init()
            b.backgroundColor = wallColor
            view.addSubview(b)
            b.snp.makeConstraints { (make) in
                make.left.bottom.right.equalToSuperview()
                make.height.equalTo(wallWidth)
            }
        }
        if !right.isPath {
            let r = UIView.init()
            r.backgroundColor = wallColor
            view.addSubview(r)
            r.snp.makeConstraints { (make) in
                make.right.bottom.equalToSuperview()
                make.top.equalToSuperview().offset(-wallWidth)
                make.width.equalTo(wallWidth)
            }
        }
        
        return view
    }()
    
    init(row: Int, column: Int) {
        super.init()
        
        self.row = row
        self.column = column
        
        bottom = GLWallModel.init()
        bottom.gridMain = self
        right = GLWallModel.init()
        right.gridMain = self
    }
}
