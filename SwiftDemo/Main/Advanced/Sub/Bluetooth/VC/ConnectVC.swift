//
//  ConnectVC.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/6/27.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit
import CoreBluetooth


class ConnectVC: BaseVC , CBPeripheralDelegate{

    open var peri:CBPeripheral?
    lazy var manager = BluetoothManager.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        
        
    }
    func initView() {
        guard let peri = self.peri else {
            return
        }
        manager.connectBlock = { (peri, error) in
            if self.peri != peri {
                return
            }
            if error == nil {
                self.title = "连接成功"
                peri.delegate = self
                //扫描
                peri.discoverServices(nil)
            }else{
                qxDebugLog((error?.localizedDescription)!)
                self.title = "连接失败"
            }
            
        }
        
        manager.connect(peripheral: peri)
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let peri = self.peri else {
            return
        }
        manager.disconnect(peripheral: peri)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:---CBPeripheralDelegate
    func peripheralDidUpdateName(_ peripheral: CBPeripheral){
        qxDebugLog("外设：名字更新")
    }
    //发现服务并扫描服务对应的特征
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if error != nil {
            qxDebugLog("外设：发现服务处置错：" + (error?.localizedDescription)!)
            return
        }
        qxDebugLog("外设：发现服务")
        guard let severs = peripheral.services else {
            return
        }
        for sever in severs {
            qxDebugLog(sever.uuid.uuidString)
            //服务并没有实际意义。我们需要用的是服务下的特征，查询（每一个服务下的若干）特征
            peripheral.discoverCharacteristics(nil, for: sever)
        }
    }
    
    //扫描到指定服务的自服务时调用
    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
        if error == nil {
             qxDebugLog("外设：扫描到子服务：" + service.uuid.uuidString)
        }else {
            qxDebugLog("外设：扫描子服务错误" + (error?.localizedDescription)!)
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]){
        qxDebugLog("外设：服务被修改")
    }
    func peripheralDidUpdateRSSI(_ peripheral: CBPeripheral, error: Error?){
        qxDebugLog("外设：RSSI更新")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?){
        qxDebugLog("外设：读取RSSI:" + "\(RSSI.intValue)")
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        //最终查询到的特征可能有两三个，也可能三五十个；但一般只会用到其中1-3个；至于哪个特征有用，哪个没用，怎么用，这个就要问蓝牙外设的厂家，如果厂家没有那就是....你自己去一个一个去猜，一个一个去试；每个特征一般用法有 setNotifyValue:YES 这种就是监听外设，有值就直接上传到手机；如果是read类型的，就用成员变量记录该特征，用timer定期读取这个特征的值；如果是write的特征，就是让你发送一些数据去设置、命令蓝牙外设的；同一个特征可以兼具read write,notify等特征；
        //特征用UUID来标记，iOS中一般UUID只用4位16进制数表示；比如下面例子中，同一批次的产品，他们的名称必然相同（VScale），其用于同一功能的特征的UUID也必然相同。
        guard qxCheckError(error, oprationMsg: "外设：扫描特征") else {
            return
        }
        qxDebugLog("外设：扫描特征")
        for characteristic in service.characteristics! {
            qxDebugLog(characteristic.uuid.uuidString)
            //服务并没有实际意义。我们需要用的是服务下的特征，查询（每一个服务下的若干）特征
        
            switch characteristic.uuid.uuidString {
            case "2A2A":
                //如果以通知的形式读取数据，则直接发到didUpdateValueForCharacteristic方法处理数据。
                peripheral.setNotifyValue(true, for: characteristic)
     
            case "2A37":
             //通知关闭，read方式接受数据。则先发送到didUpdateNotificationStateForCharacteristic方法，再通过readValueForCharacteristic发到didUpdateValueForCharacteristic方法处理数据。
                peripheral.readValue(for: characteristic)
            case "6E400002-B5A3-F393-E0A9-E50E24DCCA9E":

                //self.writeCharacteristic = characteristic as! CBCharacteristic
                let des  = "蓝牙通信"
                let data = des.data(using: String.Encoding.utf8)!
                //写入数据
                peripheral.writeValue(data, for: characteristic, type: .withResponse)
            default:
                break
            }
        }
        
        
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        qxDebugLog("外设：更新特征值")
        guard qxCheckError(error) else {
            return
        }
        qxDebugLog("2A38的值为:\(characteristic.value)")
        let data = characteristic.value! as Data
        
        switch characteristic.uuid.uuidString {
        case "2A2A":
            qxDebugLog("处理字节")
        case "2A37": break
            qxDebugLog("data->string")
        case "6E400002-B5A3-F393-E0A9-E50E24DCCA9E":
            qxDebugLog("...")
        default:
            break
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        qxDebugLog("外设：写入值")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        qxDebugLog("外设：更新通知状态")
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        qxDebugLog("外设：发现描述符")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        qxDebugLog("外设：更新描述")
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        qxDebugLog("外设：写入描述")
    }
    
    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral){
        qxDebugLog("外设：准备发送Response")
    }
    
    @available(iOS 11.0, *)
    public func peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: Error?) {
        qxDebugLog("外设：打开通道")
    }
}
