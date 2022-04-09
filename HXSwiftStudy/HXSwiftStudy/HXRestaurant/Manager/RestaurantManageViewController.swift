//
//  RestaurantManageViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2022/1/24.
//

import Foundation
import SnapKit
import UIKit
import PKHUD

class Food: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var name: String?
    var photo: UIImage?
    var price: String?
    var foodDescription: String?
    var foodCount: Int64
    var needCount: Int64 = 0
    
    init(name: String, price: String, foodDescription: String, count: Int64, photo: UIImage) {
        self.name = name
        self.price = price
        self.foodCount = count
        self.photo = photo
        self.foodDescription = foodDescription
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(photo, forKey: "photo")
        coder.encode(price, forKey: "price")
        coder.encode(foodDescription, forKey: "foodDescription")
        coder.encode(foodCount, forKey: "foodCount")
        coder.encode(needCount, forKey: "foodNeedCount")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String
        photo = coder.decodeObject(forKey: "photo") as? UIImage
        price = coder.decodeObject(forKey: "price") as? String
        foodDescription = coder.decodeObject(forKey: "foodDescription") as? String
        foodCount = coder.decodeInt64(forKey: "foodCount")
        needCount = coder.decodeInt64(forKey: "foodNeedCount")
    }
}

class RestaurantManageViewController: UIViewController {
    var restaurant: Restaurant
    var user: User
    
    init(user: User) {
        self.user = user
        if let account = user.account,
           let userInfo = MyAppearence.restaurantUserInfo[account] as? Dictionary<String, Any>,
           let restaurant = userInfo["restaurant"] as? Restaurant {
            self.restaurant = restaurant
        }
        else {
            self.restaurant = Restaurant(name: "餐厅名字",
                                         restaurantDescription: "你还没有创建餐厅～",
                                         photo: UIImage(named: "login_restaurant")!)
        }
           
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "餐品管理", image: UIImage(named: "foods"), tag: 101)
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
            userInfo.updateValue(restaurant, forKey: "restaurant")
            restaurantUserInfo.updateValue(userInfo, forKey: account)
            if let waiters = userInfo["waiters"] as? [User] {
                for user in waiters {
                    if var info = restaurantUserInfo[user.account!] as? Dictionary<String, Any> {
                        info.updateValue(restaurant, forKey: "restaurant")
                        restaurantUserInfo.updateValue(info, forKey: user.account!)
                    }
                }
            }
            let data = try? NSKeyedArchiver.archivedData(withRootObject: restaurantUserInfo, requiringSecureCoding: true)
            UserDefaults.standard.set(data, forKey: "restaurantUserInfo")
        }
    }
    
    lazy var topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "#ECF0F1")
        return view
    }()
    
    lazy var restaurantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8.0
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    lazy var restaurantNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.textColor = MyAppearence.brandColor
        label.numberOfLines = 2
        return label
    }()
    
    lazy var restaurantDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.text = "没有添加任何描述～"
        label.numberOfLines = 0
        label.textColor = .black.withAlphaComponent(0.6)
        label.layer.cornerRadius = 8.0
        return label
    }()
    
    var foodTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200.0
        tableView.register(FoodTableViewCell.self, forCellReuseIdentifier: "foodCell")
        tableView.register(EmptyCell.self, forCellReuseIdentifier: "emptyCell")
        return tableView
    }()
    
    lazy var addFoodButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "food_add"), for: .normal)
        button.addTarget(self, action: #selector(addNewFood), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        foodTableView.dataSource = self
        foodTableView.delegate = self
        print("user: %@\n userInfo: %@",  UserDefaults.standard.object(forKey: "restaurantUser") ?? "NULL", UserDefaults.standard.object(forKey: "restaurantUserInfo") ?? "NULL")
        makeSubViews()
    }
}

extension RestaurantManageViewController {
    func makeSubViews() {
        restaurantImageView.image = restaurant.photo
        restaurantNameLabel.text = restaurant.name
        restaurantDescriptionLabel.text = restaurant.restaurantDescription
        view.addSubview(topContainerView)
        topContainerView.addSubview(restaurantImageView)
        topContainerView.addSubview(restaurantNameLabel)
        topContainerView.addSubview(restaurantDescriptionLabel)
        view.addSubview(foodTableView)
        view.addSubview(addFoodButton)
        
        topContainerView.snp.makeConstraints { make in
            make.left.right.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(180.0)
        }
        
        restaurantImageView.snp.makeConstraints { make in
            make.top.equalTo(topContainerView).offset(20.0)
            make.left.equalTo(topContainerView).offset(40.0)
            make.width.height.equalTo(64.0)
        }
        
        restaurantNameLabel.snp.makeConstraints { make in
            make.top.equalTo(restaurantImageView).offset(10.0)
            make.left.equalTo(restaurantImageView.snp.right).offset(30.0)
            make.right.equalTo(topContainerView).offset(-20.0)
        }
        
        restaurantDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(restaurantImageView.snp.bottom).offset(10.0)
            make.left.equalTo(topContainerView).offset(20.0)
            make.right.equalTo(restaurantNameLabel)
            make.bottom.equalTo(topContainerView).offset(-10.0)
        }
        
