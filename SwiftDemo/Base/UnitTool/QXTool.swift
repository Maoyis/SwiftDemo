//
//  QXTool.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/6/27.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import Foundation
import UIKit

let openLog = true

func qxDebugLog(_ msg: String) {
    //    #if DEBUG
    //    debugPrint(msg)
    //    #endif
    if openLog {
        print(msg)
    }
  
}

func qxCheckError(_ error:Error?) -> Bool {
    return qxCheckError(error, oprationMsg: nil)
}

func qxCheckError(_ error:Error?, oprationMsg:String?) -> Bool {
    if error == nil {
        return true
    }else{
        if var des = error?.localizedDescription {
            des = oprationMsg==nil ? "错误：" + des : (oprationMsg! + "\n 错误：" + des)
            qxDebugLog(des)
        }
        return false
    }
}
