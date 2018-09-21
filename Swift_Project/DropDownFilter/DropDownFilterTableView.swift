//
//  FBDropDownFilterTableView.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/6/28.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class DropDownFilterTableView: UITableView {
    
    var items = [DropDownItem]()
    var selectIndexPath: Int?
    var didSelectCellClosure: ((DropDownItem) -> ())?
    var didDeselectCellClosure: ((IndexPath) -> ())?
    
    static fileprivate var config: DropDownFilterConfig!
    private let cellIdentifier = "FBDropDownFilterCell"
    
    init(frame: CGRect, items: [DropDownItem], selecItem: DropDownItem, config: DropDownFilterConfig) {
        super.init(frame: frame, style: UITableViewStyle.plain)
        self.items = items
        DropDownFilterTableView.config = config
        selectIndexPath = items.index(of: selecItem)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        self.register(FBDropDownFilterCell.self, forCellReuseIdentifier: cellIdentifier)
        rowHeight = DropDownFilterTableView.config.cellHeight
        backgroundColor = DropDownFilterTableView.config.cellBackgroundColor
        
        if DropDownFilterTableView.config.isShowCellSeparator {
            separatorStyle = .singleLine
            separatorInset = DropDownFilterTableView.config.cellSeparatorInset
        } else {
            separatorStyle = .none
            separatorInset = .zero
        }
        
        tableFooterView = UIView(frame: CGRect.zero)
        bounces = false
        delegate = self
        dataSource = self
    }
}
    
    
    
extension DropDownFilterTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCellClosure?(items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        didDeselectCellClosure?(indexPath)
    }
}


extension DropDownFilterTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = self.items[(indexPath as NSIndexPath).row].title
        return cell
    }
}

class FBDropDownFilterCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.textLabel?.textColor = DropDownFilterTableView.config.cellSelectTextColor
        } else {
            self.textLabel?.textColor = DropDownFilterTableView.config.cellTextColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        self.selectedBackgroundView = UIView(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = DropDownFilterTableView.config.cellSelectBackgroundColor
        self.backgroundColor = DropDownFilterTableView.config.cellBackgroundColor
        self.textLabel?.font = UIFont.systemFont(ofSize: DropDownFilterTableView.config.cellTextFont)
        self.textLabel?.textAlignment = DropDownFilterTableView.config.cellTextAlignment
    }
}
