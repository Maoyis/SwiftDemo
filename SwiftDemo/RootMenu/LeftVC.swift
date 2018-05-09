//
//  LeftVC.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/4/28.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit

class LeftVC: BaseVC ,UITableViewDelegate, UITableViewDataSource{
 
    var data:Array<Dictionary<String, Array<CourseModel>>> = []
    
    lazy var table: UITableView = {
        let table = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.grouped)
        table.tableFooterView = UIView.init()
        table.tableHeaderView = UIView.init(frame: CGRect(x:0, y:0, width:self.view.bounds.size.width, height:0.1))
        table.delegate   = self;
        table.dataSource = self;
        
        self.view.addSubview(table)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.clipsToBounds = true
        self.registerCell()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.data = CourseModel.getCourseData(withType: self.appSelectType())
        self.table.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//MARK:初始配置
    func registerCell() -> Void {
        self.table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
    }

    
//MARK:tabledelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dic = self.data[section]
        let arr  = dic.first?.value
        return (arr?.count)!
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel.init(frame:CGRect(x:0, y:0, width:self.view.bounds.size.width, height:20));
        label.font = UIFont.systemFont(ofSize: 12)
        let data = self.data[section]
        label.text = "  " + (data.first?.key)!
        return label;
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let dic = self.data[indexPath.section]
        let arr  = dic.first?.value
        
        let model = arr![indexPath.row]
        
        cell.textLabel?.text = model.title
        return cell;
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //具体操作
        let dic = self.data[indexPath.section]
        let arr  = dic.first?.value
        
        let model = arr![indexPath.row]
        var type = ShowWay.board
        switch model.type {
        case 1:
            type = ShowWay.xib
        case 2:
            type = ShowWay.url
        case 3:
            type = ShowWay.text
        case 4:
            type = ShowWay.list
        default:
            type = ShowWay.board
        }
        switch type {
        /// storyboard
        case ShowWay.board:
            self.gotoBoard(withModel: model)
        /// xib
        case ShowWay.xib:
            self.gotoXib(withModel: model)
        /// webView
        case ShowWay.url:
            self.gotoWeb(withModel: model)
        /// 文本
        case ShowWay.text:
            self.gotoText(withModel: model)
        /// 列表
        case ShowWay.list:
            self.gotoList(withModel: model)
        }
        
        //收起菜单
        self.menuSwitch()
    }
    
    
    func gotoBoard(withModel model:CourseModel) -> Void {
        let web = QXWebVC()
        web.url = model.data as! String
        self.gotoCourseVC(widthVC: web)
    }
    func gotoXib(withModel model:CourseModel) -> Void {
        let web = QXWebVC()
        web.url = model.data as! String
        self.gotoCourseVC(widthVC: web)
    }
    func gotoWeb(withModel model:CourseModel) -> Void {
        let web = QXWebVC()
        web.url = model.data as! String
        self.gotoCourseVC(widthVC: web)
    }
    func gotoText(withModel model:CourseModel) -> Void {
        let web = QXWebVC()
        web.url = model.data as! String
        self.gotoCourseVC(widthVC: web)
    }
    func gotoList(withModel model:CourseModel) -> Void {
        let web = QXWebVC()
        web.url = model.data as! String
        self.gotoCourseVC(widthVC: web)
    }
    func gotoCourseVC(widthVC vc:UIViewController) {
        let root  = self.appRootVC()
        let tabVC = root.mainViewController as! BaseTabBarVC
        let nav   = tabVC.selectedViewController as! BaseNav
        nav.pushViewController(vc, animated: true)
    }
    
    
    
    //MARK:Table常规设置
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
