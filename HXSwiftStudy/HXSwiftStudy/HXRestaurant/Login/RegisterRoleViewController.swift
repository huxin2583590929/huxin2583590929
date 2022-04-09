//
//  RegisterRoleViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2022/1/21.
//

import Foundation
import SnapKit
import UIKit
import PKHUD
import CloudKit

enum UserType: String {
    case manager = "manager"
    case waiter = "waiter"
}

class User: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var name: String?
    var phoneNumber: String?
    var role: UserType?
    var avatar: UIImage?
    var account: String?
    
    init(name: String, phoneNumber: String, account: String, role: UserType, avatar: UIImage) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.account = account
        self.role = role
        self.avatar = avatar
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(phoneNumber, forKey: "phoneNumber")
        coder.encode(role?.rawValue, forKey: "role")
        coder.encode(avatar, forKey: "avatar")
        coder.encode(account, forKey: "account")
    }
    
    required init?(coder: NSCoder) {
        super.init()
        name = coder.decodeObject(forKey: "name") as? String
        phoneNumber = coder.decodeObject(forKey: "phoneNumber") as? String
        role = UserType(rawValue: (coder.decodeObject(forKey: "role") as? String) ?? "waiter")
        avatar = coder.decodeObject(forKey: "avatar") as? UIImage
        account = coder.decodeObject(forKey: "account") as? String
    }
}

class Restaurant: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var name: String?
    var photo: UIImage?
    var restaurantDescription: String?
    var menu = [Food]()
    
    init(name: String, restaurantDescription: String, photo: UIImage) {
        self.name = name
        self.restaurantDescription = restaurantDescription
        self.photo = photo
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(restaurantDescription, forKey: "restaurantDescription")
        coder.encode(photo, forKey: "photo")
        coder.encode(menu, forKey: "menu")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String
        restaurantDescription = coder.decodeObject(forKey: "restaurantDescription") as? String
        photo = coder.decodeObject(forKey: "photo") as? UIImage
        menu = (coder.decodeObject(forKey: "menu") as? [Food]) ?? [Food]()
    }
}

typealias ConfirmBlock = (_ user: User, _ restaurant: Restaurant?) -> Void
class RegisterRoleViewController: UIViewController {
    var role: UserType?
    var account: String?
    var tag = 1
    var user: User?
    var restaurant: Restaurant?
    var confirmBlock: ConfirmBlock?
    
