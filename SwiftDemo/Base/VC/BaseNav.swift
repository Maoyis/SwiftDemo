//
//  BaseNav.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/4/28.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit

class BaseNav: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor  = UIColor.app_333333
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let root = UIApplication.shared.keyWindow?.rootViewController as! RootVC
        if self.viewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true;
            self.interactivePopGestureRecognizer?.isEnabled = true;
            root.leftPanGesture?.isEnabled = false
        }
        
        super.pushViewController(viewController, animated: animated)
    }

    
    override func popViewController(animated: Bool) -> UIViewController? {
        let root = UIApplication.shared.keyWindow?.rootViewController as! RootVC
       
        if self.viewControllers.count == 2 {
            
            root.leftPanGesture?.isEnabled = true
        }
        
        return super.popViewController(animated: animated)
    }
    
    
}

