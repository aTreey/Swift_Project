//
//  BussinessController.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/2.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class BussinessController: UITableViewController {

    var items: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightItem = UIBarButtonItem(title: "高度变化", style: .plain, target: self, action: #selector(changeTableHeaderViewHeight))
        self.navigationItem.rightBarButtonItem = rightItem
        
        items = ["BussessDetailController",
                 "BussessDetailController",
                 "ProtocolController",
                 "TableViewProtocolController",
                 "SwiftLearningController",
                 "LoginViewController",
                 "SettingsViewController",
                 "SettingsViewController2",
                 "RNTestController"]
        
        let testStr = "\n\n\n换行测试"
        let str = self.trimmingLinebreak(string: testStr)
        print(str)
        
//        self.tableView.tableHeaderView?.backgroundColor = UIColor.green
//        headerView.snp.makeConstraints { (make) in
//            make.leading.trailing.equalTo(tableView)
//            make.height.equalTo(200)
//        }
        
        self.tableView.setTableHeaderView(headerView: headerView)
        self.tableView.updateHeaderViewFrame()
    }
    
    
    @objc
    func changeTableHeaderViewHeight() {
        headerView.stageInfo = [["": ""]]
        self.tableView.updateHeaderViewFrame()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
    private func trimmingLinebreak(string: String?) -> String {
        if let tempString = string {
            let linebreakSet = CharacterSet(charactersIn: "\n")
            return tempString.trimmingCharacters(in: linebreakSet)
        }
        return ""
    }
    
    
    // MARK: - Lazy
    private lazy var headerView: PageContentHeaderView = {
        let headerView = PageContentHeaderView()
        headerView.backgroundColor = UIColor.red
        return headerView
    }()
}


extension BussinessController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"]
        guard let name = nameSpace as? String else{  return  }

        let className = NSClassFromString(name + "." + items[indexPath.row]) as! UIViewController.Type
        self.navigationController?.pushViewController(className.init(), animated: true)
    }
}



