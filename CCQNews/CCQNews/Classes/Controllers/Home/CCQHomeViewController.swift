//
//  CCQHomeViewController.swift
//  ChaoQunWeiBoDemo
//
//  Created by 信义房屋网络事业部 on 2019/3/14.
//  Copyright © 2019年 常超群. All rights reserved.
//

import UIKit
import AFNetworking
/// 新闻cell
private let newsCellIDF = "newsCellIDF"
class CCQHomeViewController: CCQBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// MARK: - 设置界面
extension CCQHomeViewController {
    ///重写父类的setupUI方法
    override func setupUI() {
        super.setupUI()
        navigationItem.title = "首页"
        setupTableView()
        loadData()
    }
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: newsCellIDF)
    }
    private func loadData() {
        let parameters = ["kw" : "体育资讯", "apikey" : kAPIKEY, "publishDateRange" : "1551398400,1553990400"]
        _ = CCQHttpRequestManager.shared.request(urlString: kNEWSAPI, parameters: parameters as [String : AnyObject]) { (json, isSuccess) in
            if isSuccess {
                guard let jsonData = json as? [String: AnyObject] else {
                    return
                }
                let list = jsonData["data"] as? [[String: AnyObject]]
                for dict in list ?? [] {
                    print(dict["content"] ?? "")
                }
            } else {
                print("网络错误")
            }
        }
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension CCQHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCellIDF, for: indexPath)
        cell.textLabel?.text = "哈哈"
        return cell
    }
}
