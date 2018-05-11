//
//  LeftVC.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/4/28.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit


let headerH = 50.0 as CGFloat

class LeftVC: BaseVC ,UITableViewDelegate, UITableViewDataSource{
 
    var selectedSection:Int = -1
    
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
        if section == self.selectedSection {
            let dic = self.data[section]
            let arr  = dic.first?.value
            return (arr?.count)!
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIButton.init(type: UIButtonType.custom)
        header.frame = CGRect(x:0, y:0, width:self.view.bounds.size.width, height:headerH)
        header.tag = 1000 + section
        header.backgroundColor = UIColor.app_F9F9F9
        if self.selectedSection == section {
            header.backgroundColor = UIColor.clear
        }
        let data = self.data[section]
        let text = "  " + (data.first?.key)!
        header.setTitle(text, for: UIControlState.normal)
        header.setTitleColor(UIColor.app_333333, for: UIControlState.normal)
        
        header.contentHorizontalAlignment = .left
        let label = header.titleLabel
        label?.font = UIFont.systemFont(ofSize: 15)
        
        header.addTarget(self, action: #selector(appearCourse), for: UIControlEvents.touchUpInside)
        
        return header;
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let dic = self.data[indexPath.section]
        let arr  = dic.first?.value
        
        let model = arr![indexPath.row]
        cell.indentationWidth = 5
        cell.indentationLevel = 1
        cell.textLabel?.text = "\(indexPath.section+1).\(indexPath.row+1) " + model.title
        return cell;
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //具体操作
        let dic = self.data[indexPath.section]
        let arr  = dic.first?.value
        
        let model = arr![indexPath.row]
        self.gotoCourse(withCourse: model)
        
        //收起菜单
        self.menuSwitch()
    }
    //MARK:Table常规设置
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerH
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    //MARK:----Action
    func gotoCourse(withCourse model:CourseModel) -> Void {
        switch model.type {
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
    }
    func gotoBoard(withModel model:CourseModel) -> Void {
        let web = QXWebVC()
        web.url   = model.data as! String
        web.title = model.title
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
        web.title = model.title
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
    
    @objc func appearCourse(header:UIButton) -> Void {
        let section = header.tag - 1000
        if self.selectedSection == section {
            self.selectedSection = -1
        }else{
            
            self.selectedSection = section
        }
        self.table.reloadData()
        
    }
    
    
}
