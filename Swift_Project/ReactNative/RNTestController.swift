//
//  RNTestController.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/9/3.
//  Copyright © 2018 HongpengYu. All rights reserved.
//

import UIKit

class RNTestController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://localhost:8081/index.bundle?platform=ios")!
//        let rootView = RCTRootView(
//            bundleURL: url,
//            moduleName: "MyApp", //这里的名字要和index.js中相同
//            initialProperties: nil,
//            launchOptions: nil
//        )
//        view = rootView
    }
}
