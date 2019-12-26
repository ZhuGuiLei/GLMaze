//
//  glExtension.swift
//  Extension
//
//  Created by apple on 2019/12/13.
//  Copyright © 2019 zhuguilei. All rights reserved.
//

import UIKit

public extension UITableViewCell
{
    static func gl_dequeueReusableCell(tableView: UITableView, indexPath: IndexPath) -> Self {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(self)", for: indexPath)
        return cell as! Self
    }
}

public extension UICollectionViewCell {
    
    static func gl_dequeueReusableCell(collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(self)", for: indexPath)
        return cell as! Self
    }
}

public extension UICollectionView {
    
    func gl_registerCell(cell: UICollectionViewCell.Type) {
        self.register(UINib.init(nibName: "\(cell)", bundle: nil), forCellWithReuseIdentifier: "\(cell)")
    }
    
    func gl_registerCell(cell: UICollectionViewCell.Type, type: String) {
        self.register(UINib.init(nibName: "\(cell)"+type, bundle: nil), forCellWithReuseIdentifier: "\(cell)")
    }
}

public extension UITableView {
    
    func gl_registerCell(cell: UITableViewCell.Type) {
        self.register(UINib.init(nibName: "\(cell)", bundle: nil), forCellReuseIdentifier: "\(cell)")
    }
    
    func gl_registerCell(cell: UITableViewCell.Type, type: String) {
        self.register(UINib.init(nibName: "\(cell)"+type, bundle: nil), forCellReuseIdentifier: "\(cell)")
    }
}



