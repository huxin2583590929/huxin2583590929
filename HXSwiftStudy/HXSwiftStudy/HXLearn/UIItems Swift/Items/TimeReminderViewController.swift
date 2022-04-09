//
//  timeRemiderViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2021/8/2.
//

import UIKit
import SnapKit

class TimeReminderViewController: UIViewController {
    var timePicker: UIDatePicker = UIDatePicker()
    var remindButton: UIButton = UIButton()
    
    @objc
    func timeReminder() {
        let date = timePicker.date
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)

        let content = UNMutableNotificationContent()
        content.title = "提醒"
        //content.subtitle = "子標題"
        content.body = "时间到了!"
        content.badge = nil
        
        let dateComponents = DateComponents(year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: 0)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { err in
            err != nil ? print("添加本地通知錯誤", err!.localizedDescription) : print("添加本地通知成功")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TimeReminder"
        view.backgroundColor = UIColor.white
        
        remindButton.setTitle("Reminder Me!", for: .normal)
        remindButton.setTitleColor(.black, for: .normal)
        remindButton.addTarget(self, action: #selector(timeReminder), for: .touchUpInside)
        
        view.addSubview(timePicker)
        view.addSubview(remindButton)
        
        timePicker.snp.makeConstraints { (make) in
            make.center.equalTo(view.center)
            make.width.equalTo(300)
            make.height.equalTo(400)
        }
        
        remindButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(view).inset(UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80))
            make.bottom.equalTo(view).offset(-60)
            make.height.equalTo(80)
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (status, err) in
            if !status {
                    print("用戶不同意授權通知權限")
                return
            }
        }
    }
    
}
