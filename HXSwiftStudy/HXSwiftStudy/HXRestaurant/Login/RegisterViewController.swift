//
//  RegisterViewController.swift
//  HXSwiftProject
//
//  Created by HuXin on 2022/1/19.
//

import Foundation
import SnapKit
import UIKit
import PKHUD

class RegisterViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        makeSubViews()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "账号："
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var accountTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "账号为6到12个任意字符"
        return textField
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "密码："
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        textField.placeholder = "密码为6到10个数字"
        return textField
    }()
    
    lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "确认密码："
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("注册", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = MyAppearence.brandColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        button.addTarget(self, action: #selector(checkAccountAndPassword), for: .touchUpInside)
        return button
    }()
    
    func makeSubViews() {
        view.addSubview(containerView)
        containerView.addSubview(accountLabel)
        containerView.addSubview(passwordLabel)
        containerView.addSubview(accountTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(confirmPasswordLabel)
        containerView.addSubview(confirmPasswordTextField)
        view.addSubview(loginButton)
        
        containerView.snp.makeConstraints { make in
            make.centerY.equalTo(view).offset(-40.0)
            make.centerX.equalTo(view)
            make.left.equalTo(view).offset(20.0)
            make.right.equalTo(view).offset(-20.0)
            make.height.equalTo(240.0)
        }
        
        accountLabel.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(30.0)
            make.top.equalTo(containerView).offset(40.0)
            make.width.equalTo(60.0)
            make.height.equalTo(32.0)
        }
        
        accountTextField.snp.makeConstraints { make in
            make.centerY.height.equalTo(accountLabel)
            make.left.equalTo(accountLabel.snp.right).offset(1.0)
            make.right.equalTo(containerView).offset(-10.0)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.centerX.width.height.equalTo(accountLabel)
            make.top.equalTo(accountLabel.snp.bottom).offset(40.0)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.width.height.equalTo(accountTextField)
            make.centerY.equalTo(passwordLabel)
        }
        
        confirmPasswordLabel.snp.makeConstraints { make in
            make.height.right.equalTo(accountLabel)
            make.width.equalTo(120.0)
            make.top.equalTo(passwordLabel.snp.bottom).offset(40.0)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.centerY.equalTo(confirmPasswordLabel)
            make.centerX.width.height.equalTo(passwordTextField)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(containerView.snp.bottom).offset(20.0)
            make.width.equalTo(120.0)
            make.height.equalTo(48.0)
        }
    }
}

// MARK: - Action

extension RegisterViewController {
    @objc
    func checkAccountAndPassword() {
        hideKeyboard()
        if (accountTextField.text ?? "").isEmpty || (passwordTextField.text ?? "").isEmpty {
            HUD.flash(.label("账号或密码不能为空"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
            return
        }
        let account = accountTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        if account.count >= 6 && account.count <= 12 {
            if password.count >= 6 && password.count <= 10 {
                for char in password {
                    if !char.isNumber {
                        HUD.flash(.label("密码必须都是数字"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
                        return
                    }
                }
                if confirmPassword != password {
                    HUD.flash(.label("重复密码和密码不一样"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
                }
                else {
                    var restaurantUser = [String: String]()
                    if let dict = UserDefaults.standard.dictionary(forKey: "restaurantUser") as? [String: String] {
                        if dict.keys.contains(account) {
                            HUD.flash(.label("账号已存在"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
                            return
                        }
                        restaurantUser = dict
                    }
                    restaurantUser.updateValue(password, forKey: account)
                    UserDefaults.standard.set(restaurantUser, forKey: "restaurantUser")
                    HUD.flash(.success, onView: view, delay: MyAppearence.promptDelayTime) { [unowned self] success in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            else {
                HUD.flash(.label("密码必须是6到10个数字"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
            }
        }
        else {
            HUD.flash(.label("账号必须是6到12个任意字符"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
        }
    }
    
    @objc
    func hideKeyboard() {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
}
