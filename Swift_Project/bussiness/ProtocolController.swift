//
//  ProtocolController.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/10.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

@available(iOS 12.0, *)
class ProtocolController: UIViewController {

    var shakeLabel: MyLabel!
    var mySwitch: MySwitch!
    var myImageView: MyImageView!
    var myTextField: MyTextField!
    var nameTextField: MyTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 面向对象方式调用
//        pooViewType()
        // 使用协议
//        popViewTyep()
        
        setupPopableControl()
        setAutoFill()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        popTest()
    }
    
    
    // MARK: -
    // MARK: - SetupPopableControl
    private func setupPopableControl() {
        let shakeLabel = MyLabel()
        self.shakeLabel = shakeLabel
        shakeLabel.text = "抖动test"
        if #available(iOS 11.0, *) {
            shakeLabel.backgroundColor = UIColor(named: "appThemeColor")
        } else {
            // Fallback on earlier versions
        }
        view.addSubview(shakeLabel)
        
        shakeLabel.translatesAutoresizingMaskIntoConstraints = false
        shakeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        shakeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100).isActive = true
        
        let mySwitch = MySwitch()
        mySwitch.isOn = true
        self.mySwitch = mySwitch
        view.addSubview(mySwitch)
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        mySwitch.topAnchor.constraint(equalTo: shakeLabel.bottomAnchor, constant: 10).isActive = true
        mySwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        let myImageView = MyImageView()
        myImageView.image = #imageLiteral(resourceName: "icon_cat")
//        myImageView.image = R.image.icon_cat()
    
        self.myImageView = myImageView
        view.addSubview(myImageView)
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.topAnchor.constraint(equalTo: mySwitch.bottomAnchor, constant: 10).isActive = true
        myImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        let myTextField = MyTextField()
        self.myTextField = myTextField
        myTextField.placeholder = "账号"
        myTextField.borderStyle = .roundedRect
        view.addSubview(myTextField)
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        myTextField.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 10).isActive = true
        myTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        nameTextField = MyTextField()
        nameTextField.placeholder = "密码"
        nameTextField.borderStyle = .roundedRect
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: myTextField.bottomAnchor, constant: 10).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    }
    
    private func popTest() {
        self.shakeLabel.shakeAnimation()
        self.mySwitch.popAnimation()
        self.myImageView.shakeAnimation()
        self.myTextField.shakeAnimation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 200)) {
            self.shakeLabel.popAnimation()
            self.mySwitch.shakeAnimation()
        }
    }
    
    
    
    private func setAutoFill() {
        if #available(iOS 11.0, *) {
            nameTextField.textContentType = .password
            myTextField.textContentType = .username
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 12.0, *) {
//            nameTextField.textContentType = .oneTimeCode
//            myTextField.textContentType = .oneTimeCode
        }
    }
    
    
    // MARK: -
    // MARK: - 面向对象
    private func pooViewType() {
        let firstView = FirstView.loadFromNib()
        firstView.backgroundColor = UIColor.red
        firstView.frame = CGRect(x: 0, y: 64, width: 200, height: 50)
        view.addSubview(firstView)
        
        let secondView = SecondView.loadFromNib()
        secondView.frame = CGRect(x: 0, y: 120, width: 200, height: 100)
        secondView.backgroundColor = UIColor.green
        view.addSubview(secondView)
    }
    
    
    private func popViewTyep() {
        let firtView_protocol = FirstView_protocol.loadFromNib()
        firtView_protocol.backgroundColor = UIColor.blue
        
        let secondView_protocol = SecondView_protocol.loadFromNib()
        secondView_protocol.backgroundColor = .cyan
        
        view.addSubview(firtView_protocol)
        firtView_protocol.translatesAutoresizingMaskIntoConstraints = false
        
        firtView_protocol.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        firtView_protocol.widthAnchor.constraint(equalToConstant: 150).isActive = true
        firtView_protocol.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        view.addSubview(secondView_protocol)
        secondView_protocol.translatesAutoresizingMaskIntoConstraints = false
        secondView_protocol.topAnchor.constraint(equalTo: firtView_protocol.bottomAnchor).isActive = true
        secondView_protocol.leftAnchor.constraint(equalTo: firtView_protocol.leftAnchor, constant: 10).isActive = true
        secondView_protocol.rightAnchor.constraint(equalTo: firtView_protocol.rightAnchor, constant: -10).isActive = true
        secondView_protocol.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}



// MARK: - 1.0面向协议 - 视图控件动画
protocol Popable {}
extension Popable where Self: UIView {
    func popAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 0.0
        }) { (finished) in
            UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseInOut, animations: {
                self.alpha = 1.0
            }, completion: nil)
        }
    }
}

protocol Shakable {}
extension Shakable where Self: UIView {
    func shakeAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.08
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}

class MyLabel: UILabel, Shakable, Popable {   }
class MyButton: UIButton, Shakable, Popable {  }
class MySwitch: UISwitch, Shakable, Popable {  }
class MyTextField: UITextField, Shakable, Popable {  }
class MyImageView: UIImageView, Shakable, Popable {  }




// MARK: - 0. 面向协议封装空白页面

//// 1. 空视图协议
//protocol EmptyDataSetable { }
//
//
//extension EmptyDataSetable where Self: UIViewController {
//    func emptyData(for ScrollView: UIScrollView) {  }
//}


// MARK: -
// MARK: -  面向对象使用继承方式
class BaseView: UIView {    }
extension BaseView {
    class func loadFromNib() -> BaseView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! BaseView
    }
}

class FirstView: BaseView { }
extension FirstView {
    class func FirstViewLoadFromNib() -> FirstView {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! FirstView
    }
}

class SecondView: BaseView {    }


// MARK: -
// MARK: - 面向协议编程(Protocol-Oriented Programming)

// 协议中不能使用class 关键字，使用static
// 扩展可以添加新计算属性不能添加存储属性
// 可以扩展自己的构造器
//    ```
//    convenience init(backgroundColor: UIColor) {
//        self.init
//    }
//    ```
// 2. 扩展协议
// 3. 使用where约束遵守协议的类型
// 4. `Self` 表示遵守协议的具体类型
//在协议中指实现这个接口本身的类型，就需要使用 Self 进行指代 http://swifter.tips/use-self/
//在类中指的是方法返回的具体子类的类型

protocol Nibloadable {  }

extension Nibloadable {
    var tag: Int { return 10 }
    var backgroundColor: UIColor { return UIColor.red }
    static func loadFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.first as! Self
    }
}

// 遵守协议
class FirstView_protocol: UIView, Nibloadable { }
class SecondView_protocol: UIView, Nibloadable { }