        foodTableView.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
        
        addFoodButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
            make.left.equalTo(view).offset(20.0)
        }
    }
    
    @objc
    func addNewFood() {
        let foodUpdateView = FoodDetaileViewController(edit: false)
        foodUpdateView.updateFoodBlock = { [unowned self] item in
            self.restaurant.menu.append(item)
            self.foodTableView.reloadData()
        }
        navigationController?.pushViewController(foodUpdateView, animated: true)
    }
    
    func deleteFood(index: Int) {
        let alert = UIAlertController(title: "提示", message: "是否确认删除该餐品", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "点错了", style: .cancel)
        let action2 = UIAlertAction(title: "确认", style: .default) { [unowned self] _ in
            self.restaurant.menu.remove(at: index)
            self.foodTableView.reloadData()
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }
}

extension RestaurantManageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurant.menu.count > 0 ? restaurant.menu.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if restaurant.menu.count > 0,
            let foodCell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as? FoodTableViewCell {
            foodCell.setWithFoodItem(item: restaurant.menu[indexPath.row], order: false)
            foodCell.editBlock = { [unowned self] in
                let foodEditView = FoodDetaileViewController(edit: true)
                foodEditView.setData(with: self.restaurant.menu[indexPath.row])
                foodEditView.updateFoodBlock = { item in
                    self.restaurant.menu[indexPath.row] = item
                    self.foodTableView.reloadData()
                }
                navigationController?.pushViewController(foodEditView, animated: true)
            }
            
            foodCell.deleteBlock = { [unowned self] in
                self.deleteFood(index: indexPath.row)
            }
            return foodCell
        }
        else if let emptyCell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath) as? EmptyCell {
            return emptyCell
        }
        return UITableViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = foodTableView.contentOffset.y
        if y <= 84.0 {
            topContainerView.snp.updateConstraints { make in
                make.height.equalTo(180.0 - y)
            }
        }
        else {
            topContainerView.snp.updateConstraints { make in
                make.height.equalTo(96.0)
            }
        }
    }
}

extension RestaurantManageViewController {
    typealias UpdateFoodBlock = (_ item: Food) -> Void
    class FoodDetaileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
        var item: Food?
        var updateFoodBlock: UpdateFoodBlock?
        
