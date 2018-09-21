//
//  TempController.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/9.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//  swift learning

import UIKit

class TempController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class Father {
    var name: String
    var sex: Int = 0
    var old: Int = 32
    var desc: String {
        return "我是\(name)"
    }
    init(name: String) {
        self.name = name
    }
    
    init(name: String, old: Int) {
        self.name = name
        self.old = old
    }
    
    func run() {
        print("Father can Running")
    }
}

class Son: Father {
    var isSwimming = true
    var computer: String
    var job: String
    
    override var desc: String {
        return "Son is \(name)"
    }
    
    
    // 子类指定构造函数,调用了父类的指定构造函数
    init(name: String, computer: String) {
        self.computer = computer
        self.job = "程序员"
        super.init(name: name)
    }
    
    // 子类便利构造函数，调用了指定构造函数
    convenience init(computer: String) {
        let name = "小张"
        self.init(name: name, computer: computer)
    }
    
    convenience override init(name: String) {
        self.init(name: name, computer: "Lenovon")
    }
}
