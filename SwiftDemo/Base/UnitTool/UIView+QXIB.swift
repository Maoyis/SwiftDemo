//
//  UIView+QXIB.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/6/27.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import Foundation
import UIKit


var borderColorKey = 100
var borderWithKey = 101
var cornerRadiusKey = 102


extension UIView{

    @IBInspectable var borderColor: UIColor {
        set {
            self.layer.borderColor = borderColor.cgColor
            objc_setAssociatedObject(self, &borderColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            if let rs = objc_getAssociatedObject(self, &borderColorKey) as? UIColor {
                return rs
            }
            return .clear
        }
    }
    
    @IBInspectable var borderWith: CGFloat {
        set {
            self.layer.borderWidth = borderWith
            objc_setAssociatedObject(self, &borderWithKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        
        get {
            if let rs = objc_getAssociatedObject(self, &borderWithKey) as? CGFloat {
                return rs
            }
            
            return 0.0
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = borderWith
            objc_setAssociatedObject(self, &cornerRadiusKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            if let rs =  objc_getAssociatedObject(self, &cornerRadiusKey){
                return rs as! CGFloat
            }
            return 0.0
        }
    }
    
}

    




