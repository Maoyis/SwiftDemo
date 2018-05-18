//
//  ChartsHomeVC.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/5/18.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit

class ChartsHomeVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var data:Array<String> = ["简介", "饼状图"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.table.tableFooterView = UIView.init()
        // Do any additional setup after loading the view.
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
        let value = self.data[indexPath.row]
        cell.textLabel?.text = value 
        
        return cell;
        
    }
    
    //MARK:---点击相应动作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //具体操作

    }
    

}
