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
        self.initConfig()
        // Do any additional setup after loading the view.
    }

    func initConfig() -> Void {
        
        
        self.view.backgroundColor = UIColor.app_bg
        self.initNav()
    }
    func initNav() -> Void {
       var items:[UIBarButtonItem] = []
        
        if (self.navigationController != nil)
            && (self.navigationController?.viewControllers.count)!>1 {
            /* 设置导航栏上面的内容 */
            let backBtn = UIButton.init(type: UIButtonType.custom)
            backBtn.addTarget(self, action: #selector(back), for: UIControlEvents.touchUpInside)
            // 设置图片 设置尺寸--》等于当前背景图片的尺寸。
            backBtn.setImage(UIImage.init(named: "left_back_black"), for: UIControlState.normal)
            backBtn.frame =  CGRect(x: 0, y: 0, width: 20, height: 30)
            backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
            //适配xocde9 xcode9导航栏按钮使用自约束
            let systemVersion = UIDevice.current.systemVersion
            if  Double(systemVersion)! > 9.0  {
                let wc = backBtn.widthAnchor.constraint(equalToConstant: backBtn.frame.size.width)
                wc.isActive = true;
                let hc = backBtn.heightAnchor.constraint(equalToConstant: backBtn.frame.size.height)
                
                hc.isActive = true;
            }
            
            let backItem = UIBarButtonItem.init(customView: backBtn)
            items.append(backItem)
            
        }else{
            let menItem = UIBarButtonItem.init(title: "菜单", style: UIBarButtonItemStyle.plain, target: self, action: #selector(menuSwitch))
            
            items.append(menItem)
        }
        
        self.navigationItem.leftBarButtonItems = items
        
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
        default:
            type = CourseType.Library
        }
        return type
    }
//MARK:seletor
    
    @objc func menuSwitch() -> Void {
        let root = self.appRootVC()
        if root.isLeftOpen() {
            root.closeLeft()
        }else{
            root.openLeft()
        }
        
    }
    @objc func back() -> Void {
        if (self.navigationController != nil) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    
    
    
    
    
}






