//
//  UIColor+ThemeColor.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/4/28.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit

import YYKit

extension UIColor{
    @objc static var app_999999:UIColor{
        return UIColor.init(hexString: "#999999") ?? UIColor.app_default
    }
    @objc static var app_666666:UIColor{
        return UIColor.init(hexString: "#666666") ?? UIColor.app_default
    }
    @objc static var app_4d4d4d:UIColor{
        return UIColor.init(hexString: "#4d4d4d") ?? UIColor.app_default
    }
    @objc static var app_4c4c4c:UIColor{
        return UIColor.init(hexString: "#4c4c4c") ?? UIColor.app_default
    }
    @objc static var app_333333:UIColor{
        return UIColor.init(hexString: "#333333") ?? UIColor.app_default
    }
    @objc static var app_808080:UIColor{
        return UIColor.init(hexString: "#808080") ?? UIColor.app_default
    }
    @objc static var app_F9F9F9:UIColor{
        return UIColor.init(hexString: "#F9F9F9") ?? UIColor.app_default
    }
    
    @objc static var app_mainTheme:UIColor{
        return UIColor.init(hexString: "#FDA6B7") ?? UIColor.app_default
    }
    @objc static var app_line:UIColor{
        return UIColor.init(hexString: "#E0E0E0") ?? UIColor.app_default
    }
    @objc static var app_FAFAFA:UIColor{
        return UIColor.init(hexString: "#FAFAFA") ?? UIColor.app_default
    }
    @objc static var app_bg:UIColor{
        return UIColor.init(hexString: "#F5F5F5") ?? UIColor.app_default
    }
    @objc static var app_randomColor:UIColor{
        let red = CGFloat((arc4random() % 255)) / 255
        let green = CGFloat((arc4random() % 255)) / 255
        let blue = CGFloat((arc4random() % 255)) / 255
        return UIColor.init(red: red, green: green, blue: blue, alpha: 1)
    }
    @objc static var app_default:UIColor{
        return UIColor.white
    }
}
