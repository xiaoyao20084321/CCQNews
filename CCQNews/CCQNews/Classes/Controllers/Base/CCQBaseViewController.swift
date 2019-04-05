//
//  CCQBaseViewController.swift
//  ChaoQunWeiBoDemo
//
//  Created by 信义房屋网络事业部 on 2019/3/14.
//  Copyright © 2019年 常超群. All rights reserved.
//

import UIKit

class CCQBaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
}
// MARK: - 设置界面
extension CCQBaseViewController {
    
    @objc func setupUI() {
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
}
