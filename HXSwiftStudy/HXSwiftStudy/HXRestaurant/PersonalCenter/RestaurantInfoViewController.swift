//
//  RestaurantInfoViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2022/2/14.
//

import Foundation
import SnapKit
import UIKit
import PKHUD

class RestaurantInfoViewController: UIViewController {
    var restaurant: Restaurant?
    var user: User
    
    init(restaurant: Restaurant?, user: User) {
        self.restaurant = restaurant
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var restaruantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 8.0
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "login_restaurant")
        return imageView
    }()
    
    lazy var choseRestaurantImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("设置餐厅照片", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = MyAppearence.brandColor
        button.tag = 2
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        button.addTarget(self, action: #selector(takePicker), for: .touchUpInside)
        return button
    }()
    
    lazy var restaurantNameLabel: UILabel = {
        let label = UILabel()
        label.text = "餐厅名："
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var restaurantNameTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "请输入餐厅的名称"
        return textField
    }()
    
    lazy var restaurantDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "餐厅描述：(最多输入100个字)"
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    lazy var restaurantDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 4.0
        textView.keyboardType = .default
        textView.returnKeyType = .done
        textView.isEditable = true
        textView.font = UIFont.systemFont(ofSize: 16.0)
        textView.delegate = self
        return textView
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("确认", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = MyAppearence.brandColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeSubViews()
    }
}

extension RestaurantInfoViewController {
    func makeSubViews() {
        if user.role == .manager, let restaurant = self.restaurant {
            makeManagerViews(restaurant: restaurant)
        }
        else {
            if let restaurant = self.restaurant {
                makeWaiterViews(restaurant: restaurant)
            }
            else {
                makeEmptyViews()
            }
        }
    }
    
    func makeManagerViews(restaurant: Restaurant) {
        restaruantImageView.image = restaurant.photo
        restaurantNameTextField.text = "\(restaurant.name ?? "")"
        restaurantDescriptionTextView.text = "\(restaurant.restaurantDescription ?? "")"
        confirmButton.setTitle("确认", for: .normal)
        confirmButton.addTarget(self, action: #selector(changeRestaurantInfo), for: .touchUpInside)
        
        view.addSubview(restaruantImageView)
        restaruantImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.height.equalTo(120.0)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20.0)
        }
        
        view.addSubview(choseRestaurantImageButton)
        choseRestaurantImageButton.snp.makeConstraints { make in
            make.height.equalTo(32.0)
            make.left.equalTo(restaruantImageView.snp.right).offset(10.0)
            make.width.equalTo(120.0)
            make.bottom.equalTo(restaruantImageView).offset(-20.0)
        }
        
        view.addSubview(restaurantNameLabel)
        restaurantNameLabel.snp.makeConstraints { make in
            make.width.equalTo(70.0)
            make.left.equalTo(view).offset(20.0)
            make.height.equalTo(36.0)
            make.top.equalTo(restaruantImageView.snp.bottom).offset(20.0)
        }
        
        view.addSubview(restaurantNameTextField)
        restaurantNameTextField.snp.makeConstraints { make in
            make.centerY.height.equalTo(restaurantNameLabel)
            make.left.equalTo(restaurantNameLabel.snp.right).offset(5.0)
            make.right.equalTo(view).offset(-20.0)
        }
        
