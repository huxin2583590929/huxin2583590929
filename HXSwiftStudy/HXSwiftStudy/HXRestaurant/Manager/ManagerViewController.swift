//
//  ManagerViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2022/2/15.
//

import Foundation
import SnapKit
import UIKit
import PKHUD

class ManagerViewController: UIViewController {
    var user: User
    var waiters = [User]()
    var allUsers = [User]()
    var isFirstEnter = true
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "人员管理", image: UIImage(named: "manager"), tag: 101)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var allWaitersButton: UIButton = {
        let button = UIButton()
        button.setTitle("全部服务员", for: .normal)
        button.setTitleColor(MyAppearence.brandColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        button.addTarget(self, action: #selector(addWaiterOrShowWaiterList), for: .touchUpInside)
        return button
    }()
    
    lazy var addNewWaiterViewController: AddNewWaiterViewController = {
        let addNewWaiterViewController = AddNewWaiterViewController(users: allUsers, user: user)
        return addNewWaiterViewController
    }()
    
    lazy var addWaiterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "waiter_add"), for: .normal)
        button.addTarget(self, action: #selector(showAddWaiterView), for: .touchUpInside)
        return button
    }()
    
    var waiterTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 80.0
        tableView.register(waiterManageTableViewCell.self, forCellReuseIdentifier: "itemCell")
        tableView.register(EmptyCell.self, forCellReuseIdentifier: "emptyCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        waiterTableView.delegate = self
        waiterTableView.dataSource = self
        addNewWaiterViewController.addSuccessBlock = { [unowned self] in
            if let account = self.user.account,
               let userInfo = MyAppearence.restaurantUserInfo[account] as? Dictionary<String, Any>,
               let items = userInfo["waiters"] as? [User] {
                self.waiters = items
            }
            if self.waiters.count > 0 {
                self.allWaitersButton.setTitle("全部服务员", for: .normal)
            }
            else {
                self.allWaitersButton.setTitle("还没有服务员，去添加~", for: .normal)
            }
            self.waiterTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allUsers.removeAll()
        if let account = user.account,
           let userInfo = MyAppearence.restaurantUserInfo[account] as? Dictionary<String, Any>,
           let items = userInfo["waiters"] as? [User] {
            waiters = items
            for key in MyAppearence.restaurantUserInfo.keys {
                if let info = MyAppearence.restaurantUserInfo[key] as? Dictionary<String, Any>,
                   let user = info["user"] as? User,
                   user.role == .waiter {
                    allUsers.append(user)
                }
            }
        }
        if isFirstEnter {
            makeSubViews()
            isFirstEnter = false
        }
        if waiters.count > 0 {
            allWaitersButton.setTitle("全部服务员", for: .normal)
        }
        else {
            allWaitersButton.setTitle("还没有服务员，去添加~", for: .normal)
        }
        waiterTableView.reloadData()
    }
}

extension ManagerViewController {
    func makeSubViews() {
        view.addSubview(allWaitersButton)
        view.addSubview(waiterTableView)
        view.addSubview(addWaiterButton)
        view.addSubview(addNewWaiterViewController.view)
        
        allWaitersButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40.0)
        }
        
        waiterTableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(allWaitersButton.snp.bottom).offset(10.0)
        }
        
        addNewWaiterViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        addWaiterButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
            make.right.equalTo(view).offset(-20.0)
        }
        
        addNewWaiterViewController.view.isHidden = true
    }
    
    @objc
    func addWaiterOrShowWaiterList() {
        if waiters.count > 0 {
            let waiterListViewController = WaiterListViewController(users: waiters)
            navigationController?.pushViewController(waiterListViewController, animated: true)
        }
        else {
            showAddWaiterView()
        }
    }
    
    @objc
    func showAddWaiterView() {
        addNewWaiterViewController.setObjectWith(users: allUsers)
        addNewWaiterViewController.view.isHidden = false
    }
}

extension ManagerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waiters.count > 0 ? waiters.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if waiters.count > 0,
            let waiterCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? waiterManageTableViewCell {
            waiterCell.setCellWith(user: waiters[indexPath.row])
            return waiterCell
        }
        else if let emptyCell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath) as? EmptyCell {
            emptyCell.emptyImageView.image = UIImage(named: "waiter_empty")
            emptyCell.emptyLabel.text = "还没有添加服务员~"
            emptyCell.emptyLabel.textColor = .black
            return emptyCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if waiters.count == 0 {
            return
        }
        let orderManageViewController = OrderManageViewController(user: waiters[indexPath.row], role: .manager)
        navigationController?.pushViewController(orderManageViewController, animated: true)
    }
}

