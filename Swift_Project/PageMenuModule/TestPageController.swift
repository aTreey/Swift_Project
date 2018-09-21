//
//  TestPageController.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/6/25.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class TestPageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let page1Controller = Page1TableViewController()
        page1Controller.title = "测试1"
        let page2Controller = Page2TableViewController()
        page2Controller.title = "测试2"
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let testPageController = PageMenuController(controllers: [page1Controller, page2Controller], frame: frame)
        view.addSubview(testPageController.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
