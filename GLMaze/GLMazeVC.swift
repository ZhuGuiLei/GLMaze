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

class GLMazeVC: GLMainViewController {

    var grade: Int = 1
    
    var row: Int {
        return 10 + grade * 2
    }
    var column: Int {
        return 15 + grade * 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let gridModels = GLMazeManager.createMazeData(row: row, column: column)
        
        GLMazeManager.createPath(gridModels: gridModels)
        GLMazeManager.drawMaze(gridModels: gridModels, toView: view)
    }
    
    
    
}
