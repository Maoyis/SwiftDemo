//
//  ChartsVC.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/5/24.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit
import Charts
class ChartsVC: BaseVC, ChartViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK:-----ChartViewDelegate
    //选中响应
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("选中响应")
    }
    //取消响应
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
         print("取消选中响应")
    }
    //缩放回调
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
         print("缩放回调")
    }
    // 移动回调
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
         print("移动回调")
    }
}
