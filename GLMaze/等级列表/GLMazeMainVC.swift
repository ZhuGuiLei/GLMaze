//
//  GLMazeMainVC.swift
//  GLMaze
//
//  Created by apple on 2019/12/26.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit
import SPPageMenu

class GLMazeMainVC: GLMainViewController {

    lazy var pageMenu: SPPageMenu = {
        let pageMenu = SPPageMenu.init(frame: CGRect.init(x: 0, y: 0, width: Wi, height: 44), trackerStyle: .lineAttachment)
        pageMenu.delegate = self
        
        pageMenu.backgroundColor = .white
                
        pageMenu.setItems(["1-30", "31-60", "61-90", "91-120"], selectedItemIndex: 0)
        
        pageMenu.permutationWay = .notScrollEqualWidths
        pageMenu.selectedItemTitleColor = R.color.main()!
        pageMenu.unSelectedItemTitleColor = R.color.w666()!
        pageMenu.selectedItemTitleFont = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        pageMenu.unSelectedItemTitleFont = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        pageMenu.tracker.image =  UIImage.image(color: R.color.main()!)
        pageMenu.trackerWidth = 23
        pageMenu.setTrackerHeight(2, cornerRadius: 1)
        pageMenu.trackerFollowingMode = .always
//        pageMenu.dividingLine.image = UIImage.image(color: .line)
        pageMenu.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        pageMenu.bridgeScrollView = self.containView
        
        
        return pageMenu
    }()
    
    lazy var containView: UIScrollView = {
        let scroll = UIScrollView.init(frame: CGRect.init(x: 0, y: 44, width: Wi, height: Hi-Hn-44))
        scroll.bounces = false
        scroll.isPagingEnabled = true
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        weak var weakself = self
        for item in 0..<4 {
            
            let vc = GLMazeListVC.init()
            vc.startGrade = item * 30 + 1
            self.addChild(vc)
        }
        
        if let vc = self.children.first {
            vc.view.frame = CGRect(x: 0 , y: 0, width: scroll.width, height: scroll.height)
            scroll.addSubview(vc.view)
            scroll.contentSize = CGSize(width: CGFloat(self.children.count) * Wi, height: 0)
        }
        
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "经典"
        
        self.view.addSubview(self.pageMenu)
        self.view.addSubview(self.containView)
    }

}

extension GLMazeMainVC: SPPageMenuDelegate {
    
    func pageMenu(_ pageMenu: SPPageMenu, itemSelectedFrom fromIndex: Int, to toIndex: Int) {
        
        containView.setContentOffset(CGPoint(x: Wi * CGFloat(toIndex), y: 0), animated: false)
        if self.children.count <= toIndex {
            return
        }
        
        let toVC: UIViewController = self.children[toIndex]
        
        if toVC.isViewLoaded {
            return
        }
        
        toVC.view.frame = CGRect(x: Wi * CGFloat(toIndex) , y: 0, width: Wi, height: containView.height)
        containView.addSubview(toVC.view)
    }
}
