//
//  BJLAppTest.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2021/8/16.
//

import UIKit

class BJLAppTest: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .red
        
        let imageview = UIImageView(image: UIImage(named: "jiantou"))
        imageview.backgroundColor = .clear
        
        view.mask = imageview
        
        self.view.addSubview(view)
    }
}
