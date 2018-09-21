//
//  UITableView+Extension.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/19.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}


// 次协议必须满足两个条件1. 是UIView的子类，2.遵守ReusableView协议
// 扩展协议
extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib? { return nil }
}


extension UITableView {
    /// Set table header view & add Auto layout.
    func setTableHeaderView(headerView: UIView) {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set first.
        self.tableHeaderView = headerView
        
        // Then setup AutoLayout.
        headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    /// Update header view's frame.
    func updateHeaderViewFrame() {
        guard let headerView = self.tableHeaderView else { return }
        
        // Update the size of the header based on its internal content.
        headerView.layoutIfNeeded()
        
        // ***Trigger table view to know that header should be updated.
        let header = self.tableHeaderView
        self.tableHeaderView = header
    }
    
    /// 注册cell
    func register<T: UITableViewCell>(T: T.Type) where T: ReusableView {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    /// 调用cell
    func dequeueReusableCell<T: UITableViewCell>(_ indexPath: IndexPath) -> T where T: ReusableView {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