class waiterManageTableViewCell: UITableViewCell {
    var waiter: User?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        return label
    }()
    
    lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = MyAppearence.brandColor
        label.text = "待确认订单数（0）"
        return label
    }()
    
    func makeSubViews() {
        contentView.backgroundColor = MyAppearence.containerBackground
        contentView.addSubview(nameLabel)
        contentView.addSubview(orderLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.height.equalTo(36.0)
            make.top.equalTo(contentView).offset(10.0)
            make.bottom.equalTo(contentView).offset(-10.0)
            make.left.equalTo(contentView).offset(40.0)
        }
        
        orderLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(10.0)
            make.right.equalTo(contentView).offset(-40.0)
        }
    }
    
    func setCellWith(user: User) {
        guard user.role == .waiter else { return }
        waiter = user
        nameLabel.text = user.name
        if let account = user.account,
           let userInfo = MyAppearence.restaurantUserInfo[account] as? Dictionary<String, Any>,
           let orders = userInfo["orders"] as? [Order] {
            var count = 0
            for order in orders {
                if order.state == .submited {
                    count += 1
                }
            }
            orderLabel.text = "待完成订单数（\(count)）"
        }
    }
}

typealias AddSuccessBolck = () -> Void
class AddNewWaiterViewController: UIViewController, UIGestureRecognizerDelegate {
    var users = [User]()
    var user: User
    var addSuccessBlock: AddSuccessBolck?
    
    init(users: [User], user: User) {
        self.users = users
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8.0
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.placeholder = "请输入要添加的员工手机号"
        return textField
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("添加", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MyAppearence.brandColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(addWaiter), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        makeSubViews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide))
        tap.delegate = self
        backgroundView.addGestureRecognizer(tap)
    }
    
    func setObjectWith(users: [User]) {
        self.users = users
    }
    
    @objc
    func hide() {
        phoneNumberTextField.resignFirstResponder()
        view.isHidden = true
    }
    
    func makeSubViews() {
        view.addSubview(backgroundView)
        view.addSubview(containerView)
        containerView.addSubview(phoneNumberTextField)
        containerView.addSubview(confirmButton)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        containerView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.equalTo(180.0)
            make.width.equalTo(view).multipliedBy(0.7)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.center.equalTo(containerView)
            make.width.equalTo(containerView).multipliedBy(0.8)
            make.height.equalTo(48.0)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.width.equalTo(100.0)
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(20.0)
        }
    }
    
    @objc
    func addWaiter() {
        if (phoneNumberTextField.text ?? "").isEmpty {
            HUD.flash(.label("电话号码不能为空"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
            return
        }
        if !isPhoneNumber(phoneNumber: phoneNumberTextField.text ?? "") {
            HUD.flash(.label("请输入正确的电话号码"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
            return
        }
        if (phoneNumberTextField.text ?? "") == user.phoneNumber {
            HUD.flash(.label("不能输入自己的手机号"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
            return
        }
        let phoneNumber = phoneNumberTextField.text ?? ""
        for user in users {
            if user.phoneNumber == phoneNumber {
                HUD.flash(.success, onView: view, delay: MyAppearence.promptDelayTime) { [unowned self] success in
                    var restaurantUserInfo = MyAppearence.restaurantUserInfo
                    if let account = self.user.account,
                       var userInfo = restaurantUserInfo[account] as? Dictionary<String, Any>,
                       var items = userInfo["waiters"] as? [User] {
                        items.append(user)
                        userInfo.updateValue(items, forKey: "waiters")
                        restaurantUserInfo.updateValue(userInfo, forKey: account)
                        if let restaurant = userInfo["restaurant"] as? Restaurant,
                           var waiterInfo = restaurantUserInfo[user.account!] as? Dictionary<String, Any> {
                            waiterInfo.updateValue(restaurant, forKey: "restaurant")
                            restaurantUserInfo.updateValue(waiterInfo, forKey: user.account!)
                        }
                        let data = try? NSKeyedArchiver.archivedData(withRootObject: restaurantUserInfo, requiringSecureCoding: true)
                        UserDefaults.standard.set(data, forKey: "restaurantUserInfo")
                    }
                    self.addSuccessBlock?()
                }
                self.hide()
                return
            }
        }
        HUD.flash(.label("没有查询到这个用户"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
    }
    
    func isPhoneNumber(phoneNumber:String) -> Bool {
        let mobile = "1(3[0-9]|4[579]|5[0-35-9]|6[6]|7[0-35-9]|8[0-9]|9[89])\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        return regexMobile.evaluate(with: phoneNumber)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == containerView {
            return false
        }
        return true
    }
}
