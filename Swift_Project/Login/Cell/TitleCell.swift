//
//  TitleCell.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/5/4.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit


struct TitleCellItem {
    let title: String
}

class TitleCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        textLabel?.textAlignment = .center
        textLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TitleCell: Updatable {
    func upate(viewData: TitleCellItem) {
        textLabel?.text = viewData.title
    }
}
