//
//  GLMazeView.swift
//  GLMaze
//
//  Created by apple on 2019/12/26.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit

class GLMazeView: UIView {

    var maze: UIView = UIView.init()
    var gridModels: [[GLGridModel]] = []
    var w: CGFloat = 0
    var h: CGFloat = 0
    
    var currentGrid: GLGridModel! {
        didSet {
            currentGrid.view.addSublayer(GLCurrentView.shared.layer)
        }
    }
    var endGrid: GLGridModel! {
        didSet {
            endGrid.view.addSublayer(GLEndView.shared.layer)
        }
    }
    
    
    lazy var pan: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(twoPanAction(pan:)))
        pan.minimumNumberOfTouches = 2
        pan.delegate = self
        return pan
    }()
    
    lazy var pinch: UIPinchGestureRecognizer = {
        let pinch = UIPinchGestureRecognizer.init(target: self, action: #selector(pinchAction(pinch:)))
        pinch.delegate = self
        return pinch
    }()
    
    lazy var swipeUp: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeAction(swipe:)))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .up
        return swipe
    }()
    lazy var swipeLeft: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeAction(swipe:)))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .left
        return swipe
    }()
    lazy var swipeDown: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeAction(swipe:)))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .down
        return swipe
    }()
    lazy var swipeRight: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeAction(swipe:)))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .right
        return swipe
    }()
    
    
    init(gridModels: [[GLGridModel]]) {
        super.init(frame: .zero)
        self.gridModels = gridModels
        
        
        let colume = gridModels.first!.count
        let row = gridModels.count
        
        w = CGFloat(GridW * colume + WallW * colume + WallW)
        h = CGFloat(GridW * row + WallW * row + WallW)
        
        self.addSubview(maze)
        maze.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(w)
            make.height.equalTo(h)
        }
        
        for (row, items) in gridModels.enumerated() {
            for (column, item) in items.enumerated() {
                maze.layer.addSublayer(item.view)
                item.view.frame = CGRect(x: (GridW + WallW) * column + WallW, y: (GridW + WallW) * row + WallW, width: GridW, height: GridW)
            }
        }
        
        self.allShow()
        
        self.addGestureRecognizer(pan)
        self.addGestureRecognizer(pinch)
        self.addGestureRecognizer(swipeUp)
        self.addGestureRecognizer(swipeLeft)
        self.addGestureRecognizer(swipeDown)
        self.addGestureRecognizer(swipeRight)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func allShow() {
        let scale = min(Wi / w, Hi / h) * 0.9
        maze.transform = maze.transform.scaledBy(x: scale, y: scale)
    }
    
    func set(start: GLGridModel, end: GLGridModel) {
        start.view.addSublayer(GLStartView.shared.layer)
        currentGrid = start
        endGrid = end
    }
    
    deinit {
        DLog("deinit\(self)")
    }

}

extension GLMazeView: UIGestureRecognizerDelegate
{
    @objc func twoPanAction(pan: UIPanGestureRecognizer) {
        
        //获取偏移量
        // 返回的是相对于最原始的手指的偏移量
        let point = pan.translation(in: self)
        // 移动控件
        var transform = maze.transform.translatedBy(x: point.x, y: point.y)
        
        let maxWidth = max(0, maze.width * 0.5 - (self.width * 0.25))
        let maxHeight = max(0, maze.height * 0.5 - (self.height * 0.25))
        if transform.tx > maxWidth {
            transform.tx = maxWidth
        } else if transform.tx < -maxWidth {
            transform.tx = -maxWidth
        }
        if transform.ty > maxHeight {
            transform.ty = maxHeight
        } else if transform.ty < -maxHeight {
            transform.ty = -maxHeight
        }
        
        maze.transform = transform
        // 复位,表示相对上一次
        pan.setTranslation(.zero, in: self)
        
    }
    
    @objc func pinchAction(pinch: UIPinchGestureRecognizer) {
        
        var transform = maze.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        if transform.a > 2 {
            transform.a = 2
            transform.d = 2
        }
        let minScale = min(1, min(self.width / w, self.height / h) * 0.75)
        if transform.a < minScale {
            transform.a = minScale
            transform.d = minScale
        }
        maze.transform = transform
        // 复位
        pinch.scale = 1
    }
    
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        if swipe.direction == .up {
            if currentGrid.canUp {
                UIView.animate(withDuration: MoveSpeed, animations: {
                    GLCurrentView.shared.transform = CGAffineTransform.identity.translatedBy(x: 0, y: CGFloat(-GridW))
                }) { (finished) in
                    GLCurrentView.shared.transform = CGAffineTransform.identity
                    self.currentGrid = self.currentGrid.top!.gridMain
                    if !IsSingleStep && self.currentGrid.sideGrids.count == 2 {
                        if self.currentGrid.canUp {
                            self.swipeAction(swipe: self.swipeUp)
                        } else if self.currentGrid.canLeft {
                            self.swipeAction(swipe: self.swipeLeft)
                        } else if self.currentGrid.canRight {
                            self.swipeAction(swipe: self.swipeRight)
                        }
                    }
                }
                
            }
        } else if swipe.direction == .left {
            if currentGrid.canLeft {
                UIView.animate(withDuration: MoveSpeed, animations: {
                    GLCurrentView.shared.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(-GridW), y: 0)
                }) { (finished) in
                    GLCurrentView.shared.transform = CGAffineTransform.identity
                    self.currentGrid = self.currentGrid.left!.gridMain
                    if !IsSingleStep && self.currentGrid.sideGrids.count == 2 {
                        if self.currentGrid.canUp {
                            self.swipeAction(swipe: self.swipeUp)
                        } else if self.currentGrid.canLeft {
                            self.swipeAction(swipe: self.swipeLeft)
                        } else if self.currentGrid.canDown {
                            self.swipeAction(swipe: self.swipeDown)
                        }
                    }
                }
            }
        } else if swipe.direction == .down {
            if currentGrid.canDown {
                UIView.animate(withDuration: MoveSpeed, animations: {
                    GLCurrentView.shared.transform = CGAffineTransform.identity.translatedBy(x: 0, y: CGFloat(GridW))
                }) { (finished) in
                    GLCurrentView.shared.transform = CGAffineTransform.identity
                    self.currentGrid = self.currentGrid.bottom.gridNext
                    if !IsSingleStep && self.currentGrid.sideGrids.count == 2 {
                        if self.currentGrid.canLeft {
                            self.swipeAction(swipe: self.swipeLeft)
                        } else if self.currentGrid.canDown {
                            self.swipeAction(swipe: self.swipeDown)
                        } else if self.currentGrid.canRight {
                            self.swipeAction(swipe: self.swipeRight)
                        }
                    }
                }
            }
        } else if swipe.direction == .right {
            if currentGrid.canRight {
                UIView.animate(withDuration: MoveSpeed, animations: {
                    GLCurrentView.shared.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(GridW), y: 0)
                }) { (finished) in
                    GLCurrentView.shared.transform = CGAffineTransform.identity
                    self.currentGrid = self.currentGrid.right.gridNext
                    if !IsSingleStep && self.currentGrid.sideGrids.count == 2 {
                        if self.currentGrid.canUp {
                            self.swipeAction(swipe: self.swipeUp)
                        } else if self.currentGrid.canDown {
                            self.swipeAction(swipe: self.swipeDown)
                        } else if self.currentGrid.canRight {
                            self.swipeAction(swipe: self.swipeRight)
                        }
                    }
                }
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
