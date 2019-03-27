//
//  CCQBaseTabBarVC.swift
//  ChaoQunWeiBoDemo
//
//  Created by 信义房屋网络事业部 on 2019/3/14.
//  Copyright © 2019年 常超群. All rights reserved.
//

import UIKit

class CCQBaseTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ///解决pop时候tabbar移动BUG
//        tabBar.isTranslucent = false
    }
}

