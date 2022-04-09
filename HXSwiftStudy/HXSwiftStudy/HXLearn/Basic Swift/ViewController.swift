//
//  ViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2021/7/31.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var myTableView: UITableView!
    var basicItems = ["BJY SwiftBook","Official document", "swift UIKit"]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Basic"
        self.tabBarItem = UITabBarItem(title: "Basics", image: UIImage(named: "basics"), tag: 100)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basicItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.accessoryType = .detailButton
        cell.textLabel?.text = basicItems[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.center
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alertController:UIAlertController = UIAlertController(title: "BJY SwiftBook", message: { () -> String in
            switch indexPath.row {
            case 0: return "这是百家云iOS团队写的Swift文档"
            case 1: return "这是官方的Swift文档"
            case 2: return "这是Swift基础知识及UIKit"
            default: return ""
            }
        }(), preferredStyle: .alert)
        
        let  alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            UIApplication.shared.open(URL(string:"https://git.baijiashilian.com/open-ios/SwiftBook/-/blob/master/SwiftBook.playground/Pages/01-TheBasics.xcplaygroundpage/Contents.swift")!, options: [:], completionHandler: nil)
        case 1:
            UIApplication.shared.open(URL(string: "https://docs.swift.org/swift-book/")!, options: [:], completionHandler: nil)
        case 2:
            UIApplication.shared.open(URL(string: "https://itisjoe.gitbooks.io/swiftgo/content/uikit/uikit.html")!, options: [:], completionHandler: nil)
        default:
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), style: .plain)
        
        //设置分割线style和分割线的inset
        myTableView.separatorStyle = .singleLine
        myTableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        myTableView.allowsSelection = true
        myTableView.allowsMultipleSelection = false
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.dataSource = self
        myTableView.delegate = self
        
        self.view.addSubview(myTableView)
    }

}
