//
//  FoodTableViewCell.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2022/1/24.
//

import Foundation
import SnapKit
import UIKit
import PKHUD

typealias EditFoodBlock = () -> Void
typealias UpdateFoodBlock = (_ add: Bool) -> Void
class FoodTableViewCell: UITableViewCell {
    var editBlock: EditFoodBlock?
    var deleteBlock: EditFoodBlock?
    var isOrder = false
    var updateFoodBlock: UpdateFoodBlock?
    var food: Food?
    
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
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    lazy var countLabel: UILabel = {
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
    
    lazy var subContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "food_edit"), for: .normal)
        button.addTarget(self, action: #selector(editFoodItem), for: .touchUpInside)
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "food_delete"), for: .normal)
        button.addTarget(self, action: #selector(deleteFoodItem), for: .touchUpInside)
        return button
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cell_food_add"), for: .normal)
        button.addTarget(self, action: #selector(updateFoodCount(button:)), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    lazy var foodCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 8.0
        label.layer.borderColor = MyAppearence.brandColor.cgColor
        return label
    }()
    
    lazy var reduceButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cell_food_reduce"), for: .normal)
        button.addTarget(self, action: #selector(updateFoodCount(button:)), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    
    @objc
    func updateFoodCount(button: UIButton) {
        if button.tag == 1 {
            updateFoodBlock?(true)
        }
        else {
            updateFoodBlock?(false)
        }
    }

    @objc
    func editFoodItem() {
        editBlock?()
    }
    
    @objc
    func deleteFoodItem() {
        deleteBlock?()
    }
    
    func setWithFoodItem(item: Food, order: Bool) {
        food = item
        isOrder = order
        nameLabel.text = item.name
        priceLabel.text = "价格：\(item.price ?? "")"
        descriptionLabel.text = item.foodDescription
        foodImageView.image = item.photo
        countLabel.text = "剩余数量：\(item.foodCount)"
        foodCountLabel.text = "\(item.needCount)"
        makeFuncButtonView()
    }
    
    func makeSubViews() {
        contentView.backgroundColor = MyAppearence.containerBackground
        contentView.addSubview(foodImageView)
        contentView.addSubview(subContainerView)
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(countLabel)
        containerView.addSubview(descriptionLabel)
        
        foodImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10.0)
            make.top.greaterThanOrEqualTo(contentView).offset(10.0)
            make.bottom.lessThanOrEqualTo(contentView).offset(-10.0)
            make.centerY.equalTo(contentView)
            make.height.width.equalTo(64.0)
        }
        
        subContainerView.snp.makeConstraints { make in
            make.centerY.equalTo(foodImageView)
            make.right.equalTo(contentView).offset(-10.0)
            make.top.equalTo(contentView).offset(10.0)
            make.bottom.equalTo(contentView).offset(-10.0)
            make.width.equalTo(64.0)
        }
        
        containerView.snp.makeConstraints { make in
            make.left.equalTo(foodImageView.snp.right).offset(10.0)
            make.top.greaterThanOrEqualTo(contentView).offset(10.0)
            make.bottom.lessThanOrEqualTo(contentView).offset(-10.0)
            make.right.equalTo(subContainerView.snp.left).offset(-5.0)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(containerView).offset(20.0)
            make.right.equalTo(containerView).offset(-10.0)
            make.top.equalTo(containerView).offset(10.0)
            make.height.equalTo(32.0)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5.0)
            make.left.height.right.equalTo(nameLabel)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5.0)
            make.left.right.height.equalTo(priceLabel)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(countLabel)
            make.top.equalTo(countLabel.snp.bottom).offset(10.0)
            make.bottom.equalTo(containerView).offset(-10.0)
        }
    }
    
    func makeFuncButtonView() {
        if isOrder {
            subContainerView.addSubview(foodCountLabel)
            subContainerView.addSubview(addButton)
            subContainerView.addSubview(reduceButton)
            
            foodCountLabel.snp.makeConstraints { make in
                make.center.equalTo(subContainerView)
                make.height.equalTo(24.0)
                make.width.equalTo(subContainerView).multipliedBy(0.8)
            }
            
            addButton.snp.makeConstraints { make in
                make.centerX.equalTo(foodCountLabel)
                make.bottom.equalTo(foodCountLabel.snp.top).offset(-5.0)
            }
            
            reduceButton.snp.makeConstraints { make in
                make.centerX.equalTo(addButton)
                make.top.equalTo(foodCountLabel.snp.bottom).offset(5.0)
            }
        }
        else {
            subContainerView.addSubview(editButton)
            subContainerView.addSubview(deleteButton)
            
            deleteButton.snp.makeConstraints { make in
                make.centerX.equalTo(subContainerView)
                make.top.equalTo(subContainerView).offset(20.0)
            }
            
            editButton.snp.makeConstraints { make in
                make.centerX.equalTo(deleteButton)
                make.bottom.equalTo(subContainerView).offset(-20.0)
            }
        }
    }
}

class EmptyCell: UITableViewCell {
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
        return view
    }()
    
    lazy var emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "food_empty")
        return imageView
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = MyAppearence.brandColor
        label.text = "还没有添加餐品"
        label.textAlignment = .center
        return label
    }()
    
    func makeSubViews() {
        contentView.addSubview(containerView)
        contentView.backgroundColor = .white
        containerView.addSubview(emptyImageView)
        containerView.addSubview(emptyLabel)
        
        containerView.snp.makeConstraints { make in
            make.width.equalTo(contentView)
            make.height.equalTo(460.0)
            make.center.equalTo(contentView)
            make.top.equalTo(contentView).offset(20.0)
            make.bottom.equalTo(contentView).offset(-20.0)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.center.equalTo(containerView)
            make.width.height.equalTo(80.0)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(20.0)
            make.centerX.equalTo(emptyImageView)
        }
    }
}
