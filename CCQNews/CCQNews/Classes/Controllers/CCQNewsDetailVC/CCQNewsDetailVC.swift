//
//  CCQNewsDetailVC.swift
//  CCQNews
//
//  Created by test on 2019/4/3.
//  Copyright © 2019 test1. All rights reserved.
//

import UIKit
import WebKit
class CCQNewsDetailVC: CCQBaseViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    var urlStrig: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    ///重写父类的setupUI方法
    override func setupUI() {
        super.setupUI()
        navigationItem.title = "详情"
        setupWebView()
    }
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        print("释放了")
    }
}
// MARK: - 设置界面
extension CCQNewsDetailVC {
    private func setupWebView() {
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        guard let urlString = urlStrig, let url = URL(string: urlString) else {
            UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
                self.progressView.alpha = 0.0
            }) { (finished: Bool) in
                self.progressView.setProgress(0.0, animated: false)
            }
            CCQTools.showTextHudWithText(text: "获取数据失败,返回从试", view: self.view)
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
// MARK: - WKNavigationDelegate, WKUIDelegate
extension CCQNewsDetailVC: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
            self.progressView.alpha = 0.0
        }) { (finished: Bool) in
            self.progressView.setProgress(0.0, animated: false)
        }
    }
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if !(navigationAction.targetFrame?.isMainFrame != nil) {
            webView.load(navigationAction.request)
        }
        return nil
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0.0
                }) { (finished: Bool) in
                    self.progressView.setProgress(0.0, animated: false)
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

}
