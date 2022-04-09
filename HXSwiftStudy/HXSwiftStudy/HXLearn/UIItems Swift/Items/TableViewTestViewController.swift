//
//  TableViewTestViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2021/8/2.
//

import UIKit
import SnapKit

class TableViewTestViewController: UIViewController {
    var myTableView: UITableView!
    var cellItemsArray = [CellItem]()
    
    init() {
        if let data = UserDefaults.standard.object(forKey: "cellItems") as? Data, let item = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, CellItem.self, UIImage.self], from: data) as? [CellItem] {
            cellItemsArray = item
           }
        super.init(nibName: nil, bundle: nil)
        title = "TableView"
        
        let barItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        navigationItem.rightBarButtonItem = barItem
        
        //监听进入后台触发事件
        NotificationCenter.default.addObserver(self, selector: #selector(enterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //保存数据
    @objc
    func enterBackground() {
        UserDefaults.standard.set(try? NSKeyedArchiver.archivedData(withRootObject: cellItemsArray, requiringSecureCoding: true), forKey: "cellItems")
        UserDefaults.standard.synchronize()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        UserDefaults.standard.set(try? NSKeyedArchiver.archivedData(withRootObject: cellItemsArray, requiringSecureCoding: true), forKey: "cellItems")
        UserDefaults.standard.synchronize()
    }
    
    //新增cell
    @objc
    func addNewItem() {
        let item = CellItem(withSerial: cellItemsArray.count + 101)
        let detail = DetaileViewController(isNew: true)
        detail.tableView = myTableView
        detail.setData(with: item)
        
        cellItemsArray.append(item)
        
        let navigationn = UINavigationController(rootViewController: detail)
        present(navigationn, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), style: .plain)
        
        //设置分割线style和分割线的inset
        myTableView.separatorStyle = .none
        //myTableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        myTableView.allowsSelection = true
        myTableView.allowsMultipleSelection = false
        
        myTableView.register(TableViewItemCell.self, forCellReuseIdentifier: "cell")
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.estimatedRowHeight = 100
        
        view.addSubview(myTableView)
    }
}

