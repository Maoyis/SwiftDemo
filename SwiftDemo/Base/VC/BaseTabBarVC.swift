//
//  BaseTabBarVC.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/4/28.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit

class BaseTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTab()
        self.selectedIndex = 1
        
        UITabBarItem.appearance().setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 18)], for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initTab() -> Void {
        var i = 0
        
        for nav  in self.viewControllers! {
            i += 1;
            let vc = (nav as! UINavigationController).viewControllers[0]
            
            switch i {
            case 1:
                vc.title = NSLocalizedString("初学", comment: "Beginner")
            case 2:
                vc.title = NSLocalizedString("进阶", comment: "Advanced")
            case 3:
                vc.title = NSLocalizedString("精品库", comment: "Library")
            case 4:
                vc.title = NSLocalizedString("框架", comment: "Framework")
            default: break
                
            }
        }
        
    }
    
    override open var shouldAutorotate: Bool {
        get {
            return true
            
        }
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            let nav = self.selectedViewController

            if nav != nil && ((nav as! UINavigationController).visibleViewController?.isKind(of: LineVC.classForCoder()))!{
                return UIInterfaceOrientationMask.landscapeLeft
            }
            return UIInterfaceOrientationMask.portrait
        }
    }
    
 
}
