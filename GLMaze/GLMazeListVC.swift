//
//  GLMazeListVC.swift
//  GLMaze
//
//  Created by apple on 2019/12/25.
//  Copyright © 2019 layne. All rights reserved.
//

import UIKit

class GLMazeListVC: UIViewController {

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 19
        let width = (Wi - 20 * 4) / 3
        flowLayout.itemSize = CGSize(width: width, height: width)
        return flowLayout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "经典"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "设置", style: .plain, target: self, action: #selector(navSetAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "迷宫", style: .plain, target: nil, action: nil)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        collectionView.gl_registerCell(cell: GLMazeListCell.self)
    }
    
    @objc func navSetAction() {
        DLog(#function)
    }

}

extension GLMazeListVC: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 99
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = GLMazeListCell.gl_dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.l_grade.text = "\(indexPath.item + 1)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = GLMazeVC.init()
        vc.grade = indexPath.item + 1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
