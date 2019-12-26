//
//  GLWallModel.swift
//  GLMaze
//
//  Created by apple on 2019/12/25.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit

class GLWallModel: NSObject {
    
    weak var gridMain: GLGridModel!
    weak var gridNext: GLGridModel?
    
    var isPath: Bool = false
    
}
