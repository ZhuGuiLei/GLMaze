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
        for r in 0..<row {
            var arr  = [GLGridModel]()
            for c in 0..<column {
                let model = GLGridModel.init(row: c, column: r)
                if c > 0 {
                    model.left = arr[c-1].right
                    model.left?.gridNext = model
                }
                if r > 0 {
                    model.top = gridModels[r-1][c].bottom
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
            
            let row = gridModels.count
            let colume = gridModels.first!.count
            
            let grid = gridModels[0][0]
            var oldGrid: Set<GLGridModel> = [grid]
            var oldWall: Set<GLWallModel> = grid.wallSet
            
            
            while oldGrid.count != colume * row {
                
                if stop {
                    stop = false
                    break
                }
                let wall = oldWall.first!
                if let next = wall.gridNext {
                    if oldGrid.contains(next) {
                        if oldGrid.contains(wall.gridMain) {
                            oldWall.remove(wall)
                        } else {
                            wall.isPath = true
                            oldGrid.insert(wall.gridMain)
                            oldWall.formUnion(wall.gridMain.wallSet)
                        }
                    } else {
                        wall.isPath = true
                        oldGrid.insert(next)
                        oldWall.formUnion(next.wallSet)
                    }
                }
                oldWall.remove(wall)
            }
            DispatchQueue.main.async {
                completion?()
            }
        }
        
    }
    
    /// 生成路径
    static func createLongPath(gridModels: [[GLGridModel]], completion: ((_: [GLGridModel]) -> Void)?) {
        
        DispatchQueue.global().async {
            
            let allModels = gridModels.flatMap({ $0 })
            var allCurrentModels = allModels.filter { (model) -> Bool in
                if model.sideGrids.count == 1 {
                    model.step = 0
                    return true
                } else {
                    model.step = -2
                    return false
                }
            }
            
            
            var pathModels: [[GLGridModel]] = []
            
            while allCurrentModels.count != 0 {
                
                pathModels.append(allCurrentModels)
                
                var allNextModel: [GLGridModel] = []
                for model in allCurrentModels {
                    for side in model.sideGrids {
                        let step = model.step - side.step
                        if step != 1 {
                            side.step = model.step + 1
                            allNextModel.append(side)
                        }
                        
                    }
                }
                allCurrentModels = allNextModel
            }
            
            var last = pathModels.last!.last!
            var paths: [GLGridModel] = createLongPath2(gridModels: gridModels, start: last)
            
//            while last.step != 0 {
//                for model in last.sideGrids {
//                    if last.step - model.step == 1 {
//                        paths.insert(model, at: 0)
//                        last = model
//                    }
//                }
//            }
            
            DispatchQueue.main.async {
//                for model in allModels {
//                    model.showStep = true
//                }
                for item in paths {
                    item.showStep = true
                }
                completion?(paths)
            }
            
        }
        
    }
    
    /// 生成路径
    static func createLongPath2(gridModels: [[GLGridModel]], start: GLGridModel) -> [GLGridModel] {
        
       
        var allStartModels = Set.init(gridModels.flatMap({ $0 }))
        let allModels = Set.init(allStartModels)
        
        var pathModels: [Set<GLGridModel>] = []
        
        let item = start
        allStartModels.remove(item)
        
        if item.sideGrids.count == 1 {
            
            var shenYu = allModels
            // 起点
            // 遍历过的
            var oldModels: [Set<GLGridModel>] = []
            
            oldModels.append([item])
            shenYu.subtract([item])
            
            while shenYu.count > 0 {
                let lasts = oldModels.last!
                var set: Set<GLGridModel> = []
                for model in lasts {
                    set.formUnion(model.sideGrids)
                }
                set = set.filter({ shenYu.contains($0) })
                oldModels.append(set)
                shenYu.subtract(set)
                
            }
            if oldModels.count > pathModels.count {
                pathModels = oldModels
            }
            allStartModels.subtract(oldModels.last!)
        }
    
        let paths = correctPath(pathModels: pathModels)
        
        return paths
    }
    
    /// 生成路径
    static func createLongPath1(gridModels: [[GLGridModel]], completion: ((_: [GLGridModel]) -> Void)?) {
        
        DispatchQueue.global().async {
            
            var allStartModels = Set.init(gridModels.flatMap({ $0 }))
            let allModels = Set.init(allStartModels)
            
            var pathModels: [Set<GLGridModel>] = []
            
            while allStartModels.count > 0 {
                let item = allStartModels.first!
                allStartModels.remove(item)
                
                if stop {
                    stop = false
                    break
                }
                
                if item.sideGrids.count == 1 {
                    
                    var shenYu = allModels
                    // 起点
                    // 遍历过的
                    var oldModels: [Set<GLGridModel>] = []
                    
                    oldModels.append([item])
                    shenYu.subtract([item])
                    
                    while shenYu.count > 0 {
                        let lasts = oldModels.last!
                        var set: Set<GLGridModel> = []
                        for model in lasts {
                            set.formUnion(model.sideGrids)
                        }
                        set = set.filter({ shenYu.contains($0) })
                        oldModels.append(set)
                        shenYu.subtract(set)
                        
                    }
                    if oldModels.count > pathModels.count {
                        pathModels = oldModels
                    }
                    allStartModels.subtract(oldModels.last!)
                }
            }
            
            let paths = correctPath(pathModels: pathModels)
            
            DispatchQueue.main.async {
                for item in paths {
                    item.showStep = true
                }
                completion?(paths)
            }
        }
        
    }
    
    static func correctPath(pathModels: [Set<GLGridModel>]) -> [GLGridModel] {
        for (index, items) in pathModels.enumerated() {
            for item in items {
                item.step = index
            }
        }
        
        var paths: [GLGridModel] = []
        if var end = pathModels.last?.first {
            paths.insert(end, at: 0)
            while end.step != 0 {
                for item in end.sideGrids {
                    if end.step > item.step {
                        end = item
                        paths.insert(end, at: 0)
                    }
                }
            }
        }
        return paths
    }
    
    
    /// 绘制
    static func drawMaze(gridModels: [[GLGridModel]], toView view: UIView) -> GLMazeView {
        
        let maze = GLMazeView.init(gridModels: gridModels)
        view.addSubview(maze)
        maze.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        return maze
    }
}
