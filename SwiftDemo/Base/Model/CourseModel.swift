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
    /**storyboard上标识*/
    @objc var identy:String           = ""
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
            return self.getBegnenrCourses()
        case CourseType.Library:
            return self.getBegnenrCourses()

        }
    }
    
    class func getBegnenrCourses() -> Array<Any> {
        return [
        CourseModel.init(withTitle: "Swfit简介", identy: "BriefVC", brief: "23456789"),
        CourseModel.init(withTitle: "Swfit简介1", identy: "BriefVC", brief: "23456789"),
        ]
    }
    
}
