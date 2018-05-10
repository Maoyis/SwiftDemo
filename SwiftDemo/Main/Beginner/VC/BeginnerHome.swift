//
//  BeginnerHome.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/4/28.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit
import WebKit

class BeginnerHome: BaseVC {

    @IBOutlet weak var web: WKWebView!
    lazy var fileUrl: URL = {
        let url = Bundle.main.url(forResource: "Beginner", withExtension: "html")
        return url!
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.web.loadFileURL(self.fileUrl, allowingReadAccessTo: self.fileUrl)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
