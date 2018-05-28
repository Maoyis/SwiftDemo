//
//  QXDateFormtter.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/5/24.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit
import Charts

class QXDateFormtter: NSObject ,IAxisValueFormatter{
    private var _values: [String] = [String]()
    private var _valueCount: Int = 0
    
    @objc public var values: [String]
        {
        get
        {
            return _values
        }
        set
        {
            _values = newValue
            _valueCount = _values.count
        }
    }
    
    public override init()
    {
        super.init()
        
    }
    
    @objc public init(values: [String])
    {
        super.init()
        
        self.values = values
    }
    
    @objc public static func with(values: [String]) -> IndexAxisValueFormatter?
    {
        return IndexAxisValueFormatter(values: values)
    }
    
    open func stringForValue(_ value: Double,
                             axis: AxisBase?) -> String
    {
        let index = Int(value.rounded())%30
        if values.indices.contains(index){
            return _values[index]
        }else{
            return "\(index)"
        }
        guard values.indices.contains(index), index == Int(value) else { return "" }
        return _values[index]
    }
}