    init(role: UserType, account: String) {
        self.role = role
        self.account = account
        super.init(nibName: nil, bundle: nil)
    }
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)

        makeCommonView()
        if let user = self.user {
            avatarImageView.image = user.avatar
            nameTextField.text = user.name
            phoneNumberTextField.text = user.phoneNumber
        }
        
        guard role == .manager else { return }
        makeManagerView()
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 6.0
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "register_avatar_placeholder")
        return imageView
    }()
    
    lazy var choseImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("选择照片", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = MyAppearence.brandColor
        button.tag = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        button.addTarget(self, action: #selector(takePicker(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "姓名："
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var nameTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "请输入自己的姓名"
        return textField
    }()
    
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "电话："
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var phoneNumberTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "请输入正确的电话号码"
        return textField
    }()
    
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
        button.addTarget(self, action: #selector(takePicker(button:)), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(checkForRegister), for: .touchUpInside)
        return button
    }()
    
    func makeCommonView() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            if role == .manager {
                make.top.equalTo(view).offset(40.0)
            }
            else {
                make.centerY.equalTo(view)
            }
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(260.0)
        }
        
        let closeButton: UIButton = {
           let button = UIButton()
            button.setImage(UIImage(named: "close"), for: .normal)
            button.addTarget(self, action: #selector(closeRoleSet), for: .touchUpInside)
            return button
        }()
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10.0)
            make.right.equalTo(view).offset(-20.0)
            make.width.height.equalTo(24.0)
        }
        
        containerView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.top.equalTo(containerView).offset(20.0)
            make.width.height.equalTo(100.0)
        }
        
        containerView.addSubview(choseImageButton)
        choseImageButton.snp.makeConstraints { make in
            make.bottom.equalTo(avatarImageView).offset(-10.0)
            make.left.equalTo(avatarImageView.snp.right).offset(20.0)
            make.width.equalTo(80.0)
            make.height.equalTo(32.0)
        }
        
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(role == .manager ? 20.0 : 40.0)
            make.left.equalTo(containerView).offset(20.0)
            make.width.equalTo(60.0)
            make.height.equalTo(32.0)
        }
        
        containerView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.centerY.height.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(1.0)
            make.right.equalTo(containerView).offset(-10.0)
        }
        
        containerView.addSubview(phoneNumberLabel)
        phoneNumberLabel.snp.makeConstraints { make in
            make.centerX.width.height.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(role == .manager ? 20.0 : 40.0)
        }
        
        containerView.addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints { make in
            make.centerX.width.height.equalTo(nameTextField)
            make.centerY.equalTo(phoneNumberLabel)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            if role == .manager {
                make.bottom.equalTo(view).offset(-20.0)
            }
            else {
                make.top.equalTo(containerView.snp.bottom).offset(20.0)
            }
            make.centerX.equalTo(view)
            make.height.equalTo(32.0)
            make.width.equalTo(120.0)
        }
    }
    
    func makeManagerView() {
        view.addSubview(restaruantImageView)
        restaruantImageView.snp.makeConstraints { make in
            make.centerX.width.height.equalTo(avatarImageView)
            make.top.equalTo(containerView.snp.bottom).offset(20.0)
        }
        
        view.addSubview(choseRestaurantImageButton)
        choseRestaurantImageButton.snp.makeConstraints { make in
            make.height.equalTo(choseImageButton)
            make.left.equalTo(restaruantImageView.snp.right).offset(10.0)
            make.width.equalTo(120.0)
            make.bottom.equalTo(restaruantImageView).offset(-20.0)
        }
        
        view.addSubview(restaurantNameLabel)
        restaurantNameLabel.snp.makeConstraints { make in
            make.centerX.height.right.equalTo(nameLabel)
            make.width.equalTo(70.0)
            make.top.equalTo(restaruantImageView.snp.bottom).offset(20.0)
        }
        
        view.addSubview(restaurantNameTextField)
        restaurantNameTextField.snp.makeConstraints { make in
            make.centerY.height.equalTo(restaurantNameLabel)
            make.left.right.equalTo(nameTextField)
        }
        
        view.addSubview(restaurantDescriptionTextView)
        restaurantDescriptionTextView.snp.makeConstraints { make in
            make.width.equalTo(containerView).multipliedBy(0.8)
            make.centerX.equalTo(view).offset(40.0)
            make.top.equalTo(restaurantNameTextField.snp.bottom).offset(20.0)
            make.bottom.equalTo(confirmButton.snp.top).offset(-10.0)
        }
        
        lazy var restaurantDescriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "餐厅描述：(最多输入100个字)"
            label.textColor = .black
            label.textAlignment = .right
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 14.0)
            return label
        }()
        view.addSubview(restaurantDescriptionLabel)
        restaurantDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(restaurantDescriptionTextView)
            make.width.equalTo(80.0)
            make.left.equalTo(containerView)
            make.right.equalTo(restaurantDescriptionTextView.snp.left).offset(-5.0)
        }
    }
}

extension RegisterRoleViewController {
    @objc
    func checkForRegister() {
        if (nameTextField.text ?? "").isEmpty {
            HUD.flash(.label("名字不能为空"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
            return
        }
        else if !isChinese(str: nameTextField.text ?? "") {
            HUD.flash(.label("名字必须都是汉字"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
            return
        }
        if (phoneNumberTextField.text ?? "").isEmpty {
            HUD.flash(.label("电话号码不能为空"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
            return
        }
        else if !isPhoneNumber(phoneNumber: phoneNumberTextField.text ?? "") {
            HUD.flash(.label("请输入正确的电话号码"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
            return
        }
        if role == .manager && (restaurantNameTextField.text ?? "").isEmpty {
            HUD.flash(.label("餐厅名字不能为空"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
        }
        
        var user: User
        user = User(name: nameTextField.text!, phoneNumber: phoneNumberTextField.text!, account: account ?? "", role: role ?? .waiter, avatar: avatarImageView.image!)
        restaurant = Restaurant(name: restaurantNameTextField.text!, restaurantDescription: restaurantDescriptionTextView.text, photo: restaruantImageView.image!)
        confirmBlock?(user, restaurant)
    }
    
    @objc
    func hideKeyboard() {
        nameTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        restaurantNameTextField.resignFirstResponder()
        restaurantDescriptionTextView.resignFirstResponder()
    }
    
    @objc
    func closeRoleSet() {
        dismiss(animated: true, completion: nil)
    }
    
    func isChinese(str: String) -> Bool{
        let match: String = "(^[\\u4e00-\\u9fa5]+$)"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: str)
    }
    
    func isPhoneNumber(phoneNumber:String) -> Bool {
        let mobile = "1(3[0-9]|4[579]|5[0-35-9]|6[6]|7[0-35-9]|8[0-9]|9[89])\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        return regexMobile.evaluate(with: phoneNumber)
    }
}

extension RegisterRoleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc
    func takePicker(button: UIButton) {
        tag = button.tag
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
        let imageView = tag == 1 ? avatarImageView : restaruantImageView
        imageView.image = image as? UIImage
        dismiss(animated: true, completion: nil)
    }
}

extension RegisterRoleViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return restaurantDescriptionTextView.text.count + (text.count - range.length) <= 100
    }
}
