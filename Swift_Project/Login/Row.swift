//
//  Row.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/5/3.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

protocol Updatable: class {
    // 关联类型(本质是起别名) 并不明确指定类型，有遵守此协议的子类来指定具体的类型
    // 在协议中使用 typealias 会报警告 ‘Type alias is missing an assigned type; use 'associatedtype' to define an associated type requirement’
//    typealias viewData
    associatedtype ViewData
    func upate(viewData: ViewData)
}

protocol CellType {
    // 重用标识符
    var indentifier: String { get }
    var cellClass: AnyClass { get }
    
    func cell<T: UITableViewCell>() -> T
    func cellItem<T>() -> T
    func update(cell: UITableViewCell)
}


class Row<Cell> where Cell: Updatable, Cell: UITableViewCell {
    var tag: Int = 0
    let viewData: Cell.ViewData
    let reuseIdentifier = "\(Cell.classForCoder())"
    let cellClass = Cell.self
    
    private var _cell: Cell?
    
    init(viewData: Cell.ViewData, tag: Int) {
        self.viewData = viewData
        self.tag = tag
    }
    
    func cell<T: UITableViewCell>() -> T {
        guard let cell = _cell as? T else {
            fatalError("cell类型错误")
        }
        return cell
    }
    
    func cellItem<T>() -> T {
        guard let cellItem = viewData as? T else {
            fatalError("cellItem 类型错误")
        }
        return cellItem
    }
    
    
    func update(cell: UITableViewCell) {
        if let cell = cell as? Cell {
            _cell = cell
            cell.upate(viewData: viewData)
        }
    }
    
}

struct NoneItem {
    
}


// 扩展Updatable 协议
extension Updatable {
    func upate(viewData: NoneItem) {
        
    }
}
