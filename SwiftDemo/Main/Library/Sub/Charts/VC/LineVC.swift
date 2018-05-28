//
//  LineVC.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/5/24.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit
import Charts
class LineVC: ChartsVC, IFillFormatter{
    
    

    @IBOutlet weak var lineView: LineChartView!
    
    
    @IBOutlet weak var reset: UIButton!
    
    lazy var marker: RadarMarkerView = {
         let  marker = RadarMarkerView.viewFromXib()
        return marker as! RadarMarkerView
    }()
    
    
    @IBAction func resetAction(_ sender: Any) {
        self.lineView.fitScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineView.delegate = self as ChartViewDelegate
        self.initConfig()
        
       
        self.initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initConfig() {
        //----BarLineChartViewBase
        
        //能否缩放
        lineView.setScaleEnabled(true)
        //能否捏和
        lineView.pinchZoomEnabled = true
        lineView.scaleYEnabled = false
        lineView.scaleXEnabled = false
        //能否拖动
        lineView.dragEnabled = true
        //拖拽后是否有惯性效果
        lineView.dragDecelerationEnabled = true
        //拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        lineView.dragDecelerationFrictionCoef = 0.9
        lineView.autoScaleMinMaxEnabled = true
        
        //------ChartViewBase
        //是否启用描述组件
        lineView.chartDescription?.enabled = true
        lineView.chartDescription?.text    = "折线图"
        //tag样式
        lineView.legend.form = .circle
        
        
        
        
        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 10, label: "Index 10")
        llXAxis.lineWidth = 4
        llXAxis.lineDashLengths = [10, 1, 10]
        llXAxis.labelPosition = .rightBottom
        llXAxis.valueFont = .systemFont(ofSize: 10)
        
        let ll1 = ChartLimitLine(limit: 150, label: "Upper Limit")
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .rightTop
        ll1.valueFont = .systemFont(ofSize: 10)
        
        let ll2 = ChartLimitLine(limit: -30, label: "Lower Limit")
        ll2.lineWidth = 4
        ll2.lineDashLengths = [5,5]
        ll2.labelPosition = .rightBottom
        ll2.valueFont = .systemFont(ofSize: 10)
        //纵轴设置
        let leftAxis = lineView.leftAxis
        leftAxis.axisMaximum = 100
        leftAxis.axisMinimum = -10
        leftAxis.labelCount  = 10
        leftAxis.gridLineDashLengths = [5, 0]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        leftAxis.removeAllLimitLines()
//        leftAxis.addLimitLine(ll1)
//        leftAxis.addLimitLine(ll2)
//        leftAxis.addLimitLine(llXAxis)
//
 
        //不要右侧纵轴
        lineView.rightAxis.enabled = false
        //横轴
        //是否绘制网格线
        lineView.xAxis.drawGridLinesEnabled = true
        lineView.xAxis.gridLineDashLengths = [30, 0]
        lineView.xAxis.axisMinimum = 0
        lineView.xAxis.gridLineDashPhase = 10
        lineView.xAxis.labelCount        = 10
        lineView.xAxis.spaceMin          = 1
        lineView.xAxis.labelPosition = .bottom
        lineView.setScaleMinima(3, scaleY: 1)
//        lineView.setVisibleXRangeMinimum(5)
//        lineView.setVisibleXRangeMaximum(30)
        
        
        
        //设置折线图的数据
        let xValues = (0..<30).map { (i) -> String in
            return "\(i+1)日"
        }
        //设置X轴坐标
        lineView.xAxis.valueFormatter = QXDateFormtter(values: xValues)
        //显示动画时长
        lineView.animate(xAxisDuration: 1.5)
        
//        var marker = XYMarkerView(color: UIColor(white: 180/255, alpha: 1),
//                                  font: .systemFont(ofSize: 12),
//                                  textColor: .white,
//                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8), xAxisValueFormatter: QXDateFormtter(values: xValues))
//        marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
//                              font: .systemFont(ofSize: 12),
//                              textColor: .white,
//                              insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = lineView;
        lineView.marker = self.marker
        
    }
    func initData() {
        let set1 = self.initData(startValue: 0, end: 10, color: .orange)
        let set2 = self.initData(startValue: 10, end: 20, color: .app_mainTheme)
        let set3 = self.initData(startValue: 20, end: 30, color: .yellow)
        let set4 = self.initData(startValue: 30, end: 40, color: .orange)
        let data = LineChartData(dataSets: [set1, set2, set3, set4])
        
        lineView.data = data
    }
    func initData(startValue:Int, end endValue:Int, color:UIColor) -> LineChartDataSet{
        let values = (startValue..<endValue+1).map { (i) -> ChartDataEntry in
            var val = Double(arc4random_uniform(30) + 30)
            if i%10 == 0 {
                val = 50
            }
            
            return ChartDataEntry.init(x: Double(i), y: val, icon: #imageLiteral(resourceName: "icon"), data: "o.o" as AnyObject)
            
        }
        
        let set1 = LineChartDataSet(values: values, label: "")
        
        set1.drawIconsEnabled = true
        //点值字体
        set1.valueFont = .systemFont(ofSize: 9)
        //标签颜色
        set1.setColor(color)
        //连线宽度
        set1.lineWidth = 2
        //外圆
        set1.setCircleColor(color)
        set1.drawCirclesEnabled = true
//        set1.setCircleColors(.black, .red, .blue, .app_333333, .app_mainTheme)
        set1.circleRadius = 5
        
        //内圆
        set1.circleHoleColor = .white
        set1.drawCircleHoleEnabled = true
        set1.circleHoleRadius = 3
        //连线———— ———— 15为线长 2.5为间隙
        set1.lineDashLengths = [15, 0]
        set1.highlightLineDashLengths = [5, 2.5]
        set1.formLineDashLengths = [35, 25]
        set1.formLineWidth = 20
        set1.formSize = 15
        
        
        set1.fillAlpha = 1
        let gradientColors = [UIColor.white.cgColor, color.changeAlpha(alpha: 0.5).cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fill = Fill(linearGradient: gradient, angle: 90)
        set1.fillFormatter = self
        set1.drawFilledEnabled = true

        
        return set1
    }
    func getFillLinePosition(dataSet: ILineChartDataSet, dataProvider: LineChartDataProvider) -> CGFloat {
        
        return 0
    }
    
    
    //选中响应
    override func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {

    }
    //取消响应
    override func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("取消选中响应")
    }
}
