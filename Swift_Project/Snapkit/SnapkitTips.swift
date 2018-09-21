//
//  SnapkitTips.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/6/19.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit
import SnapKit

class SnapkitController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleView)
        titleView.didClickClosure = {
            let react = CGRect(x: 0, y: $0.frame.maxY, width: self.view.frame.width, height: self.view.frame.height)
            self.topFilterMenu.show(in: self.view, react: react)
        }
    }
    @IBAction func tipsButtonAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(SnapkitDemoController(), animated: true)
    }
    
    @IBAction func dorpDownTopAction(_ sender: UIButton) {
        let react = CGRect(x: 0, y: sender.frame.maxY, width: self.view.frame.width, height: self.view.frame.height)
        self.topFilterMenu.show(in: self.view, react: react)
    }
    
    
    @IBAction func dorpDownBottomAction(_ sender: UIButton) {
        let react = CGRect(x: 0, y: sender.frame.minY, width: self.view.frame.width, height: self.view.frame.height)
        self.bottomFilterMenu.show(in: self.view, react: react)
    }
    
    
    private lazy var topFilterMenu: DropDownFilterMenu = {
        
        let item0 = DropDownItem(title: "测试0", itemId: 100)
        let item1 = DropDownItem(title: "测试1", itemId: 101)
        let item2 = DropDownItem(title: "测试2", itemId: 102)
        let item3 = DropDownItem(title: "测试3", itemId: 103)
        let item4 = DropDownItem(title: "测试4", itemId: 104)
        let items = [item0, item1, item2, item3, item4]
        
        var config = DropDownFilterConfig()
        config.cellTextAlignment = .center
        
        let topFilterMenu = DropDownFilterMenu(items: items, config: config)
        return topFilterMenu
    }()
    
    private lazy var bottomFilterMenu: DropDownFilterMenu = {
        
        let item0 = DropDownItem(title: "底部测试0", itemId: 100)
        let item1 = DropDownItem(title: "底部测试1", itemId: 101)
        let item2 = DropDownItem(title: "底部测试2", itemId: 102)
        let items = [item0, item1, item2]
        
        var config = DropDownFilterConfig()
        config.cellTextAlignment = .left
        config.direction = .bottom
        
        let bottomFilterMenu = DropDownFilterMenu(items: items, config: config)
        return bottomFilterMenu
    }()
    
    private lazy var titleView = DropDrownTitleView(frame: CGRect(x: 10, y: 90, width: 300, height: 50), title: "全部")
}


class SnapkitDemoController: UIViewController {
    
    var nullDataViewTopConstraint: Constraint?
    var nullDataViewLeftConstraint: Constraint?


    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
//        self.edgesForExtendedLayout = []
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.extendedLayoutIncludesOpaqueBars = true
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        nullDataViewTopConstraint?.deactivate()
//        nullDataViewTopConstraint?.update(inset: 84)
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
//            self.view.layoutIfNeeded()
//        }) { (finished) in
//            print("动画执行完毕")
//        }
        
        nullDataViewLeftConstraint?.deactivate()
        nullDataViewLeftConstraint?.update(inset: 100)
        nullDataViewLeftConstraint?.activate()
        UIView.animate(withDuration: 1.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    // MARK: - setupConstr
    
    private func setupConstraints() {
        view.addSubview(nullDataImageView)
        view.addSubview(tipsLabel)
        view.addSubview(creatButton)
        
        nullDataImageView.snp.makeConstraints {
            nullDataViewTopConstraint = $0.top.equalTo(view).offset(80).constraint
            nullDataViewLeftConstraint = $0.left.equalTo(view).inset(10).constraint
            $0.width.height.equalTo(200).labeled("width和height约束")
        }
        
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nullDataImageView.snp.bottom).offset(12)
            make.centerX.equalTo(view)
        }
        
        creatButton.snp.makeConstraints { (make) in
            make.top.equalTo(tipsLabel.snp.bottom).offset(15)
            make.centerX.equalTo(view)
            make.leading.equalTo(view).offset(110)
            make.trailing.equalTo(view).offset(-110)
        }
    }
    
    // MARK: - lazy
    
    private lazy var nullDataImageView: UIImageView = {
        let nullDataImageView = UIImageView()
        nullDataImageView.image = UIImage(named: "lebiIcon2")
        nullDataImageView.backgroundColor = UIColor.purple
        return nullDataImageView
    }()
    
    private lazy var tipsLabel: UILabel = {
        let tipsLabel = UILabel()
        tipsLabel.font = UIFont.systemFont(ofSize: 14)
        tipsLabel.textAlignment = .left
        tipsLabel.text = "这天还没有线下课程"
        return tipsLabel
    }()
    
    private lazy var creatButton: UIButton = {
        let creatButton = UIButton(type: .custom)
        creatButton.setTitle("发布培训", for: .normal)
        creatButton.backgroundColor = .orange
        creatButton.layer.cornerRadius = 4.0
        creatButton.layer.masksToBounds = true
        return creatButton
    }()
    
    deinit {
        print("deinit")
    }
}

