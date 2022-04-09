//
//  OrderTableViewCell.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2022/2/11.
//

import Foundation
import SnapKit
import UIKit
import PKHUD

typealias EditOrderBlock = () -> Void
class OrderTableViewCell: UITableViewCell {
    var order: Order?
    var orderConfirmBlock: EditOrderBlock?
    
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
    
//    lazy var serialNumberLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .left
//        label.font = UIFont.systemFont(ofSize: 16.0)
//        label.text = "订单编号："
//        label.textColor = .black
//        return label
//    }()
    
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
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("订单已完成", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isHidden = true
        button.backgroundColor = MyAppearence.brandColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(confirmOrder), for: .touchUpInside)
        return button
    }()
    
    func makeSubViews() {
        contentView.backgroundColor = MyAppearence.containerBackground
        contentView.addSubview(containerView)
        //containerView.addSubview(serialNumberLabel)
        containerView.addSubview(siteLabel)
        containerView.addSubview(totalPriceLabel)
        containerView.addSubview(orderStateLabel)
        containerView.addSubview(confirmButton)
        
        containerView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10.0)
            make.top.greaterThanOrEqualTo(contentView).offset(10.0)
            make.bottom.lessThanOrEqualTo(contentView).offset(-10.0)
            make.right.equalTo(contentView).offset(-10.0)
            make.height.equalTo(150.0)
        }
        
//        serialNumberLabel.snp.makeConstraints { make in
//            make.top.equalTo(containerView).offset(20.0)
//            make.left.equalTo(containerView).offset(20.0)
//            make.height.equalTo(32.0)
//            make.right.equalTo(containerView).offset(-20.0)
//        }
        
        siteLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(20.0)
            make.left.equalTo(containerView).offset(20.0)
            make.height.equalTo(32.0)
            make.right.equalTo(containerView).offset(-20.0)
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.left.right.height.equalTo(siteLabel)
            make.top.equalTo(siteLabel.snp.bottom).offset(10.0)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.right.equalTo(containerView).offset(-10.0)
            make.bottom.equalTo(containerView).offset(-20.0)
            make.width.equalTo(150.0)
        }
        
        orderStateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(confirmButton)
            make.left.height.equalTo(totalPriceLabel)
            make.right.equalTo(confirmButton.snp.left).offset(-10.0)
        }
    }
    
    func setViewWith(order: Order, role: UserType) {
        //serialNumberLabel.text = order.serialNumber
        siteLabel.text = "座位：\(order.site ?? "无")"
        totalPriceLabel.text = "总价格：\(order.totalPrice ?? 0.0)"
        confirmButton.isHidden = true
        switch order.state {
            case .submited:
                orderStateLabel.text = "订单状态：等待管理员确认"
                if role == .manager {
                    confirmButton.isHidden = false
                }
            case .waitTreat:
                orderStateLabel.text = "订单状态：等待服务员确认"
                if role == .waiter {
                    confirmButton.isHidden = false
                }
            case .finished:
                orderStateLabel.text = "订单状态：订单已完成"
            default:
                orderStateLabel.text = "订单状态：未知"
        }
    }
    
    @objc
    func confirmOrder() {
        orderConfirmBlock?()
    }
}

class FoodDetailTableCell: UITableViewCell {
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
    
    lazy var priceLabel: UILabel = {
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
        return imageview
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        return label
    }()

    func makeSubViews() {
        contentView.addSubview(foodImageView)
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(countLabel)
        
        foodImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10.0)
            make.top.greaterThanOrEqualTo(contentView).offset(10.0)
            make.bottom.lessThanOrEqualTo(contentView).offset(-10.0)
            make.centerY.equalTo(contentView)
            make.height.width.equalTo(64.0)
        }
        
        containerView.snp.makeConstraints { make in
            make.left.equalTo(foodImageView.snp.right).offset(10.0)
            make.top.greaterThanOrEqualTo(contentView).offset(10.0)
            make.bottom.lessThanOrEqualTo(contentView).offset(-10.0)
            make.right.equalTo(contentView).offset(-10.0)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(foodImageView)
            make.left.equalTo(containerView)
            make.height.equalTo(32.0)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(foodImageView)
            make.left.height.equalTo(nameLabel)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(foodImageView)
            make.right.equalTo(containerView)
        }
    }
    
    func setWithFoodItem(item: Food) {
        nameLabel.text = item.name
        priceLabel.text = "价格：\(item.price ?? "")"
        foodImageView.image = item.photo
        countLabel.text = "x \(item.needCount)"
    }
}