//TODO: - Cell And Delegate
extension TableViewTestViewController: UITableViewDataSource,UITableViewDelegate {
    //自定义Cell
    class TableViewItemCell: UITableViewCell {
        lazy var nameLabel: UILabel = {
            var label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 60))
            label.textAlignment = .center
            label.numberOfLines = 0
            return label
        }()
        
        lazy var valueLabel: UILabel = {
            var label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            label.textAlignment = .center
            label.numberOfLines = 0
            return label
        }()
        
        lazy var imageView1: UIImageView = {
            var imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            imageview.layer.cornerRadius = 8.0
            imageview.layer.masksToBounds = true
            return imageview
        }()
        
        func setWithCellItem(item: CellItem) {
            nameLabel.text = item.name
            valueLabel.text = item.value
            imageView1.image = item.cellImage
        }
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(nameLabel)
            contentView.addSubview(valueLabel)
            contentView.addSubview(imageView1)
            
            imageView1.snp.makeConstraints { (make) in
                make.left.equalTo(contentView).offset(10)
                make.top.greaterThanOrEqualTo(contentView).offset(10)
                make.bottom.lessThanOrEqualTo(contentView).offset(-10)
                make.centerY.equalTo(contentView)
                make.height.equalTo(80)
                make.width.equalTo(80)
            }
            
            nameLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(contentView)
                make.left.equalTo(imageView1.snp.right).offset(10)
                make.right.equalTo(valueLabel.snp.left).offset(-10)
            }
            
            valueLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(nameLabel)
                make.right.equalTo(contentView.snp.right).offset(-10)
                make.width.equalTo(60)
            }
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewTestViewController.TableViewItemCell
        
        cell.setWithCellItem(item: cellItemsArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailView = DetaileViewController(isNew: false)
        
        detailView.tableView = myTableView
        detailView.setData(with: cellItemsArray[indexPath.row])
        
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    //删除cell操作
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cellItemsArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//TODO: - Helper Class
extension TableViewTestViewController {
    //点击+弹出数据模型的详细结构视图
    class DetaileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var tableView: UITableView?
        var item: CellItem?
        
        var nameLabel: UILabel = {
            let label = UILabel()
            label.text = "Name:"
            label.textAlignment = .center
            return label
        }()
        
        var nameTextField: UITextField = {
           let textField = UITextField()
            textField.clearButtonMode = .whileEditing
            textField.layer.borderWidth = 1.0
            textField.textAlignment = .center
            textField.layer.cornerRadius = 8.0
            return textField
        }()
        
        var serialLabel: UILabel = {
            let label = UILabel()
            label.text = "serial:"
            label.textAlignment = .center
            return label
        }()
        
        var serialTextField: UITextField = {
           let textField = UITextField()
            textField.clearButtonMode = .whileEditing
            textField.layer.borderWidth = 1.0
            textField.textAlignment = .center
            textField.layer.cornerRadius = 8.0
            return textField
        }()
        
        var valueLabel: UILabel = {
            let label = UILabel()
            label.text = "Value:"
            label.textAlignment = .center
            return label
        }()
        
        var valueTextField: UITextField = {
           let textField = UITextField()
            textField.clearButtonMode = .whileEditing
            textField.layer.borderWidth = 1.0
            textField.textAlignment = .center
            textField.layer.cornerRadius = 8.0
            return textField
        }()
        
        var imageView: UIImageView = {
            let imageview = UIImageView()
            imageview.layer.borderWidth = 1.0
            imageview.layer.borderColor = UIColor.white.cgColor
            imageview.layer.cornerRadius = 8.0
            imageview.layer.masksToBounds = true
            return imageview
        }()
        
        var toolBar: UIToolbar = {
            let toolbar = UIToolbar()
            var cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takePicker))

            toolbar.setItems([cameraButton], animated: true)
            
            return toolbar
        }()
        
        func setData(with item: CellItem) {
            nameTextField.text = item.name
            serialTextField.text = item.serial
            valueTextField.text = item.value
            imageView.image = item.cellImage
            self.item = item
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
        
        //保存数据到tableview
        @objc
        func addNew() {
            item?.name = nameTextField.text
            item?.serial = serialTextField.text
            item?.value = valueTextField.text
            item?.cellImage = imageView.image
            
            tableView!.reloadData()
            dismiss(animated: true, completion: nil)
        }
        
        @objc
        func cancleAdd() {
            dismiss(animated: true, completion: nil)
        }
        
        init(isNew: Bool) {
            super.init(nibName: nil, bundle: nil)
            title = "CellItemDetail"
            if isNew {
                let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addNew))
                let cancle = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancleAdd))
                
                navigationItem.leftBarButtonItem = cancle
                navigationItem.rightBarButtonItem = done
            }
            else {
                let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addNew))
                navigationItem.rightBarButtonItem = done
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .white
            view.addSubview(nameLabel)
            view.addSubview(nameTextField)
            view.addSubview(serialLabel)
            view.addSubview(serialTextField)
            view.addSubview(valueLabel)
            view.addSubview(valueTextField)
            view.addSubview(imageView)
            view.addSubview(toolBar)
            
            nameLabel.snp.makeConstraints { (make) in
                make.top.equalTo(view).offset(90)
                make.left.equalTo(view).offset(30)
                make.width.equalTo(50)
                make.height.equalTo(50)
            }
            
            nameTextField.snp.makeConstraints { (make) in
                make.centerY.equalTo(nameLabel)
                make.height.equalTo(nameLabel)
                make.left.equalTo(nameLabel.snp.right).offset(15)
                make.right.equalTo(view).offset(-20)
            }
            
            serialLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(nameLabel)
                make.top.equalTo(nameLabel.snp.bottom).offset(10)
                make.width.height.equalTo(nameLabel)
            }
            
            serialTextField.snp.makeConstraints { (make) in
                make.centerX.equalTo(nameTextField)
                make.centerY.equalTo(serialLabel)
                make.width.height.equalTo(nameTextField)
            }
            
            valueLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(nameLabel)
                make.top.equalTo(serialLabel.snp.bottom).offset(10)
                make.width.height.equalTo(nameLabel)
            }
            
            valueTextField.snp.makeConstraints { (make) in
                make.centerX.equalTo(nameTextField)
                make.centerY.equalTo(valueLabel)
                make.width.height.equalTo(nameTextField)
            }
            
            imageView.snp.makeConstraints { (make) in
                make.top.equalTo(valueLabel.snp.bottom).offset(10)
                make.bottom.equalTo(toolBar.snp.top).offset(-10)
                make.left.equalTo(view).offset(20)
                make.right.equalTo(view).offset(-20)
            }
            
            toolBar.snp.makeConstraints { (make) in
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                make.height.equalTo(40)
                make.left.right.equalTo(view)
            }
        }
    }
}
//自定义数据模型
class CellItem: NSObject,NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var name: String?
    var serial: String?
    var value: String?
    var cellImage: UIImage?
    let names = ["apple", "pear", "banana","lemo"]
    
    init(withSerial: Int) {
        serial = "\(withSerial)"
        name = names[Int(arc4random()) % names.count]
        value = "\( Int(arc4random()) % 50 + 50)"
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(serial, forKey: "serial")
        coder.encode(value, forKey: "value")
        coder.encode(cellImage, forKey: "image")
    }
    
    required init?(coder: NSCoder) {
        super.init()
        name = coder.decodeObject(forKey: "name") as? String
        serial = coder.decodeObject(forKey: "serial") as? String
        value = coder.decodeObject(forKey: "value") as? String
        cellImage = coder.decodeObject(forKey: "image") as? UIImage
    }
}
