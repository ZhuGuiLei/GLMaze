//
//  GLMazeVC.swift
//  GLMaze
//
//  Created by apple on 2019/12/25.
//  Copyright © 2019 layne. All rights reserved.
//
/**
 0|0|0|0|0|0|
 - - - - - -
 0|0|0|0|0|0|
 - - - - - -
 0|0|0|0|0|0|
 - - - - - -
 0|0|0|0|0|0|
 - - - - - -

 */

import UIKit
import Foundation
import SVProgressHUD



class GLMazeVC: GLMainViewController {

    var grade: Int = 1
    
    var row: Int {
        return 8 + grade * 1
    }
    var column: Int {
        return 12 + grade * 1 + grade / 2
    }
    
    var gridModels: [[GLGridModel]] = []
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        GLProgressHUD.dismissOne()
        GLMazeManager.setStop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "\(grade)"
        
        GLProgressHUD.showIndicator(msg: "加载中...")
        
        gridModels = GLMazeManager.createMazeData(row: row, column: column)
        GLMazeManager.createPath(gridModels: gridModels) {
            
            GLMazeManager.drawMaze(gridModels: self.gridModels, toView: self.view)
            GLProgressHUD.dismissOne()
        }
        
        
    }
    
    
    
}
