//
//  LoginViewController.swift
//  HXSwiftProject
//
//  Created by HuXin on 2022/1/19.
//

import Foundation
import SnapKit
import UIKit
import PKHUD

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeSubViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        print("user: %@\n userInfo: %@",  UserDefaults.standard.object(forKey: "restaurantUser") ?? "NULL", UserDefaults.standard.object(forKey: "restaurantUserInfo") ?? "NULL")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkBoxButton.isSelected = false
        if let userInfo = UserDefaults.standard.dictionary(forKey: "currentUserLogin"), let account = userInfo["account"] as? String, let password = userInfo["password"] as? String {
            accountTextField.text = account
            passwordTextField.text = password
            checkBoxButton.isSelected = true
        }
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "账号："
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var accountTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "密码："
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var checkLabel: UILabel = {
        let label = UILabel()
        label.text = "记住登陆状态"
        label.textColor = MyAppearence.brandColor
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    lazy var checkBoxButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "login_checkbox_off"), for: .normal)
        button.setImage(UIImage(named: "login_checkbox_on"), for: .selected)
        button.addTarget(self, action: #selector(checkBoxSelected), for: .touchUpInside)
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("登陆", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = MyAppearence.brandColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        button.addTarget(self, action: #selector(checkAccountAndPassword), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("没有账号？去注册", for: .normal)
        button.setTitleColor(MyAppearence.brandColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        button.addTarget(self, action: #selector(showRegisterView), for: .touchUpInside)
        return button
    }()
    
    lazy var roleChoseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    func makeSubViews() {
        view.addSubview(containerView)
        containerView.addSubview(accountLabel)
        containerView.addSubview(passwordLabel)
        containerView.addSubview(accountTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(checkLabel)
        containerView.addSubview(checkBoxButton)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        containerView.snp.makeConstraints { make in
            make.centerY.equalTo(view).offset(-40.0)
            make.centerX.equalTo(view)
            make.left.equalTo(view).offset(20.0)
            make.right.equalTo(view).offset(-20.0)
            make.height.equalTo(160.0)
        }
        
        accountLabel.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(30.0)
            make.top.equalTo(containerView).offset(20.0)
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
        
        checkBoxButton.snp.makeConstraints { make in
            make.bottom.equalTo(containerView)
            make.right.equalTo(containerView).offset(-10.0)
            make.width.height.equalTo(16.0)
        }
        
        checkLabel.snp.makeConstraints { make in
            make.right.equalTo(checkBoxButton.snp.left).offset(-1.0)
            make.centerY.equalTo(checkBoxButton)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(containerView.snp.bottom).offset(20.0)
            make.width.equalTo(120.0)
            make.height.equalTo(48.0)
        }
        
        registerButton.snp.makeConstraints { make in
            make.centerX.equalTo(loginButton)
            make.top.equalTo(loginButton.snp.bottom).offset(30.0)
            make.height.equalTo(32.0)
            make.width.equalTo(200.0)
        }
    }
}

// MARK: - Action

extension LoginViewController {
    @objc
    func checkBoxSelected() {
        checkBoxButton.isSelected = !checkBoxButton.isSelected
    }
    
    @objc
    func checkAccountAndPassword() {
        hideKeyboard()
        if (accountTextField.text ?? "").isEmpty || (passwordTextField.text ?? "").isEmpty {
            HUD.flash(.label("账号或密码不能为空"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
            return
        }
        if let userDict = UserDefaults.standard.dictionary(forKey: "restaurantUser"), userDict.keys.contains(accountTextField.text ?? "") {
            for (key, value) in userDict {
                if key == accountTextField.text {
                    if let password = value as? String, password == passwordTextField.text {
                        HUD.flash(.success, onView: view, delay: MyAppearence.promptDelayTime) {[unowned self] success in
                            if checkBoxButton.isSelected {
                                let currentUserInfo = ["account": accountTextField.text!, "password": password]
                                UserDefaults.standard.set(currentUserInfo, forKey: "currentUserLogin")
                            }
                            else {
                                UserDefaults.standard.removeObject(forKey: "currentUserLogin")
                            }
                            if let account = accountTextField.text,
                               let userInfo = MyAppearence.restaurantUserInfo[account] as? Dictionary<String, Any>,
                               let user = userInfo["user"] as? User {
                                let tabViewController = UITabBarController()
                                tabViewController.modalPresentationStyle = .overFullScreen
                                let personalCenterViewController = PersonalCenterViewController(user: user)
                                let personalCenterNavigationViewController = UINavigationController(rootViewController: personalCenterViewController)
                                if user.role == .manager {
                                    let restaurantManageViewController = RestaurantManageViewController(user: user)
                                    let restaurantManageNavigationViewController = UINavigationController(rootViewController: restaurantManageViewController)
                                    let managerViewController = ManagerViewController(user: user)
                                    let managerNavigationViewController = UINavigationController(rootViewController: managerViewController)
                                    tabViewController.viewControllers = [restaurantManageNavigationViewController, managerNavigationViewController, personalCenterNavigationViewController]                                }
                                else {
                                    let orderGenerateViewController = OrderGenerateViewController(user: user)
                                    let orderGenerateNavigationViewController = UINavigationController(rootViewController: orderGenerateViewController)
                                    let orderManageViewController = OrderManageViewController(user: user, role: .waiter)
                                    let orderManageNavigationViewController = UINavigationController(rootViewController: orderManageViewController)
                                    tabViewController.viewControllers = [orderGenerateNavigationViewController, orderManageNavigationViewController, personalCenterNavigationViewController]                                }
                                self.present(tabViewController, animated: true, completion: nil)
                            }
                            else {
                                showRoleChoseView()
                            }
                        }
                    }
                    else {
                        HUD.flash(.label("密码错误"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
                    }
                }
            }
        }
        else {
            HUD.flash(.label("账号不存在, 可以去注册一个账号"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
        }
    }
    
    @objc
    func showRegisterView() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @objc
    func hideKeyboard() {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

extension LoginViewController {
    func showRoleChoseView() {
        view.addSubview(roleChoseView)
        roleChoseView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        let closeButton: UIButton = {
           let button = UIButton()
            button.setImage(UIImage(named: "close"), for: .normal)
            button.addTarget(self, action: #selector(closeRoleChose), for: .touchUpInside)
            return button
        }()
        roleChoseView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(roleChoseView.safeAreaLayoutGuide).offset(10.0)
            make.right.equalTo(roleChoseView).offset(-20.0)
            make.width.height.equalTo(24.0)
        }
        
        let containerView: UIView = {
            let view = UIView()
            return view
        }()
        roleChoseView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.center.equalTo(roleChoseView)
            make.height.equalTo(280.0)
            make.width.equalTo(120.0)
        }
        
        let restaurantButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "login_restaurant"), for: .normal)
            button.layer.cornerRadius = 6.0
            button.layer.masksToBounds = true
            button.tag = 1
            button.addTarget(self, action: #selector(showRegisterRoleViewController(button:)), for: .touchUpInside)
            return button
        }()
        containerView.addSubview(restaurantButton)
        restaurantButton.snp.makeConstraints { make in
            make.width.height.equalTo(64.0)
            make.centerX.equalTo(containerView)
            make.top.equalTo(containerView).offset(20.0)
        }
        
        let restaurantLabel: UILabel = {
            let label = UILabel()
            label.text = "我要创建餐厅"
            label.textColor = MyAppearence.brandColor
            label.font = UIFont.systemFont(ofSize: 16.0)
            return label
        }()
        containerView.addSubview(restaurantLabel)
        restaurantLabel.snp.makeConstraints { make in
            make.centerX.equalTo(restaurantButton)
            make.height.equalTo(24.0)
            make.top.equalTo(restaurantButton.snp.bottom)
        }
        
        let waiterLabel: UILabel = {
            let label = UILabel()
            label.text = "我要成为服务员"
            label.textColor = MyAppearence.brandColor
            label.font = UIFont.systemFont(ofSize: 16.0)
            return label
        }()
        containerView.addSubview(waiterLabel)
        waiterLabel.snp.makeConstraints { make in
            make.centerX.height.equalTo(restaurantLabel)
            make.bottom.equalTo(containerView).offset(20.0)
        }
        
        let waiterButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(named: "login_waiter"), for: .normal)
            button.layer.cornerRadius = 6.0
            button.layer.masksToBounds = true
            button.tag = 2
            button.addTarget(self, action: #selector(showRegisterRoleViewController(button:)), for: .touchUpInside)
            return button
        }()
        containerView.addSubview(waiterButton)
        waiterButton.snp.makeConstraints { make in
            make.width.height.equalTo(64.0)
            make.centerX.equalTo(containerView)
            make.bottom.equalTo(waiterLabel.snp.top)
        }
    }
    
    @objc
    func showRegisterRoleViewController(button: UIButton) {
        let registerRoleViewController = RegisterRoleViewController(role: button.tag == 1 ? .manager : .waiter, account: accountTextField.text ?? "")
        registerRoleViewController.modalPresentationStyle = .overFullScreen
        registerRoleViewController.confirmBlock = { user, restaurant in
            var restaurantUserInfo = [String: Any]()
            if let data = UserDefaults.standard.object(forKey: "restaurantUserInfo") as? Data,
               let info = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSDictionary.self, User.self, Restaurant.self, Food.self, Order.self, NSArray.self, UIImage.self], from: data) as? [String: Any] {
                restaurantUserInfo = info
            }
            var userDict: [String: Any] = ["user": user]
            if user.role == .manager && restaurant != nil {
                userDict.updateValue(restaurant!, forKey: "restaurant")
                let waiters = [User]()
                userDict.updateValue(waiters, forKey: "waiters")
            }
            else {
                let orders = [Order]()
                userDict.updateValue(orders, forKey: "orders")
            }
            restaurantUserInfo.updateValue(userDict, forKey: user.account!)
            let data = try? NSKeyedArchiver.archivedData(withRootObject: restaurantUserInfo, requiringSecureCoding: true)
            UserDefaults.standard.set(data, forKey: "restaurantUserInfo")
            
            registerRoleViewController.dismiss(animated: true, completion: { [weak self] in
                guard let self = self else { return }
                let tabViewController = UITabBarController()
                tabViewController.modalPresentationStyle = .overFullScreen
                let personalCenterViewController = PersonalCenterViewController(user: user)
                let personalCenterNavigationViewController = UINavigationController(rootViewController: personalCenterViewController)
                if user.role == .manager {
                    let restaurantManageViewController = RestaurantManageViewController(user: user)
                    let restaurantManageNavigationViewController = UINavigationController(rootViewController: restaurantManageViewController)
                    let managerViewController = ManagerViewController(user: user)
                    let managerNavigationViewController = UINavigationController(rootViewController: managerViewController)
                    tabViewController.viewControllers = [restaurantManageNavigationViewController, managerNavigationViewController, personalCenterNavigationViewController]
                }
                else {
                    let orderGenerateViewController = OrderGenerateViewController(user: user)
                    let orderGenerateNavigationViewController = UINavigationController(rootViewController: orderGenerateViewController)
                    let orderManageViewController = OrderManageViewController(user: user, role: .waiter)
                    let orderManageNavigationViewController = UINavigationController(rootViewController: orderManageViewController)
                    tabViewController.viewControllers = [orderGenerateNavigationViewController, orderManageNavigationViewController, personalCenterNavigationViewController]
                }
                self.present(tabViewController, animated: true, completion: nil)
            })
        }
        navigationController?.present(registerRoleViewController, animated: true, completion: nil)
        closeRoleChose()
    }
    
    @objc
    func closeRoleChose() {
        roleChoseView.removeFromSuperview()
    }
}
