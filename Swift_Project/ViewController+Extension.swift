//
//  ViewController+Extension.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/6/25.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

extension ViewController {
    func testPageController() {
        
        let testButton = UIButton()
        testButton.setTitle("testPageController", for: .normal)
        testButton.backgroundColor = UIColor.green
        testButton.addTarget(self, action: #selector(testButtonAction), for: .touchUpInside)

        view.addSubview(testButton)
        testButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
            $0.top.equalTo(120)
            $0.leading.equalTo(20)
        }
    }
    
    @objc
    func testButtonAction() {
        let pageController = TestPageController()
        navigationController?.pushViewController(pageController, animated: true)
        self.tabBarController?.hidesBottomBarWhenPushed = true

    }
    
    func testDropFilter() {
        
        let testButton = UIButton()
        testButton.setTitle("testDropFilter", for: .normal)
        testButton.backgroundColor = UIColor.green
        testButton.addTarget(self, action: #selector(testButton2Action(sender:)), for: .touchUpInside)
        
        view.addSubview(testButton)
        testButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
            $0.top.equalTo(120)
            $0.leading.equalTo(200)
        }
    }
    
    @objc
    func testButton2Action(sender: UIButton) {
        let _ = DropDownFilterMenu(items: [], view: self.view, react: CGRect(x: 0, y: sender.frame.maxY, width: view.frame.width, height: view.frame.width))
    }
    
}
