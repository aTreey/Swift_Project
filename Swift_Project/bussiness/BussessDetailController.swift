//
//  BussessDetailController.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/2.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class BussessDetailController: UIViewController {
    
    var kvoObserver: NSKeyValueObservation?
    
    var structObserver: NSKeyValueObservation!
    
    let kvoUser = KVOUser(name: "Test")
    
    let develop = Developer(sex: 0, name: "张三", position: "c++")
    
    var structUser: User!
    
    let userNameKeyPath = \User.name
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        
        view.addSubview(pageContentView)
        
        pageContentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(300)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        pageContentView.didSelectIndexClosure = {
            print($0.item)
        }

        ocObjectKVO()
        print("userNameKeyPath = \(userNameKeyPath)")
        
//        structUser[KeyPath: userNameKeyPath]
        
        webViewQRImageTest()
        
        analysisHTML()
        
        swiftIsEmpty()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        kvoUser.name = "change"
        //        kvoUser.isChange = true
        kvoUser.develop?.name = "李四"
    }
    
    
    /// H5 二维码识别
    private func webViewQRImageTest() {
        let webView = WebView(frame: CGRect(x: 0, y: 0, width: 350, height: 300))
        self.view.addSubview(webView)
        let string = "https://m.lebanban.com/app/message/detail/?sys_message_id=2303764"
        let string2 = "https://mp.weixin.qq.com/s/Cf0JEZHQa-mhGjD_QyJIMQ"
        let url = URL(string: string)!
        webView.loadRequest(URLRequest(url: url))
    }
    
    
    /// 通过URL解析 网页内容
    private func analysisHTML() {
//        let urlString = "https://www.jianshu.com/p/fe6929df6b05"
        let urlString = "https://www.jianshu.com"
        
        let testStr = "我到底是[iOS]开发还是[产品]经理"
        // 获取
        // 获取 [] 中的任意
        let pattern1 = "\\[.*\\]"
        
        let pattern2 = "\\[.*?\\]"
        //
        let pattern3 = "(?<=\\[).*?(?=\\])"
        
        let pattern4 = "(?<=\\[).*?(?=\\])"
        
        let pattern5 = "(?<=title>).*(?=</title)"
        
        let testRange1 = testStr.range(of: pattern1, options: String.CompareOptions.regularExpression, range: testStr.startIndex..<testStr.endIndex, locale: nil)
        let result1 = String(testStr[testRange1!])
        
        
        let testRange2 = testStr.range(of: pattern2, options: String.CompareOptions.regularExpression, range: testStr.startIndex..<testStr.endIndex, locale: nil)
        let result2 = String(testStr[testRange2!])
        
        let testRange3 = testStr.range(of: pattern3, options: String.CompareOptions.regularExpression, range: testStr.startIndex..<testStr.endIndex, locale: nil)
        let result3 = String(testStr[testRange3!])
        
        print(result1) //
        print(result2) //
        print(result3) //

        String.parseHTMLTitle(urlString) { (result) in
            print(result ?? "")
        }
        
        for i in 0..<100 {
            print(i)
        }

        do {
            let html = try String(contentsOf: URL(string: urlString)!, encoding: .utf8)
            let testRange3 = html.range(of: pattern5, options: String.CompareOptions.regularExpression, range: html.startIndex..<html.endIndex, locale: nil)
            let result3 = String(html[testRange3!])
            print(result3)
            
            
            let regular = try NSRegularExpression(pattern: pattern5, options: .caseInsensitive)
            
            
            let matchResult1 = regular.firstMatch(in: html, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, html.count))
            let matchRange = matchResult1?.range
            let range = Range(matchRange!)!
            
            let startIndex = html.index(html.startIndex, offsetBy: range.lowerBound)
            let endIndex = html.index(html.startIndex, offsetBy: range.upperBound)
            
            let range3 = Range(uncheckedBounds: (lower: startIndex, upper: endIndex))
            let result1 = String(html[range3])
            print(result1) //
            
            
            let matchResult2 = regular.matches(in: html, options: .reportProgress, range: NSMakeRange(0, html.count))
            matchResult2.forEach { (result) in
                let range = Range(result.range)!
                
                let startIndex = html.index(html.startIndex, offsetBy: range.lowerBound)
                let endIndex = html.index(html.startIndex, offsetBy: range.upperBound)
                
                let subStr2 = html[Range(uncheckedBounds: (startIndex, endIndex))]
                print(String(subStr2))
            }
            
            let str3 = regular.stringByReplacingMatches(in: html, options: .reportProgress, range: NSMakeRange(0, html.count), withTemplate: "====")
            print(str3)
            
        } catch let error {
            print(error)
            return
        }
        
    }
    
    
    // Swift isEmpty 判断
    func swiftIsEmpty() {
        var strNil: String?
        strNil = "测试"
        print(strNil)
        
        if let tmepStr = strNil {
            print(tmepStr.isEmpty)
        }
        
        
        let str = ""
        print(str.isEmpty)
        
        
        var array: [String] = []
        
        var array1: [String]?
        
        var array3: [String] = [String]()
        
        print(array.isEmpty)
        print(array1?.isEmpty)
        print(array3.isEmpty)
    }
    
    
   // ===========================KVO==========================
    private func ocObjectKVO() {
        
        kvoUser.develop = develop
        
//        kvoObserver = kvoUser.observe(\.name, options: [.initial, .new], changeHandler: { (kvouser, change) in
//            print(self.kvoUser.name, change.newValue, change.oldValue)
//        })
        
//        kvoObserver = kvoUser.observe(\.isChange, options: [.initial, .new], changeHandler: { (kvouser, change) in
//            print(self.kvoUser.isChange, change.newValue, change.oldValue)
//        })
        
//        kvoObserver = kvoUser.observe(kvoUser.develop?.position, options: [.initial, .new], changeHandler: { (kvouser, change) in
//            print(self.kvoUser.isChange, change.newValue, change.oldValue)
//        })
    }
    
    private func structKVO() {
        structUser = User(name: "Struct KVO", age: 8, developer: develop)
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Lazy
    private lazy var titleView: PageTitleView = PageTitleView()
    private let items = ["测试0","测---试～", "测试2", "测--阶段性试","测试ac","测++试---阶段+","测试6"]
    private lazy var pageContentView: FBPageContentView = FBPageContentView(frame: .zero, items: items)

}

// swift 观察者模式
@objcMembers
class KVOUser: NSObject {
    dynamic var name: String
    dynamic var isChange: Bool = false
    dynamic var develop: Developer?
    
    init(name: String) {
        self.name = name
    }
}


//class Developer2: NSObject {
//    dynamic let sex: Int
//    dynamic var name: String
//    dynamic let position: String
//}

struct User {
    let name: String
    var age: Int
    var developer: Developer
    
}

struct Developer {
    let sex: Int
    var name: String
    let position: String
}





