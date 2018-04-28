//
//  CourseModel.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/4/28.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit

enum CourseType {
    case Begnner
    case Advanced
    case Library
  
}


class CourseModel: NSObject {
    /**简介*/
    @objc var brief:String            = ""
    /**标题*/
    @objc var title:String            = ""
    /**数据*/
    @objc var data:[CourseModel]      = []
    
    
    class func getCourseData(withType type:CourseType) -> Array<Any> {
        switch type {
        case CourseType.Begnner:
            return ["首页", "Begnner1", "Begnner2"]
        case CourseType.Advanced:
            return ["首页", "Advanced1", "Advanced2"]
        case CourseType.Library:
            return ["首页", "Library1", "Library2"]

        }
    }
    
    
}
