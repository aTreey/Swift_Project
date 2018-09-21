//
//  FormTableController.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/5/3.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class FormTableController: UIViewController {
    
    var formData: [[CellType]] = [] {
        didSet {
            registerCells()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupLocalData()
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    final func celltype(at indexPath: IndexPath) -> CellType {
        return formData[indexPath.section][indexPath.row]
    }
    
    private func registerCells() {
        formData.forEach {
            $0.forEach {
                tableView.register($0.cellClass, forCellReuseIdentifier: $0.indentifier)
            }
        }
    }
    
    
    private func setupLocalData () {
        let titleCell = Row<TitleCell>(viewData: TitleCellItem(title: "登录"), tag: 0)
        let titleCell2 = Row<TitleCell>(viewData: TitleCellItem(title: "登出"), tag: 1)
        
        formData = [[titleCell, titleCell2]] as! [[CellType]]

    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        return tableView
    }()

}

extension FormTableController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return formData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = celltype(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.indentifier, for: indexPath)
        return cell
    }
}



