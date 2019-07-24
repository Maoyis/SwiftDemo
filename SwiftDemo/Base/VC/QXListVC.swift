//
//  QXListVC.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/5/15.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit

class QXListVC: BaseVC,UITableViewDelegate, UITableViewDataSource{
    
    
    var data:Array<CourseModel> = []
    
    lazy var table: UITableView = {
        let frame = self.view.bounds
        // self.view.bounds
        let table = UITableView.init(frame:frame, style: UITableViewStyle.plain)
        table.tableFooterView = UIView.init()
        table.backgroundColor = UIColor.clear
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        let model = self.data[indexPath.row]
        cell.textLabel?.text = model.title

        return cell;
        
    }

    //MARK:---点击相应动作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //具体操作
        let model = self.data[indexPath.row]
        self.gotoCourse(withCourse: model)
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
        /// html
        case ShowWay.html:
            self.gotoHTML(withModel: model)
        case .framework:
            self.gotoFramework(withModel: model)
        }
    }
    //MARK:----对应类型跳转处理
    func gotoBoard(withModel model:CourseModel) -> Void {

    }
    func gotoXib(withModel model:CourseModel) -> Void {

    }
    func gotoWeb(withModel model:CourseModel) -> Void {
        let web = QXWebVC()
        web.data = model.data as! String
        web.title = model.title
        self.gotoCourseVC(widthVC: web)
    }
    func gotoFramework(withModel model:CourseModel) -> Void {
        let web = QXWebVC()
        web.data = "https://developer.apple.com/documentation/" +  model.title
        web.isHTML = false
        web.title = model.title
        self.gotoCourseVC(widthVC: web)
    }
    func gotoHTML(withModel model:CourseModel) -> Void {
        let web = QXWebVC()
        web.data = model.data as! String
        web.isHTML = true
        web.title = model.title
        self.gotoCourseVC(widthVC: web)
    }
    func gotoText(withModel model:CourseModel) -> Void {
   
    }
    func gotoList(withModel model:CourseModel) -> Void {
        let listVC = QXListVC()
        listVC.title = model.title
        listVC.data = NSArray.modelArray(with: CourseModel.classForCoder(), json: model.data) as! Array<CourseModel>
        self.gotoCourseVC(widthVC: listVC)
    }
    func gotoCourseVC(widthVC vc:UIViewController) {
        let root  = self.appRootVC()
        let tabVC = root.mainViewController as! BaseTabBarVC
        let nav   = tabVC.selectedViewController as! BaseNav
        nav.pushViewController(vc, animated: true)
    }

 
}





