//
//  UIItemsTableViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2021/8/2.
//

import UIKit

class UIItemsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var myTableView: UITableView!
    var tabBarHeight: CGFloat?
    
    var uiItems = ["ConncentricCircke","Timereder","TableView","Touchtracker","ScrollView"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        uiItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.accessoryType = .none
        cell.textLabel?.text = uiItems[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.center
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let circle = ConcentricCircleViewController()
            self.navigationController?.pushViewController(circle, animated: true)
        case 1:
            let timeRemind = TimeReminderViewController()
            self.navigationController?.pushViewController(timeRemind, animated: true)
        case 2:
            let tableView = TableViewTestViewController()
            self.navigationController?.pushViewController(tableView, animated: true)
        case 3:
            let touchView = TouchTrackerViewController()
            self.navigationController?.pushViewController(touchView, animated: true)
        case 4:
            let scrollView = ScrollViewTestViewController()
            scrollView.tabBarHeight = tabBarHeight ?? 0.0
            self.navigationController?.pushViewController(scrollView, animated: true)
            
        default:
            return
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "UI"
        tabBarItem = UITabBarItem(title: "UI", image: UIImage(named: "ui"), tag: 101)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), style: .plain)
        
        //设置分割线style和分割线的inset
        myTableView.separatorStyle = .singleLine
        myTableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        myTableView.allowsSelection = true
        myTableView.allowsMultipleSelection = false
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.dataSource = self
        myTableView.delegate = self
        
        view.addSubview(myTableView)
    }
}
