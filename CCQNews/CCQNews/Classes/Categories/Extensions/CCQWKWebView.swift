//
//  CCQWKWebView.swift
//  CCQNews
//
//  Created by test on 2019/4/3.
//  Copyright © 2019 test1. All rights reserved.
//

import UIKit
import WebKit
class CCQWKWebView: WKWebView {
    required init?(coder: NSCoder) {
        super.init(frame: UIScreen.main.bounds, configuration: WKWebViewConfiguration())
        self.translatesAutoresizingMaskIntoConstraints = false;
    }
}
