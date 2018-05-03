//
//  CourseModel.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/4/28.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit
import YYKit
enum CourseType {
    case Begnner
    case Advanced
    case Library
  
}
enum ShowType {
    case xib
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
    
    class func getCourseData(withFile file:String) -> Array<Dictionary<String, Any>> {
        let path = Bundle.main.path(forResource: file, ofType: "plist")
        let data = NSArray(contentsOfFile: path!) as! Array<Dictionary<String, Any>>
        var modelData:Array<Dictionary<String, Any>> = []
        for dic in data {
            let key   = dic.first?.key
            let value = dic.first?.value as! Array<Dictionary<String, Any>>
            
//            for dict in value {
//                let model = CourseModel()
//                status.yy_modelSet(with: dict)
//                array.append(status)
//            }
            
            
            let json = self.jsonData(obj: value as Any)
            let strJson = NSString(data: json, encoding: String.Encoding.utf8.rawValue)
            let models = NSArray.modelArray(with: self.classForCoder(), json:json)
            modelData.append([key!:models as Any])
        }
        return data
    }
    
    class func jsonData(obj:Any) ->  Data{
         let jsonData = try? JSONSerialization.data(withJSONObject:obj, options: JSONSerialization.WritingOptions.prettyPrinted)
        return jsonData!
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
