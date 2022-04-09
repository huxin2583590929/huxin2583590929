//
//  BJLUIViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2021/8/9.
//

//import UIKit
//import SnapKit
//
//class BJLUIViewController: UIViewController, BJLScRoomViewControllerDelegate {
//    var codeField: UITextField
//    var nameField: UITextField
//    let domainPrefix = "b41558528"
//    var roomViewController: BJLScRoomViewController?
//
//    init() {
//        codeField = UITextField()
//        nameField = UITextField()
//        super.init(nibName: nil, bundle: nil)
//        BJLRoom.setPrivateDomainPrefix(domainPrefix)
//        title = "login"
//        tabBarItem = UITabBarItem(title: "Login", image: UIImage(named: "microlecture"), tag: 103)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(gr:)))
//        self.view.addGestureRecognizer(tap)
//
//        buildUI()
//
//    }
//
//    @objc
//    func tapAction(gr: UIGestureRecognizer) {
//        self.resignFirstResponder()
//    }
//
//    func buildUI() {
//        let codeLabel = UILabel()
//        codeLabel.text = "参加码: "
//
//        view.addSubview(codeLabel)
//
//        codeField.placeholder = "  请输入参加码"
//        codeField.borderStyle = .roundedRect
//
//        view.addSubview(codeField)
//
//        let nameLabel = UILabel()
//        nameLabel.text = "用户名: "
//
//        view.addSubview(nameLabel)
//
//        nameField.placeholder = "  请输入用户名"
//        nameField.borderStyle = .roundedRect
//
//        view.addSubview(nameField)
//
//        let loginButton = UIButton()
//        loginButton.setTitle("Login", for: .normal)
//        loginButton.setTitleColor(.black, for: .normal)
//        loginButton.layer.cornerRadius = 8.0
//        loginButton.layer.borderWidth = 2.0
//        loginButton.layer.borderColor = UIColor.black.cgColor
//        loginButton.addTarget(self, action: #selector(codeLogin), for: .touchUpInside)
//
//        view.addSubview(loginButton)
//
//        codeLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(view).offset(250)
//            make.left.equalTo(view).offset(30)
//            make.width.equalTo(70)
//            make.height.equalTo(50)
//        }
//
//        codeField.snp.makeConstraints { (make) in
//            make.left.equalTo(codeLabel.snp.right).offset(10)
//            make.right.equalTo(view).offset(-10)
//            make.centerY.equalTo(codeLabel)
//            make.height.equalTo(codeLabel)
//        }
//
//        nameLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(codeLabel.snp.bottom).offset(20)
//            make.left.equalTo(codeLabel)
//            make.height.equalTo(codeLabel)
//            make.width.equalTo(codeLabel)
//        }
//
//        nameField.snp.makeConstraints { (make) in
//            make.left.equalTo(nameLabel.snp.right).offset(10)
//            make.right.equalTo(view).offset(-10)
//            make.centerY.equalTo(nameLabel)
//            make.height.equalTo(nameLabel)
//        }
//
//        loginButton.snp.makeConstraints { (make) in
//            make.centerX.equalTo(view)
//            make.height.equalTo(50)
//            make.width.equalTo(70)
//            make.top.equalTo(nameField.snp.bottom).offset(40)
//        }
//    }
//
//    @objc
//    func codeLogin() {
//        guard let secret = codeField.text,let name = nameField.text else { return }
//        roomViewController = BJLScRoomViewController.instance(withSecret: secret, userName: name, userAvatar: nil) as? BJLScRoomViewController
//        roomViewController!.delegate = self
//
//        self.present(roomViewController!, animated: true, completion: nil)
//    }
//
//    func roomViewControllerEnterRoomSuccess(_ roomViewController: BJLScRoomViewController) {
//        print("Enter Room Success")
//    }
//
//    func roomViewController(_ roomViewController: BJLScRoomViewController, enterRoomFailureWithError error: Error) {
//        print("Enter Room Failure with Error: \(error)")
//    }
//
//    func roomViewController(_ roomViewController: BJLScRoomViewController, willExitWithError error: Error?) {
//        if error == nil {
//            print("Will Exit Room Success")
//        }
//        else {
//            print("Will Exit Room Failure With Error: \(error!)")
//        }
//    }
//
//    func roomViewController(_ roomViewController: BJLScRoomViewController, didExitWithError error: Error?) {
//        if error == nil {
//            print("Exit Room Success")
//        }
//        else {
//            print("Exit Room Failure With Error: \(error!)")
//        }
//    }
//}
