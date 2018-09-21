//
//  RxSwiftList.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/1.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class RxSwiftList: UITableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        return cell
    }

}
