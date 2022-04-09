//
//  ScrollViewTestViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2021/8/4.
//

import UIKit
import SnapKit
import MJRefresh

class ScrollViewTestViewController: UIViewController {
    var myScrollView: UIScrollView!
    var containerView: UIView!
    var textView: UITextView!
    var keyboard: CGFloat?
    var tabBarHeight: CGFloat?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ScrollView"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        myScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        myScrollView.backgroundColor = .white
        view.addSubview(myScrollView)
        
        myScrollView.isScrollEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyBordDown))
        myScrollView.addGestureRecognizer(tap)
        
        myScrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        containerView = UIView()
        myScrollView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(myScrollView)
            make.width.equalTo(myScrollView)
        }
        
        myScrollView.mj_header = MJRefreshNormalHeader(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.viewDidLoad()
                self.myScrollView.mj_header?.endRefreshing()
            }
        }
        
        myScrollView.mj_footer = MJRefreshBackNormalFooter(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.textView.text = "上拉加载成功"
                self.myScrollView.mj_footer?.endRefreshing()
            }
        }
        
        drawView()
    }
    
    @objc
    func keyboardShow(notification: Notification) {
        let value = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        keyboard = value.height
    }
    
    @objc
    func keyBordDown() {
        textView.resignFirstResponder()
    }
    
    func drawView() {
        var lastLabel: UILabel?
        for i in 1...12 {
            let label = UILabel()
            label.text = "Label\(i)"
            label.textAlignment = .center
            label.layer.cornerRadius = 8.0
            label.layer.masksToBounds = true
            label.backgroundColor = UIColor(red: CGFloat(arc4random() % 255) / 255.0, green: CGFloat(arc4random() % 255) / 255.0, blue: CGFloat(arc4random() % 255) / 255.0, alpha: 1.0)
            containerView.addSubview(label)
            
            label.snp.makeConstraints { (make) in
                if lastLabel == nil {
                    make.top.equalTo(containerView.snp.top)
                }
                else {
                    make.top.equalTo(lastLabel!.snp.bottom)
                }
                make.left.equalTo(containerView.snp.left).offset(4)
                make.right.equalTo(containerView.snp.right).offset(-4)
                make.height.equalTo(80)
            }
            lastLabel = label
        }
        
        textView = UITextView()
        textView.text = "这是一个UITextView"
        textView.layer.borderWidth = 2.0
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 4.0
        textView.keyboardType = .default
        textView.returnKeyType = .done
        textView.isEditable = true
        textView.font = UIFont.systemFont(ofSize: 20.0)
        textView.delegate = self
        
        containerView.addSubview(textView)
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(lastLabel!.snp.bottom).offset(10)
            make.left.equalTo(containerView.snp.left).offset(4)
            make.right.equalTo(containerView.snp.right).offset(-4)
            make.height.equalTo(100)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(textView.snp.bottom)
        }
    }
}

extension ScrollViewTestViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        myScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboard!, right: 0)
        
        UIView.animate(withDuration: 1.0) {
            self.myScrollView.setContentOffset(CGPoint(x: self.myScrollView.contentOffset.x, y: self.myScrollView.contentOffset.y + self.keyboard! - (self.tabBarHeight ?? 0.0)), animated: true)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.5) {
            self.myScrollView.contentInset = UIEdgeInsets.zero
            self.myScrollView.setContentOffset(CGPoint(x: self.myScrollView.contentOffset.x, y: self.myScrollView.contentOffset.y), animated: true)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: CGFloat(MAXFLOAT)))
        if size.height < textView.bounds.height {
            return
        }
        else {
            textView.snp.updateConstraints { (make) in
                make.height.equalTo(size.height)
            }
            self.myScrollView.setContentOffset(CGPoint(x: self.myScrollView.contentOffset.x, y: self.myScrollView.contentSize.height - self.myScrollView.bounds.height + self.keyboard!), animated: true)
        }
    }
}
