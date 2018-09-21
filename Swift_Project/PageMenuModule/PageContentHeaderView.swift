//
//  PageContentHeaderView.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/3.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class PageContentHeaderView: UIView {
    
    var model: [[String: String]]?
    
    var stageInfo: [[String: String]]? {
        didSet {
            titleLabel.text = "我是头部信息说的高度，高度是开放式的那个肥了；撒粉绿色郭凯了；时郭凯刘栋饭撒过类似的咖啡机阿斯科利大家尕斯库勒感觉啊胜利的快感几点上课看郭凯了就哭了阿胶糕啦绝世独立开工建设打开管理局阿萨德个"
            timeLabel.text = "2018-16-45"
            startConditionLabel.text = "开始条件"
            finishConditionLabel.text = "结束条件"
            titleLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width
            }
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(timeLabel)
        addSubview(timeIconImageView)
        addSubview(startConditionLabel)
        addSubview(finishConditionLabel)
        addSubview(iconImageView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(11)
        }
        
        timeIconImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(17)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeIconImageView)
            make.leading.equalTo(timeIconImageView.snp.trailing).offset(7)
        }
        
        startConditionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(timeLabel)
            make.top.equalTo(timeLabel.snp.bottom).offset(16)
        }
        
        finishConditionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(startConditionLabel)
            make.top.equalTo(startConditionLabel.snp.bottom).offset(2)
            make.bottom.equalToSuperview().inset(4)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 64, height: 64))
            make.bottom.trailing.equalTo(self)
        }
    }
    
    // MARK: - Lazy
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 60))
        iconImageView.image = UIImage(named: "icon_cat")
        iconImageView.backgroundColor = UIColor.purple
        return iconImageView
    }()
    
    private lazy var timeIconImageView: UIImageView = {
        let timeIconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 60))
        timeIconImageView.image = UIImage(named: "icon_cat")
        timeIconImageView.backgroundColor = UIColor.purple
        return timeIconImageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.text = "团队领导力中级"
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byCharWrapping
        return titleLabel
    }()
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textAlignment = .left
        timeLabel.text = "开放时间：2018/05/08-2018/05/13"
        return timeLabel
    }()
    
    private lazy var startConditionLabel: UILabel = {
        let startConditionLabel = UILabel()
        startConditionLabel.font = UIFont.systemFont(ofSize: 14)
        startConditionLabel.textAlignment = .left
        startConditionLabel.text = "开启条件：开放时间内不限制"
        return startConditionLabel
    }()
    
    private lazy var finishConditionLabel: UILabel = {
        let finishConditionLabel = UILabel()
        finishConditionLabel.font = UIFont.systemFont(ofSize: 14)
        finishConditionLabel.textAlignment = .left
        finishConditionLabel.text = "完成条件：课程全部学完且考试全部结束"
        return finishConditionLabel
    }()
}
