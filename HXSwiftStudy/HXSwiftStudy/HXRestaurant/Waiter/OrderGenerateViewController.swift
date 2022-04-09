//
//  OrderGenerateViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2022/2/3.
//

import Foundation
import SnapKit
import UIKit
import PKHUD

enum OrderState: String {
    case submited = "submited"
    case waitTreat = "waitTreat"
    case finished = "finished"
}

class Order: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var serialNumber: String = ""
    var menu = [Food]()
    var totalPrice: Double?
    var site: String?
    var state: OrderState?
    
    init(menu: [Food], totalPrice: Double, site: String) {
        self.state = .submited
        self.menu = menu
        for _ in 0...11 {
            self.serialNumber += "\(Int.random(in: 0..<10))"
        }
        self.totalPrice = totalPrice
        self.site = site
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(serialNumber, forKey: "serialNumber")
        coder.encode(menu, forKey: "menu")
        coder.encode(totalPrice, forKey: "totalPrice")
        coder.encode(site, forKey: "site")
        coder.encode(state?.rawValue, forKey: "state")
    }
    
    required init?(coder: NSCoder) {
        state = OrderState(rawValue: (coder.decodeObject(forKey: "state") as? String) ?? "submited")
        menu = (coder.decodeObject(forKey: "menu") as? [Food]) ?? [Food]()
        totalPrice = coder.decodeObject(forKey: "totalPrice") as? Double
        site = coder.decodeObject(forKey: "site") as? String
        serialNumber = (coder.decodeObject(forKey: "serialNumber") as? String) ?? ""
    }
}

class OrderGenerateViewController: UIViewController {
    var menu = [Food]()
    var user: User
    var isFirstEnter = true
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "订单生成", image: UIImage(named: "waiter"), tag: 101)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("点击生成订单", for: .normal)
        button.setTitleColor(MyAppearence.brandColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        button.addTarget(self, action: #selector(showOrderSetViewController), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let account = user.account,
           let userInfo = MyAppearence.restaurantUserInfo[account] as? Dictionary<String, Any>,
           let restaurant = userInfo["restaurant"] as? Restaurant {
            self.menu = restaurant.menu
        }
        if isFirstEnter {
            makeSubViews()
            isFirstEnter = false
        }
        if menu.count == 0 {
            createButton.setTitle("你还没有加入任何餐厅~", for: .normal)
            createButton.isEnabled = false
        }
    }
    
    func makeSubViews() {
        view.backgroundColor = .white
        view.addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.equalTo(48.0)
        }
    }
    
    @objc
    func showOrderSetViewController() {
        let orderSetVeiwController = OrderSetVeiwController(menu: menu, account: user.account ?? "")
        navigationController?.pushViewController(orderSetVeiwController, animated: true)
    }
}

class OrderSetVeiwController: UIViewController {
    var menu: [Food]
    var totalPrice = 0.0
    var account: String
    
    init(menu: [Food], account: String) {
        self.account = account
        self.menu = menu
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var foodTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200.0
        tableView.register(FoodTableViewCell.self, forCellReuseIdentifier: "foodCell")
        tableView.register(EmptyCell.self, forCellReuseIdentifier: "emptyCell")
        return tableView
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("生成订单", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MyAppearence.brandColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(finishedOrder), for: .touchUpInside)
        return button
    }()
    
    lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "总价格：\(totalPrice)"
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var siteLabel: UILabel = {
        let label = UILabel()
        label.text = "座位："
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var siteTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入客户的座位"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodTableView.dataSource = self
        foodTableView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        makeSubViews()
    }
}

extension OrderSetVeiwController {
    @objc
    func hideKeyboard() {
        siteTextField.resignFirstResponder()
    }
    
    func makeSubViews() {
        view.backgroundColor = .white
        view.addSubview(confirmButton)
        view.addSubview(totalPriceLabel)
        view.addSubview(siteLabel)
        view.addSubview(siteTextField)
        view.addSubview(foodTableView)
        
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10.0)
            make.height.equalTo(48.0)
            make.width.equalTo(150.0)
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(confirmButton.snp.top).offset(-10.0)
            make.left.equalTo(view).offset(10.0)
            make.height.equalTo(32.0)
            make.right.equalTo(view).offset(-20.0)
        }
        
        siteLabel.snp.makeConstraints { make in
            make.bottom.equalTo(totalPriceLabel.snp.top).offset(-10.0)
            make.left.equalTo(view).offset(10.0)
            make.height.equalTo(32.0)
            make.width.equalTo(48.0)
        }
        
        siteTextField.snp.makeConstraints { make in
            make.centerY.height.equalTo(siteLabel)
            make.left.equalTo(siteLabel.snp.right).offset(15.0)
            make.right.equalTo(view).offset(-20.0)
        }
        
        foodTableView.snp.makeConstraints { make in
            make.left.right.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(siteLabel.snp.top).offset(-10.0)
        }
    }
    
    @objc
    func finishedOrder() {
        if totalPrice == 0.0 {
            HUD.flash(.label("还没有选择任何餐品"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
            return
        }
        if (siteTextField.text ?? "").isEmpty {
            let alert = UIAlertController(title: "提示", message: "还没有填写座位信息", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "去填写", style: .cancel)
            let action2 = UIAlertAction(title: "就这样", style: .default) { [unowned self] _ in
                HUD.flash(.success, onView: self.view, delay: 0.5) { [unowned self] success in
                    self.saveOrder()
                }
            }
            
            alert.addAction(action1)
            alert.addAction(action2)
            present(alert, animated: true, completion: nil)
            return
        }
        HUD.flash(.success, onView: self.view, delay: 0.5) { [unowned self] success in
            self.saveOrder()
        }
    }
    
    func saveOrder() {
        var foodMenu = [Food]()
        for food in menu {
            if food.needCount > 0 {
                foodMenu.append(food)
            }
        }
        var restaurantUserInfo = MyAppearence.restaurantUserInfo
        if var userInfo = restaurantUserInfo[account] as? Dictionary<String, Any>,
            var orders = userInfo["orders"] as? [Order] {
            let order = Order(menu: foodMenu, totalPrice: totalPrice, site: siteTextField.text ?? "")
            orders.append(order)
            userInfo.updateValue(orders, forKey: "orders")
            restaurantUserInfo.updateValue(userInfo, forKey: account)
            let data = try? NSKeyedArchiver.archivedData(withRootObject: restaurantUserInfo, requiringSecureCoding: true)
            UserDefaults.standard.set(data, forKey: "restaurantUserInfo")
        }
        navigationController?.popViewController(animated: true)
    }
}

extension OrderSetVeiwController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count > 0 ? menu.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if menu.count > 0,
            let foodCell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as? FoodTableViewCell {
            foodCell.setWithFoodItem(item: menu[indexPath.row], order: true)
            foodCell.updateFoodBlock = { [unowned self] add in
                let food = menu[indexPath.row]
                if add {
                    if Int(food.foodCount) > 0 {
                        self.totalPrice += Double(foodCell.food?.price ?? "0.0") ?? 0.0
                        food.needCount += 1
                        food.foodCount -= 1
                    }
                }
                else {
                    if food.needCount > 0 {
                        self.totalPrice -= Double(foodCell.food?.price ?? "0.0") ?? 0.0
                        food.needCount -= 1
                        food.foodCount += 1
                    }
                }
                self.foodTableView.reloadData()
                self.totalPriceLabel.text = "总价格：\(self.totalPrice)"
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }
            return foodCell
        }
        else if let emptyCell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath) as? EmptyCell {
            return emptyCell
        }
        return UITableViewCell()
    }
}
