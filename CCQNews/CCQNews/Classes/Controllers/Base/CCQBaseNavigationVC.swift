//
//  CCQBaseNavigationVC.swift
//  ChaoQunWeiBoDemo
//
//  Created by test on 2019/3/14.
//  Copyright © 2019年 test1. All rights reserved.
//

import UIKit

class CCQBaseNavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 隐藏默认的 NavigationBar
//        navigationBar.isHidden = true
        navigationBar.barTintColor = kCCQAppMainColor;
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    /// 重写 push 方法，所有的 push 动作都会调用此方法！
    /// viewController 是被 push 的控制器，设置他的左侧的按钮作为返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if children.count > 0 {
            // 隐藏底部的 TabBar
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
}

