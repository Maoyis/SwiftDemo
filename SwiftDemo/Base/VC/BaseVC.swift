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
            
            let backItem = self.getCustumBtnBar(withImage: "left_back_black", action: #selector(back))
            items.append(backItem)
            
        }else{
            
            let menItem = self.getCustumBtnBar(withImage: "icon_threeline", action: #selector(menuSwitch))
            items.append(menItem)
        }
        
        self.navigationItem.leftBarButtonItems = items
        
    }
    
    
    func getCustumBtnBar(withImage image:String, action:Selector) -> UIBarButtonItem {
        /* 设置导航栏上面的内容 */
        let cstB = UIButton.init(type: UIButtonType.custom)
        cstB.addTarget(self, action: action, for: UIControlEvents.touchUpInside)
        // 设置图片 设置尺寸--》等于当前背景图片的尺寸。
        cstB.setImage(UIImage.init(named: image), for: UIControlState.normal)
        cstB.frame =  CGRect(x: 0, y: 0, width: 30, height: 30)
        //cstB.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        //适配xocde9 xcode9导航栏按钮使用自约束
        let systemVersion = UIDevice.current.systemVersion
        if  Double(systemVersion)! > 9.0  {
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






