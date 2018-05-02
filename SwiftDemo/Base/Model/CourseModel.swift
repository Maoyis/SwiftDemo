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
enum <#name#> {
    case <#case#>
}

class CourseModel: NSObject {
    /**简介*/
    @objc var brief:String            = ""
    /**标题*/
    @objc var title:String            = ""
    /**storyboard上标识*/
    @objc var identy:String           = ""
    /**显示类型*/
    @objc var type:Int                = 0
    /**数据*/
    @objc var data:[CourseModel]      = []

    init(withTitle title:String, identy:String, brief:String) {
        super.init()
        self.title    = title
        self.brief    = brief
        self.identy   = identy
    }
    
    class func getCourseData(withType type:CourseType) -> Array<Any> {
        switch type {
        case CourseType.Begnner:
            return self.getBegnenrCourses()
        case CourseType.Advanced:
            return self.getAdvanceCourses()
        case CourseType.Library:
            return self.getLibraryCourses()

        }
    }
    
    class func getBegnenrCourses() -> Array<Any> {
        return [
        CourseModel.init(withTitle: "Swfit简介", identy: "BriefVC", brief: "23456789"),
        CourseModel.init(withTitle: "基础部分", identy: "BriefVC", brief: "23456789"),
        ]
    }
    
    class func getAdvanceCourses() -> Array<Any> {
        return [
            CourseModel.init(withTitle: "Swfit简介", identy: "BriefVC", brief: "23456789"),
            CourseModel.init(withTitle: "基础部分", identy: "BriefVC", brief: "23456789"),
        ]
    }
    
    class func getLibraryCourses() -> Array<Any> {
        return [
            CourseModel.init(withTitle: "Swfit简介", identy: "BriefVC", brief: "23456789"),
            CourseModel.init(withTitle: "基础部分", identy: "BriefVC", brief: "23456789"),
        ]
    }
    
}
