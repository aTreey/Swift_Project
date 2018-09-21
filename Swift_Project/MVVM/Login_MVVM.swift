//
//  Login_MVVM.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/8/1.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit


// MARK: - ViewModel
protocol ViewModelDelegate {
    func reload()
    func alert()
    func changeRootController()
}

protocol Loginable {
    var delegate: ViewModelDelegate? { get set }
    var userNameBorderColor: UIColor? { get }
    var passwordBorderColor: UIColor? { get }
    var loginButtonEnable: Bool { get }
    
    func userNameDidChange(text: String?)
    func passwordDidChange(text: String?)
    func login()
}

extension Loginable {
    var userNameBorderColor: UIColor? {
        return .orange
    }
    
    var passwordBorderColor: UIColor? {
        return .purple
    }
}

// MARK: - ViewModel
public class ViewModel: NSObject, Loginable {
    
    var delegate: ViewModelDelegate?
    
    var loginButtonEnable: Bool {
        return usernameIsValid && passwordIsValid
    }
    
    
    private var usernameIsValid: Bool = false
    private var passwordIsValid: Bool = false
    private var userName: String?
    private var password: String?
    
    func userNameDidChange(text: String?) {
        if let text = text {
            usernameIsValid = text.count > 0
        } else {
            delegate?.alert()
        }
        userName = text
        delegate?.reload()
    }
    
    func passwordDidChange(text: String?) {
        if let text = text {
            usernameIsValid = text.count < 6
        }
        password = text
        delegate?.reload()
    }
    
    func login() {
        delegate?.changeRootController()
    }
}

class LoginViewController: UIViewController {
    
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupData()
    }
    
    private func setupData() {
        viewModel = ViewModel()
        viewModel.delegate = self
    }
    
    private func setupUI() {
        view.addSubview(userNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)

        userNameTextField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-100)
            make.leading.trailing.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(45)
        }
    }
    
    
    
    @objc private func loginAction() {
        print("loginAction")
        viewModel.login()
    }
    
    @objc private func passwordChanged(textField: UITextField) {
        print("passwordChanged")
        viewModel.passwordDidChange(text: textField.text)
    }
    
    @objc private func userNameChanged(textField: UITextField) {
        print("userNameChanged")
        viewModel.userNameDidChange(text: textField.text)
    }
    
    // MARK: - lazy
    
    private lazy var userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.placeholder = "账号"
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.textAlignment = .left
        userNameTextField.addTarget(self, action: #selector(userNameChanged(textField:)), for: .editingChanged)
        return userNameTextField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "密码"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.textAlignment = .left
        passwordTextField.addTarget(self, action: #selector(passwordChanged(textField:)), for: .editingChanged)
        return passwordTextField
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .custom)
        loginButton.setTitle("登陆", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        loginButton.backgroundColor = UIColor.orange
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return loginButton
    }()
}


extension LoginViewController: ViewModelDelegate {
    func reload() {
        userNameTextField.layer.borderColor = viewModel.userNameBorderColor?.cgColor
        passwordTextField.layer.borderColor = viewModel.passwordBorderColor?.cgColor
        userNameTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderWidth = 0.5
        loginButton.isEnabled = viewModel.loginButtonEnable
    }
    
    func alert() {
        let alert = UIAlertController(title: "", message: "登陆错误", preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) in
            print("cancle action")
        }
        let sureAction = UIAlertAction(title: "取消", style: .cancel) { (UIAlertAction) in
            print("sureAction")
        }
        
        action.setValue(UIColor.red, forKey: "titleTextColor")
        alert.addAction(sureAction)
        alert.addAction(action)
        alert.preferredAction = action
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeRootController() {
        alert()
    }
}
