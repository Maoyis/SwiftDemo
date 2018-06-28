//
//  BluetoothManager.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/6/27.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit
import CoreBluetooth



/**
 RSSI---Received Signal Strength Indication接收的信号强度指示，无线发送层的可选部分，用来判定链接质量，以及是否增大广播发送强度。
 
 
 */







//MARK:-----block

typealias QXStateChangeBlock       = (CBManagerState) -> Void
//typealias QXPeripheralsChangeBlock = ([CBPeripheral], [String : Any], NSNumber) -> Void
typealias QXDiscoverNewPeriBlock = (CBPeripheral, [String : Any], NSNumber) -> Void

typealias QXConnectBlock = (CBPeripheral, Error?) -> Void
//MARK:----Notify
let BluetoothStateChangeNotify = NSNotification.Name.init("BluetoothStateChangeNotify" + ".lqx.com")
let BluetoothDiscoverNewPeripheral = NSNotification.Name.init("BluetoothDiscoverNewPeripheral" + ".lqx.com")

class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    
    
    
    /// 当前设备蓝牙状态
    var state:CBManagerState!
    /// 自动连接外设名
    var autoConnectName:[String] = []
    
    /// 设备蓝牙状态变更回调
    var stateChangeBlock       :  QXStateChangeBlock?
    /// 被发现外设数组变更回调
    var discoverNewPeriBlock   :  QXDiscoverNewPeriBlock?
    /// 连接block
    var connectBlock           :  QXConnectBlock?
    
