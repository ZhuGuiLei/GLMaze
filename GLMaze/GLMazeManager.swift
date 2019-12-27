//
//  GLMazeManager.swift
//  GLMaze
//
//  Created by apple on 2019/12/26.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit

class GLMazeManager: NSObject {

    private static var stop = false
    
    static func setStop() {
        stop = true
    }
    
    static func createMazeDataAndPath(row: Int, column: Int, completion: (() -> Void)? ) -> [[GLGridModel]] {
        let gridModels = createMazeData(row: row, column: column)
        
        createPath(gridModels: gridModels, completion: completion)
        
        return gridModels
    }
    
    /// 生成迷宫数据
    static func createMazeData(row: Int, column: Int) -> [[GLGridModel]] {
        
        var gridModels = [[GLGridModel]]()
        for col in 0..<column {
            var arr  = [GLGridModel]()
            for r in 0..<row {
                let model = GLGridModel.init(row: r, column: col)
                if r > 0 {
                    model.left = arr[r-1].right
                    model.left?.gridNext = model
                }
                if col > 0 {
                    model.top = gridModels[col-1][r].bottom
                    model.top?.gridNext = model
                }
                arr.append(model)
            }
            gridModels.append(arr)
        }
        return gridModels
    }
    
    /// 生成路径
    static func createPath(gridModels: [[GLGridModel]], completion: (() -> Void)?) {
        stop = false
        
        DispatchQueue.global().async {
            
            let row = gridModels.first!.count
            let column = gridModels.count
            
            let grid = gridModels.last!.last!// [0][0]
            var oldGrid: Set<GLGridModel> = [grid]
            var oldWall: Set<GLWallModel> = []
            for grid in oldGrid {
                oldWall = oldWall.union(grid.wallSet)
            }
            
            while oldGrid.count != row * column {
                
                if stop {
                    stop = false
                    break
                }
                guard let wall = oldWall.first else {
                    break
                }
                if let next = wall.gridNext {
                    if oldGrid.contains(next) {
                        if oldGrid.contains(wall.gridMain) {
                            oldWall.remove(wall)
                        } else {
                            wall.isPath = true
                            oldGrid.insert(wall.gridMain)
                            oldWall = oldWall.union(wall.gridMain.wallSet)
                        }
                    } else {
                        wall.isPath = true
                        oldGrid.insert(next)
                        oldWall = oldWall.union(next.wallSet)
                    }
                }
                oldWall.remove(wall)
            }
            DispatchQueue.main.async {
                completion?()
            }
        }
        
    }
    /// 绘制
    static func drawMaze(gridModels: [[GLGridModel]], toView view: UIView) {
        
        let maze = GLMazeView.init(gridModels: gridModels)
        view.addSubview(maze)
        maze.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
}
