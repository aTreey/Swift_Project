//
//  SuspendTestController.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/6/11.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class SuspendTestController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let red = CGFloat((arc4random() % 255)) / 255
        let green = CGFloat((arc4random() % 255)) / 255
        let blue = CGFloat((arc4random() % 255)) / 255
        self.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        self.title = "悬浮框测试控制器"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
