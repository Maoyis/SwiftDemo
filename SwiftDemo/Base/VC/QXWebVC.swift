//
//  QXWebVC.swift
//  SwiftDemo
//
//  Created by CreateCare on 2018/5/9.
//  Copyright © 2018年 CreateCare. All rights reserved.
//

import UIKit
import WebKit


/**
 由于过往一直使用UIWebView,所以这次就来试水一下WKWebView, WKWebView是苹果在WWDC2014发布会中发布IOS8的时候公布WebKit时候使用的新型的H5容器
 【PS】
 优点：
    1、WKWebView的代理方法提供了比UIWebView颗粒度更细的方法。让开发者可以进行更加细致的配置和处理。（将UIWebViewDelegate和UIWebView重构成了14个类，3个协议，可以让开发者进行更加细致的配置。）
    2、与UIWebView相比较，拥有更快的加载速度和性能，更低的内存占用。
 缺点：
    WKWebView的请求不能被NSURLProtocol截获（对我们的demo无影响）
 */
class QXWebVC: BaseVC,  WKNavigationDelegate, WKUIDelegate{
    
    let progressH = 1.5
    
    var data:String  = ""
    var isHTML:Bool = false
    
    lazy var progressView: UIView = {
        let pv = UIView.init(frame: CGRect(x:0, y:0, width:2, height:self.progressH))
        pv.backgroundColor = UIColor.app_mainTheme
        self.web.addSubview(pv)
        return pv
    }()
    
    lazy var web: WKWebView = {
        let web = WKWebView.init(frame: self.view.bounds)
        web.navigationDelegate = self
        web.backgroundColor = UIColor.init(rgba: 0xf0f0f0ff)
        //web.uiDelegate         = self
        return web
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.isHTML {
            let fileUrl = Bundle.main.url(forResource:self.data, withExtension: "html")
            self.web.loadFileURL(fileUrl!, allowingReadAccessTo:fileUrl!)
        }else{
            let url = URL.init(string: self.data)
            let request = NSURLRequest.init(url: url!)
            self.web.load(request as URLRequest)
        }
        self.view.addSubview(self.web)
        self.web.addSubview(self.progressView)
        self.addProgressObsever()
   
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.web.frame = self.view.bounds
    }
    func addProgressObsever() {
        self.web.addObserverBlock(forKeyPath: "estimatedProgress") { (obj, old, new) in
            let width = self.view.bounds.size.width
            let progress = new as! CGFloat
            if  progress >= 1.0 {
                self.progressView.removeAllSubviews()
                self.progressView.frame = CGRect(x:0, y:0, width:0.1, height:self.progressH)
            }else{
                let actual = width*progress 
                self.progressView.frame = CGRect(x:0.0, y:0.0, width:Double(actual), height:self.progressH)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK:-----WKNavigationDelegate

    ///1. 根据webView、navigationAction相关信息决定这次跳转是否可以继续进行,这些信息包含HTTP发送请求，如头部包含User-Agent,Accept,refer
    ///在发送请求之前，决定是否跳转的代理
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //必须设置该回调
        decisionHandler(WKNavigationActionPolicy.allow)
        log("1.在发送请求之前，决定是否跳转的代理")
    }
    
    ///2. 这个代理方法表示当客户端收到服务器的响应头，根据response相关信息，可以决定这次跳转是否可以继续进行。
    ///在收到响应后，决定是否跳转的代理
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        //必须设置该回调
        decisionHandler(WKNavigationResponsePolicy.allow)
        log("2.在收到响应后，决定是否跳转的代理")
    }
    ///3. 当开始为主框架加载数据时发生错误。
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        log("3.当开始为主框架加载数据时发生错误。")
    }
    ///4. 需要身份验证时调用
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
         log("4. 需要身份验证时调用")
        // 判断是否是信任服务器证书
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            //先前失败的身份验证尝试的计数为0则信任
            if (challenge.previousFailureCount == 0) {
                // 通过completionHandler告诉服务器信任证书
                let credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
                //使用指定的凭据，可能为nil。
                completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential);
                
            } else {
                
                completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil);
                
            }
            
        } else {
            
            completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil);
            
        }
        
       
    }

    ///5. 准备加载页面。等同于UIWebViewDelegate: - webView:shouldStartLoadWithRequest:navigationType
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        log("5. 准备加载页面")
    }
    ///6. 内容开始加载. 等同于UIWebViewDelegate: - webViewDidStartLoad:
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        log("6. 内容开始加载.")
    }
    ///7. 页面加载失败。 等同于UIWebViewDelegate: - webView:didFailLoadWithError:
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        log("7. 页面加载失败")
    }
    ///8. 这个代理是服务器redirect时调用
    ///接收到服务器跳转请求的代理
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        log("8.服务器发生redirect")
    }
    ///9. 页面加载完成。 等同于UIWebViewDelegate: - webViewDidFinishLoad:
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        log("9. 页面加载完成。")
    }
    
    ///10. 当webview的web内容进程终止时调用。
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        log("10. 当webview的web内容进程终止时调用。")
    }
    
   
    func log(_ msg:String)  {
        //debugPrint(msg)
    }
    
   
   

}
