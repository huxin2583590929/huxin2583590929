//
//  PersonalCenterViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2022/2/11.
//

import Foundation
import SnapKit
import UIKit
import PKHUD

class PersonalCenterViewController: UIViewController {
    var user: User
    var restaurant: Restaurant?
    
    init(user: User) {
        self.user = user

        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "个人中心", image: UIImage(named: "ui"), tag: 101)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 6.0
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "register_avatar_placeholder")
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "姓名："
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "电话："
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    lazy var changeInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("修改资料", for: .normal)
        button.setTitleColor(MyAppearence.brandColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.addTarget(self, action: #selector(showChangeInfoView), for: .touchUpInside)
        return button
    }()
    
    lazy var restaurantButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(MyAppearence.brandColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.addTarget(self, action: #selector(showRestaurantInfoViewController), for: .touchUpInside)
        return button
    }()
    
    lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("修改密码", for: .normal)
        button.setTitleColor(MyAppearence.brandColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.addTarget(self, action: #selector(showChangePasswordViewController), for: .touchUpInside)
        return button
    }()
    
    lazy var quitLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("退出登陆", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MyAppearence.brandColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(quitLogin), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantButton.setTitle(user.role == .manager ? "编辑餐厅信息" : "查看餐厅信息", for: .normal)
        view.backgroundColor = .white
        makeSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avatarImageView.image = user.avatar
        nameLabel.text = "姓名：\(user.name ?? "")"
        phoneNumberLabel.text = "电话：\(user.phoneNumber ?? "")"
    }
}

extension PersonalCenterViewController {
    func makeSubViews() {
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(changeInfoButton)
        view.addSubview(restaurantButton)
        view.addSubview(changePasswordButton)
        view.addSubview(quitLoginButton)
        
        avatarImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50.0)
            make.width.height.equalTo(100.0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView).offset(-40.0)
            make.top.equalTo(avatarImageView.snp.bottom).offset(20.0)
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(10.0)
        }
        
        changeInfoButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(80.0)
        }
        
        restaurantButton.snp.makeConstraints { make in
            make.centerX.equalTo(changeInfoButton)
            make.top.equalTo(changeInfoButton.snp.bottom).offset(30.0)
        }
        
        changePasswordButton.snp.makeConstraints { make in
            make.centerX.equalTo(restaurantButton)
            make.top.equalTo(restaurantButton.snp.bottom).offset(30.0)
        }
        
        quitLoginButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40.0)
            make.width.equalTo(150.0)
        }
    }
    
    @objc
    func showChangeInfoView() {
        let changeInfoViewController = RegisterRoleViewController(user: user)
        changeInfoViewController.confirmBlock = { [unowned self] user, restaurant in
            self.user = user
            var restaurantUserInfo = MyAppearence.restaurantUserInfo
            if let account = user.account,
               var userInfo = restaurantUserInfo[account] as? Dictionary<String, Any> {
                userInfo.updateValue(user, forKey: "user")
                restaurantUserInfo.updateValue(userInfo, forKey: account)
                let data = try? NSKeyedArchiver.archivedData(withRootObject: restaurantUserInfo, requiringSecureCoding: true)
                UserDefaults.standard.set(data, forKey: "restaurantUserInfo")
            }

            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(changeInfoViewController, animated: true)
    }
    
    @objc
    func showRestaurantInfoViewController() {
        if let account = user.account,
           let userInfo = MyAppearence.restaurantUserInfo[account] as? Dictionary<String, Any>,
           let restaurant = userInfo["restaurant"] as? Restaurant {
            self.restaurant = restaurant
        }
        
        let restaurantInfoViewController = RestaurantInfoViewController(restaurant: restaurant, user: user)
        navigationController?.pushViewController(restaurantInfoViewController, animated: true)
    }
    
    @objc
    func showChangePasswordViewController() {
        let changePasswordViewController = ChangePasswordViewController(account: user.account ?? "")
        navigationController?.pushViewController(changePasswordViewController, animated: true)
    }
    
    @objc
    func quitLogin() {
        parent?.dismiss(animated: true, completion: nil)
    }
}

class ChangePasswordViewController: UIViewController {
    var account: String
    
    init(account: String) {
        self.account = account
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeSubViews()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var oldPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "旧密码："
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var oldPasswordTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "请输入原密码"
        return textField
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "新密码："
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
        textField.placeholder = "请再次确认新密码"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("确认", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = MyAppearence.brandColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        button.addTarget(self, action: #selector(checkAccountAndPassword), for: .touchUpInside)
        return button
    }()
    
    func makeSubViews() {
        view.addSubview(containerView)
        containerView.addSubview(oldPasswordLabel)
        containerView.addSubview(passwordLabel)
        containerView.addSubview(oldPasswordTextField)
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
        
        oldPasswordLabel.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(30.0)
            make.top.equalTo(containerView).offset(40.0)
            make.width.equalTo(70.0)
            make.height.equalTo(32.0)
        }
        
        oldPasswordTextField.snp.makeConstraints { make in
            make.centerY.height.equalTo(oldPasswordLabel)
            make.left.equalTo(oldPasswordLabel.snp.right).offset(1.0)
            make.right.equalTo(containerView).offset(-10.0)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.centerX.width.height.equalTo(oldPasswordLabel)
            make.top.equalTo(oldPasswordLabel.snp.bottom).offset(40.0)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.width.height.equalTo(oldPasswordTextField)
            make.centerY.equalTo(passwordLabel)
        }
        
        confirmPasswordLabel.snp.makeConstraints { make in
            make.height.right.equalTo(oldPasswordLabel)
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

extension ChangePasswordViewController {
    @objc
    func checkAccountAndPassword() {
        hideKeyboard()
        if (oldPasswordTextField.text ?? "").isEmpty || (passwordTextField.text ?? "").isEmpty {
            HUD.flash(.label("旧密码或新密码不能为空"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
            return
        }
        let oldPassword = oldPasswordTextField.text ?? ""
        let newPassword = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        if let userDict = UserDefaults.standard.dictionary(forKey: "restaurantUser"),
            let password = userDict[account] as? String, password == oldPassword {
            if newPassword.count >= 6 && newPassword.count <= 10 {
                for char in newPassword {
                    if !char.isNumber {
                        HUD.flash(.label("密码必须都是数字"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
                        return
                    }
                }
                if confirmPassword != newPassword {
                    HUD.flash(.label("重复密码和密码不一样"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
                }
                else {
                    var restaurantUser = [String: String]()
                    if let dict = UserDefaults.standard.dictionary(forKey: "restaurantUser") as? [String: String] {
                        restaurantUser = dict
                    }
                    restaurantUser.updateValue(newPassword, forKey: account)
                    UserDefaults.standard.set(restaurantUser, forKey: "restaurantUser")
                    HUD.flash(.success, onView: view, delay: MyAppearence.promptDelayTime) { [unowned self] success in
                        self.parent?.parent?.dismiss(animated: true, completion: {
                            UserDefaults.standard.removeObject(forKey: "currentUserLogin")
                        })
                    }
                }
            }
            else {
                HUD.flash(.label("密码必须是6到10个数字"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
            }
        }
        else {
            HUD.flash(.label("旧密码不正确"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
        }
    }
    
    @objc
    func hideKeyboard() {
        oldPasswordTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
}
