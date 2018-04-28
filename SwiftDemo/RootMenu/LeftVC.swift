//
//  LeftVC.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/4/28.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit

class LeftVC: BaseVC ,UITableViewDelegate, UITableViewDataSource{
 
    lazy var data:[Any] = []
    lazy var table: UITableView = {
        let table = UITableView.init(frame: self.view.bounds)
        table.tableFooterView = UIView.init()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let value = self.data[indexPath.row]
        
        cell.textLabel?.text = value as? String
        return cell;
        
    }
}
