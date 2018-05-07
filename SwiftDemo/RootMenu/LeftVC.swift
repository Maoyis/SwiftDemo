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
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let dic = self.data[indexPath.section]
        let arr  = dic.first?.value
        
        let model = arr![indexPath.row]
        
        cell.textLabel?.text = model.title
        return cell;
        
    }
}
