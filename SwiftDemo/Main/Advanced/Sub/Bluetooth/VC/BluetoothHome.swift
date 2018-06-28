//
//  BluetoothHome.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/6/27.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit
import CoreBluetooth
class BluetoothHome: BaseVC, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var table: UITableView!
    
    var data:[CBPeripheral] = []
    
    lazy var manager = BluetoothManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.configManager()
        self.manager.startScan()
        // Do any additional setup after loading the view.
    }
    func initView()  {
        self.table.tableFooterView = UIView.init()
    }
    func configManager()  {
        manager.configManager(stateChangeBlock: { (state) in
            self.title = BluetoothManager.getCentStateDes(state)
            if state == .poweredOn {
                self.manager.startScan()
                self.navigationController?.navigationBar.barTintColor = UIColor.white
            }else{
                self.navigationController?.navigationBar.barTintColor = UIColor.red
            }
        }) { (per, ads, rssi) in
            self.data.append(per)
            self.table.insertRow(at: IndexPath.init(row: 0, section: 0), with: UITableViewRowAnimation.left)
            BluetoothManager.parseAdvertisementData(ads)
            self.table.reloadData()
        }
    }
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        manager.restoreManager()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identy = "identy"
        var cell = tableView.dequeueReusableCell(withIdentifier: identy)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: identy)
            cell?.accessoryType = .disclosureIndicator
        }
        let model = data[indexPath.row]
        var name = model.name
        if name == nil{
             name = "unknow" + "\(model.hash)"
        }
        switch model.state {
        case .connected:
            cell?.accessoryType = .checkmark
        default:
            cell?.accessoryType = .none
        }
        cell?.textLabel?.text       = name!
        cell?.detailTextLabel?.text = model.identifier.uuidString
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = data[indexPath.row]
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConnectVC") as! ConnectVC
        vc.peri = model
        self.navigationController?.pushViewController(vc, animated: true)
    }


}
