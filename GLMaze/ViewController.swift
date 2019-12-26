//
//  ViewController.swift
//  GLMaze
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    var btn = UIButton.init(frame: CGRect.init(x: 250, y: 80, width: 100, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.snp.removeConstraints()
        R.color.w333()
        
    }
    
}

