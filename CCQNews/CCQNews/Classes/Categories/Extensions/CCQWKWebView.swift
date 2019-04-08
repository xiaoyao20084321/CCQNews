//
//  CCQWKWebView.swift
//  CCQNews
//
//  Created by 信义房屋网络事业部 on 2019/4/3.
//  Copyright © 2019 常超群. All rights reserved.
//

import UIKit
import WebKit
class CCQWKWebView: WKWebView {
    required init?(coder: NSCoder) {
        super.init(frame: UIScreen.main.bounds, configuration: WKWebViewConfiguration())
        self.translatesAutoresizingMaskIntoConstraints = false;
    }
}