        init(edit: Bool) {
            super.init(nibName: nil, bundle: nil)
            title = "编辑餐品信息"
            if !edit {
                let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(updateFood))
                let cancle = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancleEdit))
                
                navigationItem.leftBarButtonItem = cancle
                navigationItem.rightBarButtonItem = done
            }
            else {
                let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(updateFood))
                navigationItem.rightBarButtonItem = done
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        lazy var nameLabel: UILabel = {
            let label = UILabel()
            label.text = "名字:"
            label.textAlignment = .center
            return label
        }()
        
        lazy var nameTextField: UITextField = {
           let textField = UITextField()
            textField.clearButtonMode = .whileEditing
            textField.layer.borderWidth = 1.0
            textField.textAlignment = .center
            textField.layer.cornerRadius = 8.0
            return textField
        }()
        
        lazy var priceLabel: UILabel = {
            let label = UILabel()
            label.text = "价格:"
            label.textAlignment = .center
            return label
        }()
        
        lazy var priceTextField: UITextField = {
           let textField = UITextField()
            textField.clearButtonMode = .whileEditing
            textField.layer.borderWidth = 1.0
            textField.textAlignment = .center
            textField.layer.cornerRadius = 8.0
            return textField
        }()
        
        lazy var countLabel: UILabel = {
            let label = UILabel()
            label.text = "总数量:"
            label.textAlignment = .center
            return label
        }()
        
        lazy var countTextField: UITextField = {
           let textField = UITextField()
            textField.clearButtonMode = .whileEditing
            textField.layer.borderWidth = 1.0
            textField.textAlignment = .center
            textField.layer.cornerRadius = 8.0
            return textField
        }()
        
        lazy var imageView: UIImageView = {
            let imageview = UIImageView()
            imageview.layer.borderWidth = 1.0
            imageview.layer.borderColor = UIColor.black.cgColor
            imageview.layer.cornerRadius = 8.0
            imageview.layer.masksToBounds = true
            imageview.image = UIImage(named: "food_placeholder")
            return imageview
        }()
        
        lazy var foodDescriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "餐品描述：(最多输入100个字)"
            label.textColor = .black
            label.textAlignment = .left
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 14.0)
            return label
        }()
        
        lazy var foodDescriptionTextView: UITextView = {
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
        
        var toolBar: UIToolbar = {
            let toolbar = UIToolbar()
            var cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takePicker))

            toolbar.setItems([cameraButton], animated: true)
            
            return toolbar
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            makeSubViews()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)
        }
        
        func makeSubViews() {
            view.backgroundColor = .white
            view.addSubview(nameLabel)
            view.addSubview(nameTextField)
            view.addSubview(priceLabel)
            view.addSubview(priceTextField)
            view.addSubview(countLabel)
            view.addSubview(countTextField)
            view.addSubview(foodDescriptionLabel)
            view.addSubview(foodDescriptionTextView)
            view.addSubview(imageView)
            view.addSubview(toolBar)
            
            nameLabel.snp.makeConstraints { (make) in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(30.0)
                make.left.equalTo(view).offset(30.0)
                make.width.equalTo(50.0)
                make.height.equalTo(32.0)
            }
            
            nameTextField.snp.makeConstraints { (make) in
                make.centerY.equalTo(nameLabel)
                make.height.equalTo(nameLabel)
                make.left.equalTo(nameLabel.snp.right).offset(15.0)
                make.right.equalTo(view).offset(-20.0)
            }
            
            priceLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(nameLabel)
                make.top.equalTo(nameLabel.snp.bottom).offset(30.0)
                make.width.height.equalTo(nameLabel)
            }
            
            priceTextField.snp.makeConstraints { (make) in
                make.centerX.equalTo(nameTextField)
                make.centerY.equalTo(priceLabel)
                make.width.height.equalTo(nameTextField)
            }
            
            countLabel.snp.makeConstraints { (make) in
                make.right.equalTo(nameLabel)
                make.top.equalTo(priceLabel.snp.bottom).offset(30.0)
                make.height.equalTo(nameLabel)
                make.width.equalTo(70.0)
            }
            
            countTextField.snp.makeConstraints { (make) in
                make.centerX.equalTo(nameTextField)
                make.centerY.equalTo(countLabel)
                make.width.height.equalTo(nameTextField)
            }
            
            imageView.snp.makeConstraints { (make) in
                make.centerY.equalTo(view).offset(30.0)
                make.left.equalTo(view).offset(20.0)
                make.height.width.equalTo(160.0)
            }
            
            foodDescriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(countTextField.snp.bottom).offset(30.0)
                make.left.equalTo(imageView.snp.right).offset(10.0)
                make.right.equalTo(view).offset(-20.0)
            }
            
            toolBar.snp.makeConstraints { (make) in
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                make.height.equalTo(40.0)
                make.left.right.equalTo(view)
            }
            
            foodDescriptionTextView.snp.makeConstraints { make in
                make.top.equalTo(foodDescriptionLabel.snp.bottom).offset(10.0)
                make.left.right.equalTo(foodDescriptionLabel)
                make.bottom.equalTo(toolBar.snp.top).offset(-20.0)
            }
        }
        
        func setData(with item: Food) {
            nameTextField.text = item.name
            priceTextField.text = item.price
            countTextField.text = "\(item.foodCount)"
            foodDescriptionTextView.text = item.foodDescription
            imageView.image = item.photo
            self.item = item
        }
        
        @objc
        func updateFood() {
            if (nameTextField.text ?? "").isEmpty {
                HUD.flash(.label("名字不能为空"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
                return
            }
            if (priceTextField.text ?? "").isEmpty {
                HUD.flash(.label("价格不能为空"), onView: view, delay: MyAppearence.promptDelayTime, completion: nil)
                return
            }

            item = Food(name: nameTextField.text ?? "", price: priceTextField.text ?? "", foodDescription: foodDescriptionTextView.text, count: Int64(countTextField.text ?? "0") ?? 0, photo: imageView.image!)
            updateFoodBlock?(item!)
            navigationController?.popViewController(animated: true)
        }
        
        @objc
        func cancleEdit() {
            navigationController?.popViewController(animated: true)
        }

        func isChinese(str: String) -> Bool{
            let match: String = "(^[\\u4e00-\\u9fa5]+$)"
            let predicate = NSPredicate(format: "SELF matches %@", match)
            return predicate.evaluate(with: str)
        }
        
        @objc
        func hideKeyboard() {
            nameTextField.resignFirstResponder()
            priceTextField.resignFirstResponder()
            countTextField.resignFirstResponder()
            foodDescriptionTextView.resignFirstResponder()
        }
        
        //点击相机触发
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
            imageView.image = image as? UIImage
            dismiss(animated: true, completion: nil)
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return foodDescriptionTextView.text.count + (text.count - range.length) <= 100
        }
    }
}
