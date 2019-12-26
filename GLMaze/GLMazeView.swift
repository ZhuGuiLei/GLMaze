//
//  GLMazeView.swift
//  GLMaze
//
//  Created by apple on 2019/12/26.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit

class GLMazeView: UIView {

    init(gridModels: [[GLGridModel]]) {
        
        
        let row = gridModels.first!.count
        let column = gridModels.count
        let width: Int = 20// min(Wi / CGFloat(row + 2), Hi / CGFloat(column + 2))
        
        super.init(frame: CGRect(x: 0, y: 0, width: width * row, height: width * column))
        
        for column in 0..<gridModels.count {
            let items = gridModels[column]
            for row in 0..<items.count {
                let item = items[row]
                self.addSubview(item.view)
                item.view.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(width * row)
                    make.top.equalToSuperview().offset(width * column)
                    make.width.height.equalTo(width)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
