//
//  RadarMarkerView.swift
//  ChartsDemo
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import Charts

public class RadarMarkerView: MarkerView {
    @IBOutlet var label: UILabel!
    
    public override func awakeFromNib() {
        self.offset.x = -self.frame.size.width / 2.0
        self.offset.y = -self.frame.size.height - 7.0
    }
    
    public override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        label.text = String.init(format: "%d %%", Int(round(entry.y)))
        layoutIfNeeded()
    }
    
    
    @IBAction func action(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        print("-----action------")
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint {
        
        let temp = super.offsetForDrawing(atPoint: point)
        
        
        return temp
    }
    public override func draw(context: CGContext, point: CGPoint)
    {
        //super.draw(context: context, point: point)
        self.center = CGPoint(x: point.x, y: point.y-40)
        if chartView != nil {
            chartView?.addSubview(self)
        }
    }
    
    
    public override func nsuiTouchesBegan(_ touches: Set<NSUITouch>, withEvent event: NSUIEvent?)
    {
         self.removeFromSuperview()
    }


   
}
