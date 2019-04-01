//
//  CCQTools.swift
//  CCQNews
//
//  Created by 信义房屋网络事业部 on 2019/4/1.
//  Copyright © 2019 常超群. All rights reserved.
//

import UIKit

class CCQTools: NSObject {
    /// 得到当前时间N天前后的日期
    ///
    /// - Parameter day: 传入正数 n天后   传入负数 N天前   传入0  当天
    /// - Returns: 时间戳
    class func getTimeStampWithDayNum(dayNum: Int = 0) -> String {
        let nowDate = NSDate()
        var theDate: NSDate
        if dayNum != 0 {
            let oneDay = 24 * 60 * 60 * 1;  //1天的长度
            theDate = nowDate.addingTimeInterval(TimeInterval(oneDay * dayNum))
        } else {
            theDate = nowDate;
        }
        return "\(Int(theDate.timeIntervalSince1970))"
    }
}
