//
//  OrderManageViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2022/2/9.
//

import Foundation
import SnapKit
import UIKit
import PKHUD

class OrderManageViewController: UIViewController {
    var orders = [Order]()
    var role: UserType
    var user: User
    var isFirstEnter = true
    
    init(user: User, role: UserType) {
        self.role = role
        self.user = user
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "订单管理", image: UIImage(named: "order"), tag: 101)
        NotificationCenter.default.addObserver(self, selector: #selector(enterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        enterBackground()
    }

    @objc
    func enterBackground() {
        var restaurantUserInfo = MyAppearence.restaurantUserInfo
        if let account = user.account,
           var userInfo = restaurantUserInfo[account] as? Dictionary<String, Any> {
            userInfo.updateValue(orders, forKey: "orders")
            restaurantUserInfo.updateValue(userInfo, forKey: account)
            let data = try? NSKeyedArchiver.archivedData(withRootObject: restaurantUserInfo, requiringSecureCoding: true)
            UserDefaults.standard.set(data, forKey: "restaurantUserInfo")
        }
    }
    
    lazy var waitTreatOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "待确认订单数量(0)"
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var orderTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200.0
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: "orderCell")
        tableView.register(EmptyCell.self, forCellReuseIdentifier: "emptyCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderTableView.delegate = self
        orderTableView.dataSource = self
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if let data = UserDefaults.standard.object(forKey: "foodOrders") as? Data, let item = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [Food.self, UIImage.self, NSArray.self, Order.self], from: data) as? [Order] {
//            self.orders = item
//        }
        if let account = user.account,
           let userInfo = MyAppearence.restaurantUserInfo[account] as? Dictionary<String, Any>,
           let orders = userInfo["orders"] as? [Order] {
            self.orders = orders
        }
        if isFirstEnter {
            makeSubViews()
            isFirstEnter = false
        }
        orderTableView.reloadData()
        title = "全部订单(\(orders.count))"
        tabBarItem.title = "订单管理"
        updateWaitTreatLabel()
    }
}

extension OrderManageViewController {
    func updateWaitTreatLabel() {
        var count = 0
        for order in orders {
            if order.state == .waitTreat {
                count += 1
            }
        }
        waitTreatOrderLabel.text = "待确认订单数量(\(count))"
    }
    
    func makeSubViews() {
        view.addSubview(waitTreatOrderLabel)
        view.addSubview(orderTableView)
        
        waitTreatOrderLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20.0)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        orderTableView.snp.makeConstraints { make in
            make.top.equalTo(waitTreatOrderLabel.snp.bottom).offset(20.0)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension OrderManageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count > 0 ? orders.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if orders.count > 0 {
            let orderCell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as? OrderTableViewCell
            orderCell?.setViewWith(order: orders[indexPath.row], role: role)
            orderCell?.orderConfirmBlock = { [unowned self] in
                let alert = UIAlertController(title: "提示", message: "是否确认订单已经完成", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "点错了", style: .cancel)
                let action2 = UIAlertAction(title: "确认", style: .default) { _ in
                    self.orders[indexPath.row].state = (role == .manager ? .waitTreat : .finished)
                    self.enterBackground()
                    self.orderTableView.reloadData()
                }
                
                alert.addAction(action1)
                alert.addAction(action2)
                self.present(alert, animated: true, completion: nil)
            }
            return orderCell ?? UITableViewCell()
        }
        else if let emptyCell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath) as? EmptyCell {
            emptyCell.emptyImageView.image = UIImage(named: "order_empty")
            emptyCell.emptyLabel.text = "还没有订单～"
            return emptyCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailViewController = OrderDetailViewController(order: orders[indexPath.row])
        navigationController?.pushViewController(orderDetailViewController, animated: true)
    }
}

class OrderDetailViewController: UIViewController {
    var order: Order
    
    init(order: Order) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var serialNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.text = "订单编号："
        label.textColor = .black
        return label
    }()
    
    lazy var siteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.text = "座位号："
        label.textColor = .black
        return label
    }()
    
    lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.text = "总价格："
        label.textColor = .black
        return label
    }()
    
    lazy var orderStateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.text = "订单状态："
        label.textColor = .black
        return label
    }()
    
    var foodTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200.0
        tableView.register(FoodDetailTableCell.self, forCellReuseIdentifier: "foodDetailCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        foodTableView.delegate = self
        foodTableView.dataSource = self
        makeSubViews()
        
        serialNumberLabel.text = "订单编号：\(order.serialNumber)"
        siteLabel.text = "座位：\(order.site ?? "无")"
        totalPriceLabel.text = "总价格\(order.totalPrice ?? 0.0)"
        switch order.state {
            case .submited:
                orderStateLabel.text = "订单状态：等待管理员确认"
            case .waitTreat:
                orderStateLabel.text = "订单状态：等待服务员确认"
            case .finished:
                orderStateLabel.text = "订单状态：订单已完成"
            default:
                orderStateLabel.text = "订单状态：未知"
        }
    }
}

extension OrderDetailViewController {
    func makeSubViews() {
        view.addSubview(serialNumberLabel)
        view.addSubview(siteLabel)
        view.addSubview(totalPriceLabel)
        view.addSubview(orderStateLabel)
        view.addSubview(foodTableView)
        
        serialNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20.0)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20.0)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
        }
        
        siteLabel.snp.makeConstraints { make in
            make.top.equalTo(serialNumberLabel.snp.bottom).offset(10.0)
            make.left.right.equalTo(serialNumberLabel)
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(siteLabel.snp.bottom).offset(10.0)
            make.left.right.equalTo(siteLabel)
        }
        
        orderStateLabel.snp.makeConstraints { make in
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(10.0)
            make.left.right.equalTo(totalPriceLabel)
        }
        
        foodTableView.snp.makeConstraints { make in
            make.top.equalTo(orderStateLabel.snp.bottom).offset(10.0)
            make.left.bottom.right.equalTo(view)
        }
    }
}

extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let foodCell = tableView.dequeueReusableCell(withIdentifier: "foodDetailCell", for: indexPath) as? FoodDetailTableCell {
            foodCell.setWithFoodItem(item: order.menu[indexPath.row])
            return foodCell
        }
        return UITableViewCell()
    }
}