        view.addSubview(restaurantDescriptionLabel)
        restaurantDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(restaurantNameTextField.snp.bottom).offset(20.0)
            make.left.equalTo(restaurantNameLabel)
            make.right.equalTo(view).offset(-20.0)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
            make.width.equalTo(150.0)
            make.height.equalTo(48.0)
        }
        
        view.addSubview(restaurantDescriptionTextView)
        restaurantDescriptionTextView.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.8)
            make.centerX.equalTo(view)
            make.top.equalTo(restaurantDescriptionLabel.snp.bottom).offset(10.0)
            make.bottom.equalTo(confirmButton.snp.top).offset(-10.0)
        }
    }
    
    func makeWaiterViews(restaurant: Restaurant) {
        restaruantImageView.image = restaurant.photo
        restaurantNameLabel.text = "餐厅名：\(restaurant.name ?? "")"
        restaurantDescriptionTextView.isEditable = false
        restaurantDescriptionTextView.text = "餐厅描述：\n\(restaurant.restaurantDescription ?? "")"
        confirmButton.setTitle("退出该餐厅", for: .normal)
        confirmButton.addTarget(self, action: #selector(removeRestaurant), for: .touchUpInside)
    
        view.addSubview(restaruantImageView)
        view.addSubview(restaurantNameLabel)
        view.addSubview(restaurantDescriptionTextView)
        view.addSubview(confirmButton)
        
        restaruantImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40.0)
            make.width.height.equalTo(120.0)
        }
        
        restaurantNameLabel.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(40.0)
            make.top.equalTo(restaruantImageView.snp.bottom).offset(20.0)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
            make.width.equalTo(150.0)
            make.height.equalTo(48.0)
        }
        
        restaurantDescriptionTextView.snp.makeConstraints { make in
            make.left.equalTo(restaurantNameLabel)
            make.top.equalTo(restaurantNameLabel.snp.bottom).offset(20.0)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-40.0)
            make.bottom.equalTo(confirmButton.snp.top).offset(-20.0)
        }
    }
    
    func makeEmptyViews() {
        let emptyImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "restaurant_empty")
            return imageView
        }()
        
        let emptyLabel: UILabel = {
            let label = UILabel()
            label.text = "你还没有被加入任何餐厅～"
            label.textColor = MyAppearence.brandColor
            label.font = UIFont.systemFont(ofSize: 16.0)
            return label
        }()
        
        view.addSubview(emptyImageView)
        view.addSubview(emptyLabel)
        
        emptyImageView.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(emptyImageView.snp.bottom).offset(5.0)
        }
    }
    
    @objc
    func changeRestaurantInfo() {
        restaurant = Restaurant(name: restaurantNameLabel.text ?? "", restaurantDescription: restaurantDescriptionTextView.text ?? "", photo: restaruantImageView.image!)
        var restaurantUserInfo = MyAppearence.restaurantUserInfo
        if let account = user.account,
           var userInfo = restaurantUserInfo[account] as? Dictionary<String, Any> {
            userInfo.updateValue(restaurant ?? "NULL", forKey: "restaurant")
            restaurantUserInfo.updateValue(userInfo, forKey: account)
            if let waiters = userInfo["waiters"] as? [User] {
                for user in waiters {
                    if var userInfo = restaurantUserInfo[user.account!] as? Dictionary<String, Any> {
                        userInfo.updateValue(restaurant ?? "NULL", forKey: "restaurant")
                        restaurantUserInfo.updateValue(userInfo, forKey: user.account!)
                    }
                }
            }
            let data = try? NSKeyedArchiver.archivedData(withRootObject: restaurantUserInfo, requiringSecureCoding: true)
            UserDefaults.standard.set(data, forKey: "restaurantUserInfo")
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func removeRestaurant() {
        var restaurantUserInfo = MyAppearence.restaurantUserInfo
        if let account = user.account,
           var userInfo = restaurantUserInfo[account] as? Dictionary<String, Any> {
            userInfo.removeValue(forKey: "restaurant")
            restaurantUserInfo.updateValue(userInfo, forKey: account)
            let data = try? NSKeyedArchiver.archivedData(withRootObject: restaurantUserInfo, requiringSecureCoding: true)
            UserDefaults.standard.set(data, forKey: "restaurantUserInfo")
        }
        
        navigationController?.popViewController(animated: true)
    }
}

extension RestaurantInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc
    func takePicker() {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alert = UIAlertController(title: "选取照片", message: "请选择获取照片的方式", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "拍照", style: .default) { _ in
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            }
            
            let action2 = UIAlertAction(title: "打开相册", style: .default) { _ in
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            }
            
            alert.addAction(action1)
            alert.addAction(action2)
            present(alert, animated: true, completion: nil)
        }
        else {
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //协议方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage]
        restaruantImageView.image = image as? UIImage
        dismiss(animated: true, completion: nil)
    }
}

extension RestaurantInfoViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return restaurantDescriptionTextView.text.count + (text.count - range.length) <= 100
    }
}
