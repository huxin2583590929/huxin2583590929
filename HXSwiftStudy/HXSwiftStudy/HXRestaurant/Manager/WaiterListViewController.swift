//
//  WaiterListViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2022/2/22.
//

import Foundation
import SnapKit
import UIKit
import PKHUD

class WaiterListViewController: UIViewController {
    var users = [User]()
    
    init(users: [User]) {
        self.users = users
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var waiterTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 80.0
        tableView.register(WaiterInfoCell.self, forCellReuseIdentifier: "itemCell")
        tableView.register(EmptyCell.self, forCellReuseIdentifier: "emptyCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waiterTableView.delegate = self
        waiterTableView.dataSource = self
        makeSubViews()
    }
    
    func makeSubViews() {
        view.backgroundColor = .white
        view.addSubview(waiterTableView)
        waiterTableView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension WaiterListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count > 0 ? users.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if users.count > 0,
            let waiterCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? WaiterInfoCell {
            waiterCell.setViewWith(user: users[indexPath.row])
            return waiterCell
        }
        else if let emptyCell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath) as? EmptyCell {
            emptyCell.emptyImageView.image = UIImage(named: "waiter_empty")
            emptyCell.emptyLabel.text = "还没有添加服务员"
            return emptyCell
        }
        return UITableViewCell()
    }
}

class WaiterInfoCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8.0
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        return label
    }()
    
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        return label
    }()

    lazy var foodImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.cornerRadius = 8.0
        imageview.layer.masksToBounds = true
        imageview.layer.borderWidth = 0.5
        imageview.layer.borderColor = UIColor.black.cgColor
        imageview.image = UIImage(named: "waiter_empty")
        return imageview
    }()
    
    func makeSubViews() {
        contentView.backgroundColor = MyAppearence.containerBackground
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(phoneNumberLabel)
        containerView.addSubview(foodImageView)
        
        containerView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10.0)
            make.top.greaterThanOrEqualTo(contentView).offset(10.0)
            make.bottom.lessThanOrEqualTo(contentView).offset(-10.0)
            make.height.equalTo(150.0)
            make.right.equalTo(contentView).offset(-10.0)
        }
        
        foodImageView.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.left.equalTo(containerView).offset(20.0)
            make.width.height.equalTo(84.0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(foodImageView).offset(10.0)
            make.left.equalTo(foodImageView.snp.right).offset(30.0)
            make.right.equalTo(containerView).offset(-10.0)
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20.0)
            make.left.right.equalTo(nameLabel)
        }
    }
    
    func setViewWith(user: User) {
        foodImageView.image = user.avatar
        nameLabel.text = "姓名：\(user.name ?? "无")"
        phoneNumberLabel.text = "电话号码：\(user.phoneNumber ?? "空")"
    }
}
