//
//  CCQTools.swift
//  CCQNews
//
//  Created by test on 2019/4/1.
//  Copyright © 2019 test1. All rights reserved.
//

import UIKit
import MBProgressHUD
import MJRefresh
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
    
    /// 显示等待提示
    ///
    /// - Parameter view: 在传入的view上显示
    class func showWaitingHudInView(view: UIView) {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    /// 移除等待提示
    ///
    /// - Parameter view: 在传入的view上移除
    class func hideWaitingHudInView(view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    /// 显示文字提示
    ///
    /// - Parameters:
    ///   - text: 传入的文字
    ///   - view: 在传入的view上显示
    class func showTextHudWithText(text:String, view: UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = text
        hud.label.numberOfLines = 0
        hud.hide(animated: true, afterDelay: TimeInterval(1))
    }
    
    /// tableView添加下拉刷新控件
    ///
    /// - Parameters:
    ///   - tableView: 传入的tableView
    ///   - dropDownToRefresh: 闭包回调
    class func addDropDownToRefreshAtTableView(tableView: UITableView, dropDownToRefresh: @escaping ()->()) {
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            dropDownToRefresh()
        })
    }
    
    /// 进入刷新状态
    ///
    /// - Parameter tableView: 传入的tableView
    class func beginDropDownRefreshingAtTableView(tableView: UITableView) {
        tableView.mj_header.beginRefreshing()
    }
    /// 结束刷新状态
    ///
    /// - Parameter tableView: 传入的tableView
    class func endDropDownRefreshingAtTableView(tableView: UITableView) {
        tableView.mj_header.endRefreshing()
    }
    /// tableView添加上拉加载刷新控件
    ///
    /// - Parameters:
    ///   - tableView: 传入的tableView
    ///   - pullToRefresh: 闭包回调
    class func addPullToRefreshAtTableView(tableView: UITableView, pullToRefresh: @escaping ()->()) {
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            pullToRefresh()
        })
    }
    /// 结束上拉加载状态
    ///
    /// - Parameter tableView: 传入的tableView
    class func endPullToRefreshAtTableView(tableView: UITableView) {
        tableView.mj_footer.endRefreshing()
        
    }
    /// 没数据显示没有下一页
    ///
    /// - Parameter tableView: 传入的tableView
    class func endRefreshingWithNoMoreDataAtTableView(tableView: UITableView) {
        tableView.mj_footer.endRefreshingWithNoMoreData()
    }
    ///判断字符串是否为空或者全部为空格
    class func isBlankString(string: String?) -> Bool {
        if string == nil {
            return true
        }
        if string == "" {
            return true
        }
        if string == "NULL" {
            return true
        }
        if string?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0  {
            return true
        }
        return false
    }
}
