//
//  CCQPush+AppDelegate.swift
//  CCQNews
//
//  Created by text on 2019/4/9.
//  Copyright © 2019 text. All rights reserved.
//

import Foundation
extension AppDelegate:JPUSHRegisterDelegate {
    
    
    func addJpush(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // 通知注册实体类
        let entity = JPUSHRegisterEntity();
        entity.types = Int(JPAuthorizationOptions.alert.rawValue) |  Int(JPAuthorizationOptions.sound.rawValue) |  Int(JPAuthorizationOptions.badge.rawValue);
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self);
        // 注册极光推送
        JPUSHService.setup(withOption: launchOptions, appKey: "1714c744997492fea6395684", channel:"Publish channel" , apsForProduction: false);
        // 获取推送消息
        // 如果remote不为空，就代表应用在未打开的时候收到了推送消息
        if let remote = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? Dictionary<String, Any>  {
            ///往UserDefaultsp添加推送参数
            setPushParameterToUserDefault(userInfo: remote)
        }
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
        if let userInfo = notification?.request.content.userInfo  {
            if notification?.request.trigger is UNPushNotificationTrigger {
                ///往UserDefaultsp添加推送参数
                setPushParameterToUserDefault(userInfo: userInfo)
                ///根据保存的参数判断跳转VC,此方法在app主类里面
                jumpVC()
            }
        }
    }
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            ///往UserDefaultsp添加推送参数
            JPUSHService.handleRemoteNotification(userInfo)
            setPushParameterToUserDefault(userInfo: userInfo)
            ///根据保存的参数判断跳转VC,此方法在app主类里面
            jumpVC()
        }
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
            setPushParameterToUserDefault(userInfo: userInfo)
            ///根据保存的参数判断跳转VC,此方法在app主类里面
            jumpVC()
        }
        // 系统要求执行这个方法
        completionHandler()
    }
    
    //系统获取Token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    //获取token 失败
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) { //可选
        print("did Fail To Register For Remote Notifications With Error: \(error)")
    }
    ///往UserDefaultsp添加推送参数
    func setPushParameterToUserDefault(userInfo: [AnyHashable : Any]) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(userInfo["switch"], forKey: "pushUrlSwitch")
        userDefaults.setValue(userInfo["url"], forKey: "pushUrl")
        userDefaults.synchronize()
    }
    
}
