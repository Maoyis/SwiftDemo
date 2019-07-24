//
//  BaseVC.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/4/28.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initBaseUI()
        // Do any additional setup after loading the view.
    }

    func initBaseUI() -> Void {
        
        
        self.view.backgroundColor = UIColor.app_bg
        self.initNav()
    }
    func initNav() -> Void {
       var items:[UIBarButtonItem] = []
        
        if (self.navigationController != nil)
            && (self.navigationController?.viewControllers.count)!>1 {
            
            let backItem = self.getCustumBtnBar(withImage: "left_back_black", action: #selector(back))
            items.append(backItem)
            
        }else{
            
            let menItem = self.getCustumBtnBar(withImage: "icon_threeline", action: #selector(menuSwitch))
            items.append(menItem)
        }
        
        self.navigationItem.leftBarButtonItems = items
        
        
        let webItem = UIBarButtonItem.init(title: "官网", style: UIBarButtonItemStyle.plain, target: self, action: #selector(gotoAppleWeb))
        self.navigationItem.rightBarButtonItem = webItem
    }
    
    
    func getCustumBtnBar(withImage image:String, action:Selector) -> UIBarButtonItem {
        /* 设置导航栏上面的内容 */
        let cstB = UIButton.init(type: UIButtonType.custom)
        cstB.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        // 设置图片 设置尺寸--》等于当前背景图片的尺寸。
        cstB.setImage(UIImage.init(named: image)?.byTintColor(UIColor.app_333333), for: UIControlState.normal)
        cstB.frame =  CGRect(x: 0, y: 0, width: 30, height: 30)
        cstB.contentHorizontalAlignment = .left
        if  #available(iOS 9.0, *) {
            let wc = cstB.widthAnchor.constraint(equalToConstant: cstB.frame.size.width)
            wc.isActive = true;
            let hc = cstB.heightAnchor.constraint(equalToConstant: cstB.frame.size.height)
            
            hc.isActive = true;
        }
        
        let item = UIBarButtonItem.init(customView: cstB)
        return item
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK:action
    
    func appRootVC() -> RootVC {
        return UIApplication.shared.keyWindow?.rootViewController as! RootVC
    }
    /**获取app当前所选的课程类型*/
    func appSelectType() -> CourseType {
        let tabVC = self.appRootVC().mainViewController as! BaseTabBarVC
        var type = CourseType.Begnner
        switch tabVC.selectedIndex {
        case 0:
            type = CourseType.Begnner
        case 1:
            type = CourseType.Advanced
        case 2:
            type = CourseType.Library
        case 3:
            type = CourseType.Framework
        default:break
        }
        return type
    }
//MARK:seletor
    /**菜单切换*/
    @objc func menuSwitch() -> Void {
        let root = self.appRootVC()
        if root.isLeftOpen() {
            root.closeLeft()
        }else{
            root.openLeft()
        }
        
    }
    /**导航->返回*/
    @objc func back() -> Void {
        if (self.navigationController != nil) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    /**查看官网*/
    @objc func gotoAppleWeb() -> Void {
        let appleWeb = "https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309"
        let url = URL.init(string: appleWeb)
        UIApplication.shared.open(url!, options: [:]) { (flag) in
            print("打开官网")
        }
    }
    
    
    
}






