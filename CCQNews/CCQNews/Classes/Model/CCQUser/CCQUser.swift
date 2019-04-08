//
//  CCQUser.swift
//  CCQNews
//
//  Created by 信义房屋网络事业部 on 2019/4/7.
//  Copyright © 2019 常超群. All rights reserved.
//

import UIKit

class CCQUser: NSObject {
    /// 在第一次访问时，执行闭包，并且将结果保存在 shared 常量中
    static let shared: CCQUser = {
        // 实例化对象
        let instance = CCQUser()
        // 返回对象
        return instance
    }()
    var account: String?
    var password: String?
    func updataUser(dict: [String : AnyObject]) {
        account = dict["account"] as? String
        password = dict["password"] as? String
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(dict, forKey: kCCQUser)
        userDefaults.synchronize()
    }
}
