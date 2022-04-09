//
//  MyAppearence.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2022/1/19.
//

import Foundation
import UIKit

class MyAppearence: NSObject {
    static var promptDelayTime: Double {
        return 1.0
    }
    
    static var brandColor: UIColor {
        return UIColor(hexString: "#1795FF")
    }
    
    static var containerBackground: UIColor {
        return UIColor(hexString: "#F0FFF0")
    }
    
    static var restaurantUserInfo: [String: Any] {
        if let data = UserDefaults.standard.object(forKey: "restaurantUserInfo") as? Data,
           let info = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSDictionary.self, User.self, Restaurant.self, Food.self, Order.self, NSArray.self, UIImage.self], from: data) as? [String: Any] {
            return info
        }
        return [String: Any]()
    }
}

extension UIColor {
    convenience init(hexString: String) {
         let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
         let scanner = Scanner(string: hexString)
          
         if hexString.hasPrefix("#") {
             scanner.currentIndex = scanner.string.index(after: scanner.string.startIndex)
         }
          
         var color: UInt64 = 0
         scanner.scanHexInt64(&color)
          
         let mask = 0x000000FF
         let r = Int(color >> 16) & mask
         let g = Int(color >> 8) & mask
         let b = Int(color) & mask
          
         let red   = CGFloat(r) / 255.0
         let green = CGFloat(g) / 255.0
         let blue  = CGFloat(b) / 255.0
          
         self.init(red: red, green: green, blue: blue, alpha: 1)
     }
}
