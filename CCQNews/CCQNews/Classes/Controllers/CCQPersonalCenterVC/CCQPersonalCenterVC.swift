//
//  CCQPersonalCenterVC.swift
//  CCQNews
//
//  Created by test on 2019/4/6.
//  Copyright © 2019 test1. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
/// 新闻cell
private let personalCenterIDF = "personalCenterIDF"
class CCQPersonalCenterVC: CCQBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var tableViewHeaderView: CCQPersonalCenterHeaderView?
    lazy var viewControllerTitleArray = [["清理缓存", "意见反馈"], ["关于软件"]]
    lazy var imageArr = [["icon_userHeader", "icon_userHeader"], ["icon_userHeader"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        ///在本类的storeBoard文件中的  User Defined Runtime Attributes中新增了fd_prefersNavigationBarHidden = true, 实现了导航条的隐藏
        // Do any additional setup after loading the view.
    }
    ///重写父类的setupUI方法
    override func setupUI() {
        super.setupUI()
        navigationItem.title = "个人中心"
        setupTableView()
    }
}
// MARK: - 设置界面
extension CCQPersonalCenterVC {
    private func setupTableView() {
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "CCQPersonalCenterCell", bundle: nil), forCellReuseIdentifier: personalCenterIDF)
        tableViewHeaderView = Bundle.main.loadNibNamed("CCQPersonalCenterHeaderView", owner: self, options: nil)?.last as? CCQPersonalCenterHeaderView
        tableView.tableHeaderView = tableViewHeaderView
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 55));
        footerView.backgroundColor = UIColor.ccq_color(withHex: "#F1F1F1")
        let button = UIButton(frame: CGRect(x: 0, y: 15, width: UIScreen.main.bounds.width, height: 40))
        button.setTitle("退出登录", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(kCCQAppMainColor, for: .normal)
        button.addTarget(self, action: #selector(logout(sender:)), for: .touchUpInside)
        footerView.addSubview(button)
        tableView.tableFooterView = footerView
    }
    @objc func logout(sender: UIButton) {
        CCQSystemAlertView.showSystemalertView(withTitle: "提示", message: "确定退出此账号?", contentArray: ["取消", "确定"], controller: self) { [weak self](index: Int) in
            CCQUser.shared.updataUser(dict: ["" : "" as AnyObject])
            self?.tabBarController?.selectedIndex = 0
        }
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension CCQPersonalCenterVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewControllerTitleArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllerTitleArray[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: personalCenterIDF, for: indexPath) as! CCQPersonalCenterCell
        cell.titleLabel.text = viewControllerTitleArray[indexPath.section][indexPath.row];
        cell.photoImage.image = UIImage(named: imageArr[indexPath.section][indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = viewControllerTitleArray[indexPath.section][indexPath.row]
        if title == "清理缓存" {
            CCQTools.showTextHudWithText(text: "清理成功", view: view)
        } else if title == "关于软件" {
            let aboutVC = CCQAboutVC(nibName: "CCQAboutVC", bundle: nil)
            navigationController?.pushViewController(aboutVC, animated: true)
        } else if title == "意见反馈" {
            let feedbackVC = CCQFeedbackVC(nibName: "CCQFeedbackVC", bundle: nil)
            navigationController?.pushViewController(feedbackVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        bgView.backgroundColor = UIColor.ccq_color(withHex: "#F1F1F1")
        return bgView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {        tableViewHeaderView?.ccq_scrollDidScroll(scrollView: scrollView)
    }
}
