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


enum ShowWay {

    /// storyboard
    case board
    /// xib
    case xib
    /// webView
    case url
    /// 文本
    case text
    /// 列表
    case list
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
    @objc var data:Any                = ""
    override init() {
        super.init()
    }
    
    
    init(withTitle title:String, identy:String, brief:String) {
        super.init()
        self.title    = title
        self.brief    = brief
        self.identy   = identy
    }
    
    
//MARK:------加载数据--
    
    /// 通过本地plist文件加载对应数据
    ///
    /// - Parameter file: 文件名
    /// - Returns: 所需数据
    class func getCourseData(withFile file:String) -> Array<Dictionary<String, Array<CourseModel>>> {
        let path = Bundle.main.path(forResource: file, ofType: "plist")
        let data = NSArray(contentsOfFile: path!) as! Array<Dictionary<String, Any>>
        var modelData:Array<Dictionary<String, Array<CourseModel>>> = []
        for dic in data {
            let key   = dic.first?.key
            let value = dic.first?.value as! Array<Dictionary<String, Any>>
            let json = self.jsonData(obj: value as Any)
            let models = NSArray.modelArray(with: self.classForCoder(), json:json) as! Array<CourseModel>
            modelData.append([key!:models])
        }
        return modelData
    }
    
    class func jsonData(obj:Any) ->  Data{
         let jsonData = try? JSONSerialization.data(withJSONObject:obj, options: JSONSerialization.WritingOptions.prettyPrinted)
        return jsonData!
    }
    
    class func getCourseData(withType type:CourseType) -> Array<Dictionary<String, Array<CourseModel>>> {
        switch type {
        case CourseType.Begnner:
            return self.getBegnenrCourses()
        case CourseType.Advanced:
            return self.getAdvanceCourses()
        case CourseType.Library:
            return self.getLibraryCourses()

        }
    }
    
    class func getBegnenrCourses() -> Array<Dictionary<String, Array<CourseModel>>> {
        
        return self.getCourseData(withFile: "beginner")
    }
    
    class func getAdvanceCourses() -> Array<Dictionary<String, Array<CourseModel>>> {
        return self.getCourseData(withFile: "advance")
    }
    
    class func getLibraryCourses() -> Array<Dictionary<String, Array<CourseModel>>> {
        return self.getCourseData(withFile: "library")
    }
    
}