//MARK:---懒加载
    lazy var manager: CBCentralManager = {
        let m = CBCentralManager.init(delegate: self, queue: nil)
        return m
    }()
    
    lazy var peripherals: [CBPeripheral] = {
        let peripherals: [CBPeripheral] = []
        return peripherals
    }()
    
    
    
    
    
    //单行单例模式 --https://www.jianshu.com/p/b45f42aed00a
    static let sharedInstance = BluetoothManager()
    //private override init() {}
    private override init() {
        super.init()
        self.state = self.manager.state
    }
    //MARK:-----内部处理
    private func handleStateChange(_ state:CBManagerState) {
        qxDebugLog(BluetoothManager.getCentStateDes(state))
        postNotify(name: BluetoothStateChangeNotify, msg: state)
        guard let block = self.stateChangeBlock else {
            return
        }
        block(state)
    }
    private func handlePeripheralsChange(_ peripheral:CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        postNotify(name: BluetoothDiscoverNewPeripheral, msg:
            ["peripheral"        : peripheral,
             "advertisementData"  : advertisementData,
             "RSSI"               : RSSI
            ])
        guard let block = self.discoverNewPeriBlock else {
            return
        }
        block(peripheral, advertisementData, RSSI)
    }
    //MARK:---Tool
    //解析 广播数据
    static func parseAdvertisementData(_ data: [String : Any])  {
        let keys = [
            //String--对应的值是一个字符串,描述外设的名称
            CBAdvertisementDataLocalNameKey,
            //Bool--标示公布事件类型是否为可连接的,对应这个Key是一个 NSNumber对象,你可用使用这个值来检查一个外设当前是否为连接状态
            CBAdvertisementDataIsConnectable,
            //Number---一个包含外设发射功率NSNumber的数字,如果外设在广播的数据包中,提供了他的`Tx`功率级别时候,这个属性是可用的. 可以使用这个`RSSI` 值和电台功率,计算出路径损耗.
            CBAdvertisementDataTxPowerLevelKey,
            //Array--包含特定服务的分发数据,该字典的key为代表着该服务的CBUUID对象.值为NSData对象
            CBAdvertisementDataServiceUUIDsKey,
            //Dictionary--需要公布的服务的`UUID`数组
            CBAdvertisementDataServiceDataKey,
            //data--对应的值是一个NSData对象,包含外设的产生的数据
            CBAdvertisementDataManufacturerDataKey,
            //Array--代表着在公布数据的"overflow"区域能够被发现的服务的UUID的数组,因为存储在这个`UUID`列表是`最大努力的` 并且不总是精确的.如果设备资源不足这些属性可能不会被公布.
            CBAdvertisementDataOverflowServiceUUIDsKey,
            //Array一个代表着一个或多个服务的`UUID`
            CBAdvertisementDataSolicitedServiceUUIDsKey
        ]
        let des  =  ["本地名称", "是否连接", "发射功率", "UUID", "服务UUIDs", "外设数据", "溢出UUIDs", "多服务UUIDs"]
        qxDebugLog("---------------")
        var i = 0
        for key in keys {
            i += 1
            guard let value = data[key] else {
                continue
            }
            qxDebugLog(des[i-1] + ":" + "\(value)")
        }
        qxDebugLog("---------------\n")
        
        
    }
    
    
    
    static func getCentStateDes(_ state:CBManagerState) -> String {
        var msg = ""
        switch state {
        case .poweredOff:
            msg = "蓝牙处于关闭"
        case .poweredOn:
            msg = "蓝牙已经打开"
        case .resetting:
            msg = "蓝牙已经重置"
        case .unauthorized:
            msg = "蓝牙未授权"
        case .unknown:
            msg = "未知情况"
        case .unsupported:
            msg = "设备不支持的蓝牙"
        }
        return msg
    }
    
    //MARK:----API
    
    /// 配置回调处理（请不要与通知重复使用）
    ///
    /// - Parameters:
    ///   - stateChangeBlock: 设备蓝牙状态变更回调
    ///   - perisChangeBlock: 被发现外设数组变更回调
    func configManager(stateChangeBlock:QXStateChangeBlock?, discoverNewPeriBlock: QXDiscoverNewPeriBlock?)  {
        self.discoverNewPeriBlock = discoverNewPeriBlock
        self.stateChangeBlock = stateChangeBlock
    }
    func restoreManager() {
        self.peripherals.removeAll()
        self.manager.stopScan()
        self.discoverNewPeriBlock = nil
        self.stateChangeBlock     = nil
        self.connectBlock         = nil
    }
    ///开始扫描
    func startScan() {
        self.startScan(withService: nil, options: nil)
    }
    /// 定向扫描
    ///
    /// - Parameters:
    ///   - serviceUUIDs: 服务UUID数组
    ///   - options:      相关设置
    func startScan(withService serviceUUIDs:[CBUUID]?, options:[String:Any]?)  {
        manager.stopScan()
        guard self.state == .poweredOn else {
            qxDebugLog("请确保蓝牙处于正常开启状态，再进行扫描！")
            return
        }
        manager.scanForPeripherals(withServices: serviceUUIDs, options: options)
    }
    func connect(peripheral:CBPeripheral) {
        connect(peripheral: peripheral, options: nil)
    }
    func connect(peripheral:CBPeripheral, options:[String:Any]?) {
        manager.connect(peripheral, options: options)
    }
    
    func disconnect(peripheral:CBPeripheral)  {
        if peripheral.state == .connected {
            manager.cancelPeripheralConnection(peripheral)
        }
    }
    
    func postNotify(name:Notification.Name, msg:Any?) {
        NotificationCenter.default.post(name: name, object: msg)
    }
    
    
    //MARK:---CBCentralManagerDelegate
    
    ///状态变更
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        BluetoothManager.sharedInstance.state = central.state
        handleStateChange(central.state)
    }
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        qxDebugLog("重置蓝牙")
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        //不重复添加
        if peripherals.contains(peripheral) {
            return
        }
        //添加新外设
        peripherals.append(peripheral)
        handlePeripheralsChange(peripheral, advertisementData: advertisementData, rssi: RSSI)
        guard let name = peripheral.name else {
            return
        }
        
        //自动连接
        if autoConnectName.contains(name) {
            self.connect(peripheral: peripheral)
        }
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        qxDebugLog("连接外设成功！")
        guard let block = self.connectBlock else {
            return
        }
        block(peripheral, nil)
        
    }
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        qxDebugLog("连接外设失败！")
        guard let block = self.connectBlock else {
            return
        }
        if error == nil {
            let custom = NSError.init(domain: "Bluetooth.com.lanyi", code: -1001, userInfo: [NSLocalizedDescriptionKey:"未知错误"]) as Error
            block(peripheral, custom)
        }else{
            block(peripheral, error)
        }
        
    }
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        guard let name = peripheral.name else {
            return
        }
        print("外设连接断开:" + name)
    }
    //MARK:---CBPeripheralDelegate
    func peripheralDidUpdateName(_ peripheral: CBPeripheral){
            
    }
    //发现服务并扫描服务对应的特征
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let severs = peripheral.services else {
            return
        }
        for sever in severs {
            print(sever.uuid.uuidString)
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
        
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]){
        
    }
    func peripheralDidUpdateRSSI(_ peripheral: CBPeripheral, error: Error?){
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?){
        
    }
    

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        
    }
    
    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral){
        
    }
    
    @available(iOS 11.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: Error?) {
        
    }
    
}
