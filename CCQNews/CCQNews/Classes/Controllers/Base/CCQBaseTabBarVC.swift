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
        tabBar.tintColor = kCCQAppMainColor;
        self.delegate = self
    }
}
extension CCQBaseTabBarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == viewControllers?[3] {
            if CCQTools.isBlankString(string: CCQUser.shared.account) {
                ///弹出登录模块
                let naviVC = viewControllers?[selectedIndex] as? CCQBaseNavigationVC
                let loginVC = CCQLoginVC(nibName: "CCQLoginVC", bundle: nil)
                
                loginVC.loginSuccessful = { [weak self] in
                    self?.selectedIndex = 3
                }
                naviVC?.pushViewController(loginVC, animated: true)
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
}

